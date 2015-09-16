package com.codesmither.model;

import java.util.List;
import java.util.Map;

/**
 * 表索引
 * @author Administrator
 */
public class TableIndex {
	public String indexName; // 索引名称
	public List<String> carrayNames;// 原关联字段
	public List<String> carrayNames_d;// 大写关联字段
	public List<String> carrayNames_x;// 小写关联字段
	public List<Map<String, String>> carrayNameMaps;// 原字段+小写字段
	public String stringCarrayNames1;// 直接拼接大写字段
	public String stringCarrayNames2;// ","拼接大写字段
	public String stringCarrayNames3;// 类型+ ","拼接大写字段
	public String stringCarrayNames4;// ","拼接小写字段
	public String stringCarrayNames5;// sqlMap中sql用的 原字段-小写字段
	public boolean unique; // 是否唯一索引
}
