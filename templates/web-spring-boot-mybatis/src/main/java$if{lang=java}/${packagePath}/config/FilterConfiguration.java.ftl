package ${packageName}.config;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.catalina.connector.CoyoteInputStream;
import org.apache.catalina.connector.InputBuffer;
import org.apache.coyote.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import org.springframework.lang.NonNull;

/**
 * 配置类 - 注入过滤器
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
public class FilterConfiguration {

    /**
     * JSON 参数过滤器，可以支持吧客户端发送的Json数据以Query或者Form方式接受
     */
    @Bean
    public FilterRegistrationBean<Filter> jsonParamFilterBean(@Autowired ObjectMapper jackson) {
        FilterRegistrationBean<Filter> bean = new FilterRegistrationBean<>();
        bean.setOrder(1);
        bean.setName("jsonParamFilter");
        bean.addUrlPatterns("/api/*");
        bean.setFilter(new JsonParamFilter(jackson));
        return bean;
    }

    /**
    * Json参数解析过滤器
    * 过滤器可以让 表单参数也可以接收 Json 请求
    */
    public static class JsonParamFilter implements Filter {

        private static Logger log  = LoggerFactory.getLogger(JsonParamFilter.class);

        private ObjectMapper jackson;

        public JsonParamFilter(ObjectMapper jackson) {
            this.jackson = jackson;
        }

        private static class JsonParamHttpRequest extends HttpServletRequestWrapper {

            private List<String> names = null;
            private Map<String, String[]> map  = null;
            private final JsonNode node;
            private final ServletInputStream stream;

            JsonParamHttpRequest(HttpServletRequest request, ServletInputStream stream, JsonNode node) {
                super(request);
                this.node = node;
                this.stream = stream;
            }

            @Override
            public ServletInputStream getInputStream() {
                return stream;
            }


            @Override
            public Map<String, String[]> getParameterMap()  {
                if (map == null) {
                    map = new LinkedHashMap<>();
                    Enumeration<String> names = getParameterNames();
                    while (names.hasMoreElements()) {
                        String name = names.nextElement();
                        map.put(name, getParameterValues(name));
                    }
                }
                return map;
            }

            @NonNull
            @Override
            public Enumeration<String> getParameterNames() {
                List<String> names = this.names;
                if (names != null) {
                    return Collections.enumeration(names);
                }

                List<String> list = new LinkedList<>(treefieldNames(this.node, null));
                Enumeration<String> supers = super.getParameterNames();
                if (supers != null) {
                    while (supers.hasMoreElements()) {
                        list.add(supers.nextElement());
                    }
                }
                this.names = list;
                return Collections.enumeration(list);
            }

            @Override
            public String getParameter(String name) {
                JsonNode valNode = treeNodeValue(node, name);
                if (valNode != null) {
                    return valueFromNode(valNode);
                }
                return super.getParameter(name);
            }

            @Override
            public String[] getParameterValues(String name) {
                JsonNode valNode = treeNodeValue(node, name);
                if (valNode != null) {
                    if (valNode.isArray()) {
                        List<String> names = new LinkedList<>();
                        for (JsonNode node : valNode) {
                            names.add(valueFromNode(node));
                        }
                        return names.toArray(new String[0]);
                    } else {
                        return new String[]{valueFromNode(valNode)};
                    }
                }
                return super.getParameterValues(name);
            }

            private String valueFromNode(JsonNode value) {
                if (value == null || value.isNull()) {
                    return "";
                } else if (value.isTextual()) {
                    return value.textValue();
                } else if (value.isArray()) {
                    StringBuilder builder = new StringBuilder();
                    for (JsonNode jsonNode : value) {
                        if (builder.length() > 0) {
                            builder.append(',');
                        }
                        builder.append(valueFromNode(jsonNode));
                    }
                    return builder.toString();
                } else {
                    return value.toPrettyString();
                }
            }

            public List<String> treefieldNames(JsonNode node, String current) {
                Iterator<String> iterator = node.fieldNames();
                if (iterator == null) {
                    return Collections.emptyList();
                }
                List<String> all = new LinkedList<>();
                while (iterator.hasNext()) {
                    String name = iterator.next();
                    JsonNode valNode = node.get(name);
                    String key = name;
                    if (current != null) {
                        key = current + "." + name;
                    }
                    if (valNode.isObject()) {
                        all.addAll(treefieldNames(valNode, key));
                    } else {
                        all.add(key);
                    }
                }
                return all;
            }

            public JsonNode treeNodeValue(JsonNode node, String path) {
                JsonNode valNode = node.get(path);
                if (valNode != null) {
                    return valNode;
                }
                int dot = path.indexOf('.');
                if (dot > 0) {
                    valNode = node.get(path.substring(0, dot));
                    if (valNode != null) {
                        return treeNodeValue(valNode, path.substring(dot + 1));
                    }
                }
                return null;
            }

        }

        @Override
        public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
            ServletRequest useRequest = request;
            if (request instanceof HttpServletRequest && request.getContentLength() > 0) {
                String contentType = request.getContentType();
                if (contentType != null && contentType.startsWith(MediaType.APPLICATION_JSON_VALUE)) {
                    MediaType mediaType = MediaType.parseMediaType(contentType);
                    Charset charset = mediaType.getCharset();
                    if (charset == null) {
                        charset =  StandardCharsets.UTF_8;
                    }
                    BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream(), charset));
                    String json = reader.lines().collect(Collectors.joining(""));

                    InputBuffer input = new InputBuffer(32);
                    input.setByteBuffer(ByteBuffer.wrap(json.getBytes(charset)));
                    input.setRequest(new Request());
                    useRequest = new JsonParamHttpRequest(((HttpServletRequest) request), new CoyoteInputStream(input) {  }, jackson.readTree(json));
                }
            }
            chain.doFilter(useRequest, response);
        }
    }
}
