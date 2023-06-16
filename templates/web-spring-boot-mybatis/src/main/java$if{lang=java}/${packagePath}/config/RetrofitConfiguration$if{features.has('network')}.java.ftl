package ${packageName}.config;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import ${packageName}.model.conf.OkHttpConfig;
import ${packageName}.model.conf.ThirdPartConfig;
import ${packageName}.network.*;
import ${packageName}.util.HttpLoggingInterceptor;
import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import retrofit2.Retrofit;
import retrofit2.converter.jackson.JacksonConverterFactory;

import javax.net.ssl.*;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.util.concurrent.TimeUnit;

/**
 * 配置类 - OkHttp、Retrofit 网络请求配置
 * @author 树朾
 * @since 2021-11-16 中国标准时间
 */
@Configuration
public class RetrofitConfiguration {

    /**
     * ok-http 注入
     */
    @Bean
    public OkHttpClient okHttpClient(@Autowired OkHttpConfig config) throws NoSuchAlgorithmException, KeyManagementException {
        Logger logger = LoggerFactory.getLogger("${packageName}.ok-http");
        Interceptor interceptor = new HttpLoggingInterceptor(logger::debug){{setLevel(Level.BODY);}};
        X509TrustManager manager = new X509TrustManager() {
            @Override
            public void checkClientTrusted(X509Certificate[] x509Certificates, String s) {}
            @Override
            public void checkServerTrusted(X509Certificate[] x509Certificates, String s) {}
            @Override
            public X509Certificate[] getAcceptedIssuers() {
                return new X509Certificate[0];
            }
        };
        SSLContext sslContext = SSLContext.getInstance("SSL");
        sslContext.init(null, new TrustManager[]{manager}, new SecureRandom());
        OkHttpClient.Builder builder = new OkHttpClient.Builder();
        if (config.isProxyEnable()) {
            builder.proxy(new Proxy(Proxy.Type.HTTP, new InetSocketAddress(config.getProxyHost(), config.getProxyPort())));
        }
        return builder
                .connectTimeout(5, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
                .addNetworkInterceptor(interceptor)
                .sslSocketFactory(sslContext.getSocketFactory(), manager)
                .hostnameVerifier((s, sslSession) -> true)
                .build();
    }

    @Bean
    public JacksonConverterFactory jacksonConverterFactory(ObjectMapper mapper) {
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,false);
        return JacksonConverterFactory.create(mapper);
    }

    @Bean
    public ServiceApi serviceApi(OkHttpClient client, JacksonConverterFactory factory) {
        return new Retrofit.Builder()
                .client(client)
                .baseUrl("http://localhost:8080/")
                .addConverterFactory(factory)
                .build().create(ServiceApi.class);
    }

}