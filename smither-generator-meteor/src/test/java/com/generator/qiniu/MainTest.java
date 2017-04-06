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
import io.reactivex.Observer;
import io.reactivex.annotations.NonNull;
import io.reactivex.functions.Consumer;
import io.reactivex.functions.Function;
import io.reactivex.functions.Predicate;
import org.json.JSONException;
import org.junit.Before;
import org.junit.Test;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintStream;

import static org.junit.Assert.*;

/**
 *
 * Created by SCWANG on 2017/3/29.
 */
public class MainTest {

    private String uptoken;

    @Before
    public void init() throws AuthException, JSONException {
        Config.ACCESS_KEY = "wH8hcesRya32clbVYPUPpocDprqweWALmRp_qe4F";
        Config.SECRET_KEY = "0cFvgm_nWDlmsg3zx-dKfvVQOhTzUvo_aqYkgQM5";

        Mac mac = new Mac(Config.ACCESS_KEY, Config.SECRET_KEY);
        // 请确保该bucket已经存在
        String bucketName = "poetry";
        PutPolicy putPolicy = new PutPolicy(bucketName);
        uptoken = putPolicy.token(mac);
    }

    @Test
    public void testBacks() throws Exception {

        String toppath = "src\\main\\resources\\poetry";
        String path = toppath + "\\backs";

        StringBuilder list = new StringBuilder();
        Observable<File> backs = Observable.just(path).map(File::new)
                .flatMap(file -> Observable.fromArray(file.listFiles()))
                .filter(file -> !file.getName().equals("list.html"));

        backs.forEach(file -> {
            list.append(file.getName());
            list.append("\r\n");
        });

        String listfile = path + "\\list.html";
        try (PrintStream print = new PrintStream(listfile,"utf-8")){
            print.print(list.toString());
        }

        Observable<File> allfile = backs.concatWith(Observable.just(new File(listfile)))
                .flatMap(new Function<File, ObservableSource<File>>() {
            @Override
            public ObservableSource<File> apply(@NonNull File file) throws Exception {
                Observable<File> just = Observable.just(file);
                File[] files = file.listFiles();
                if (files != null && files.length > 0) {
                    for (File child : files) {
                        just = just.concatWith(apply(child));
                    }
                }
                return just;
            }
        }).filter(File::isFile);

        System.out.println(list);

        String basepath = new File(toppath).getAbsolutePath();
        allfile.forEach(file -> {

            PutExtra extra = new PutExtra();
            String key = file.getAbsolutePath().replace(basepath,"").substring(1).replaceAll("#\\w+\\$\\d+","").replaceAll("\\\\","/");
            String localFile = file.getAbsolutePath();
            PutRet ret = IoApi.putFile(uptoken, key, localFile, extra);
            System.out.println(file.getAbsolutePath() + "- ret:" + ret);
        });
    }


    @Test
    public void testFonts() throws Exception {

        String toppath = "src\\main\\resources\\poetry";
        String path = toppath + "\\fonts";

        StringBuilder list = new StringBuilder();
        Observable<File> backs = Observable.just(path).map(File::new)
                .flatMap(file -> Observable.fromArray(file.listFiles()))
                .filter(file -> !file.getName().equals("list.html"));

        backs.forEach(file -> {
            list.append(file.getName());
            list.append("\r\n");
        });

        String listfile = path + "\\list.html";
        try (PrintStream print = new PrintStream(listfile,"utf-8")){
            print.print(list.toString());
        }

        Observable<File> allfile = backs.concatWith(Observable.just(new File(listfile)))
                .flatMap(new Function<File, ObservableSource<File>>() {
                    @Override
                    public ObservableSource<File> apply(@NonNull File file) throws Exception {
                        Observable<File> just = Observable.just(file);
                        File[] files = file.listFiles();
                        if (files != null && files.length > 0) {
                            for (File child : files) {
                                just = just.concatWith(apply(child));
                            }
                        }
                        return just;
                    }
                }).filter(File::isFile);

        System.out.println(list);

        String basepath = new File(toppath).getAbsolutePath();
        allfile.forEach(file -> {

            PutExtra extra = new PutExtra();
            String key = file.getAbsolutePath().replace(basepath,"").substring(1).replaceAll("#[\\w\\.]+\\$\\d+","").replaceAll("\\\\","/");
            String localFile = file.getAbsolutePath();
            PutRet ret = IoApi.putFile(uptoken, key, localFile, extra);

            System.out.println(localFile + "- ret:" + ret);
        });
    }
}