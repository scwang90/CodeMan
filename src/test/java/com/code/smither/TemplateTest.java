package com.code.smither;

//import com.code.smither.project.base.model.Table;
import org.junit.Test;

/**
 * TemplateTest
 * Created by Administrator on 2015/9/16.
 */
public class TemplateTest {

    @Test
    public void testHashCode() {
        System.out.println("\"\".hashCode() = " + "".hashCode());
        System.out.println("\"\".hashCode() = " + "".hashCode());
        System.out.println("new Object().hashCode()) = " + new Object().hashCode());
        System.out.println("new Object().hashCode()) = " + new Object().hashCode());
    }

//    @Test
//    public void testTableModel() {
//        System.out.println(new Table());
//    }
}
