package com.generator.excel2db.model;

import java.util.Arrays;
import java.util.List;

/**
 * 爱家服务
 * Created by SCWANG on 2016/12/19.
 */
public class Service {

    public String Name;

    public List<Item> Items;

    public static class Item {
        public String Name;
        public String Remark;

        public Item(String name, String remark) {
            Name = name;
            Remark = remark;
        }

        @Override
        public String toString() {
            return "Item{" +
                    "Name='" + Name + '\'' +
                    ", Remark='" + Remark + '\'' +
                    '}';
        }
    }

    @Override
    public String toString() {
        return "Service{" +
                "Name='" + Name + '\'' +
                ", Items=" + Arrays.toString(Items.toArray()) +
                '}';
    }
}
