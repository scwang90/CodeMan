package com.generator.qiniu;

import com.qiniu.api.auth.AuthException;
import com.qiniu.api.auth.digest.Mac;
import com.qiniu.api.config.Config;
import com.qiniu.api.io.IoApi;
import com.qiniu.api.io.PutExtra;
import com.qiniu.api.io.PutRet;
import com.qiniu.api.rs.PutPolicy;
import io.reactivex.Observable;
import io.reactivex.ObservableSource;
import io.reactivex.annotations.NonNull;
import io.reactivex.functions.Consumer;
import io.reactivex.functions.Function;
import org.json.JSONException;

import java.io.File;

/**
 * 七牛云上传主程序
 * Created by SCWANG on 2017/3/29.
 */
public class Main {

    public static void main(String[] args) throws AuthException, JSONException {
        Config.ACCESS_KEY = "wH8hcesRya32clbVYPUPpocDprqweWALmRp_qe4F";
        Config.SECRET_KEY = "0cFvgm_nWDlmsg3zx-dKfvVQOhTzUvo_aqYkgQM5";

        Mac mac = new Mac(Config.ACCESS_KEY, Config.SECRET_KEY);
        // 请确保该bucket已经存在
        String bucketName = "poetry";
        PutPolicy putPolicy = new PutPolicy(bucketName);
        String uptoken = putPolicy.token(mac);

        System.out.println(uptoken);
//        PutExtra extra = new PutExtra();
//        String key = "<key>";
//        String localFile = "<local file path>";
//        PutRet ret = IoApi.putFile(uptoken, key, localFile, extra);
//
//        System.out.println(ret);
    }

    void list() {
        String path = "src\\main\\resources\\poetry\\backs";
        Observable.just(path)
                .map(new Function<String, File>() {
            @Override
            public File apply(@NonNull String s) throws Exception {
                return new File(s);
            }
        }).flatMap(new Function<File, Observable<File>>() {
            @Override
            public Observable<File> apply(@NonNull File file) throws Exception {
                return Observable.fromArray(file.listFiles());
            }
        }).forEach(new Consumer<File>() {
            @Override
            public void accept(@NonNull File file) throws Exception {

            }
        });
    }
}
