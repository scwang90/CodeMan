package com.codesmither.engine;

import org.junit.Test;

/**
 * TempleteTest
 * Created by Administrator on 2015/9/16.
 */
public class TempleteTest {

    @Test
    public void Templete() {
        try {
            Engine engine = new Engine();
            engine.doInBackground(System.out);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
