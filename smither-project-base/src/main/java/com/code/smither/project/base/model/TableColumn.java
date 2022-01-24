package com.code.smither.project.base.model;

import com.code.smither.project.base.api.MetaDataColumn;
import com.code.smither.project.base.constant.Database;
import lombok.*;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 模板Model-table-column
 * Created by SCWANG on 2015-07-04.
 */
@SuppressWarnings("unused")
@Data
public class TableColumn implements MetaDataColumn {
	
	private String name;// 原名称
	private String nameSql;// SQL语句中使用的名称
	private String nameSqlInStr;// SQL语句中使用的名称（在字符串拼接中使用）
	private String type;// 字段类型名称（数据库返回的值）
	private String typeJdbc;// 字段类型名称（JDBC 枚举，所有数据库一致性，java.sql.Types 枚举所有的类型）
	private String remark;// 字段注释
	private String remarkName;//备注名称（与remark的区别时不已'列'结尾）
	private String defValue;// 字段注释
	private String description;//详细描述（分析得到）
	private String comment;//原始备注（remark+description）

	private int length;//列长度
	private int typeInt;//数据库列类型
	private int decimalDigits;//小数位数
	private int clientLength;//客户端长度（用于指导前端模板填写预留长度）

	private String fieldName;// 字段
	private String fieldNameUpper;// 首字母大写
	private String fieldNameLower;// 首字母小写
	private String fieldType;// 字段类型
	private String fieldTypeObject;// 字段类型-对象类型（如 Integer Short）
	private String fieldTypePrimitive;// 字段类型-基础类型（如 int short）
	private String fieldJavaType;//java 字段类型
	private String fieldCSharpType;//C# 字段类型
	private String fieldKotlinType;//kotlin 字段类型
	private String fieldTypeScriptType;//TypeScript 字段类型
	private String fieldJavaTypePrimitive;//java 字段类型
	private String fieldCSharpTypePrimitive;//C# 字段类型
	private String fieldKotlinTypePrimitive;//kotlin 字段类型
	private String fieldTypeScriptTypePrimitive;//TypeScript 字段类型

	private boolean nullable;//允许null
	private boolean autoIncrement;//是否自增
	private boolean primaryKey;//是否是 PrimaryKey
	private boolean stringType;//是否是 string类型
	private boolean dateType;//是否是 Date类型
	private boolean timeType;//是否是 时间类型
	private boolean boolType;//是否是 Bool类型
	private boolean intType;//是否是 Int 类型
	private boolean longType;//是否是 Long 类型
	private boolean hasDefValue;//是否有默认值
	private boolean forceUseLong;//是否对前端强制使用Long型
	private boolean hiddenForSubmit;//是否对提交需要隐藏
	private boolean hiddenForClient;//是否对前端需要隐藏
	private boolean hiddenForTables;//是否对前端需要隐藏 - 表格

	private List<EnumValue> enums;		//枚举值
	private List<String> descriptions;	//多行详细描述

	@Override
	public String getName() {
		return name;
	}

	@Override
	public void setName(String name) {
		if (name == null) {
			name = "";
		}
		this.name = name;
		this.setNameSql(name);
	}

	public void setNameSql(String nameSql) {
		this.nameSql = nameSql;
		this.nameSqlInStr = this.nameSql.replace("\"","\\\"");
	}

//	public void setName(String name, Database database) {
//		this.name = name;
//		this.nameSql = name;
//		this.nameSqlInStr = name;
//		if (database != null && database.isKeyword(name)) {
//			this.nameSql = database.wrapperKeyword(name);
//			this.nameSqlInStr = this.nameSql.replace("\"","\\\"");
//		}
//	}

	@Override
	public void setType(String type) {
		if (type == null) {
			type = "";
		}
		this.type = type;
	}

	public void setTypeJdbc(String typeJdbc) {
		if (typeJdbc == null) {
			typeJdbc = "";
		}
		this.typeJdbc = typeJdbc;
	}

	@Override
	public void setComment(String comment) {
		this.comment = comment;
		this.setRemark(comment);
	}

	public void setRemark(String remark) {
		if (remark == null) {
			remark = "";
		}
		Pattern pattern = Pattern.compile("[(（]length=(\\d+)[)）]");
		Matcher matcher = pattern.matcher(remark);
		if (matcher.find()) {
			remark = remark.replaceAll("[(（]length=(\\d+)[)）]", "");
			this.clientLength = Integer.parseInt(matcher.group(1));
		}
		this.remark = remark;
		this.remarkName = remark.trim();
		if (remark.endsWith("列")) {
			this.remarkName = remark.substring(0, remark.length() - 1);
		}
		if (remark.startsWith("是否已经")) {
			this.remarkName = remark.substring(4);
		} else if (remark.startsWith("是否已")) {
			this.remarkName = remark.substring(3);
		} else if (remark.startsWith("是否")) {
			this.remarkName = remark.substring(2);
		}
	}

	@Override
	public void setDefValue(String defValue) {
		if (defValue == null) {
			defValue = "";
		}
		this.defValue = defValue;
	}

	public void setDescription(String description) {
		this.description = description;
		this.descriptions = Arrays.asList(description.split("\n"));
		this.enums = findEnums(this.descriptions);
	}

	public void setFieldName(String fieldName) {
		if (fieldName == null) {
			fieldName = "";
		}
		this.fieldName = fieldName;
	}

	public void setFieldNameUpper(String fieldNameUpper) {
		if (fieldNameUpper == null) {
			fieldNameUpper = "";
		}
		this.fieldNameUpper = fieldNameUpper;
	}

	public void setFieldNameLower(String fieldNameLower) {
		if (fieldNameLower == null) {
			fieldNameLower = "";
		}
		this.fieldNameLower = fieldNameLower;
	}

	public void setFieldType(String fieldType) {
		if (fieldType == null) {
			fieldType = "";
		}
		this.fieldType = fieldType;
	}

	public void setFieldJavaType(String fieldJavaType) {
		if (fieldJavaType == null) {
			fieldJavaType = "";
		}
		this.fieldJavaType = fieldJavaType;
	}

	public void setFieldCSharpType(String fieldCSharpType) {
		if (fieldCSharpType == null) {
			fieldCSharpType = "";
		}
		this.fieldCSharpType = fieldCSharpType;
	}

	public int getClientLength() {
		return clientLength == 0 ? length : clientLength;
	}

	public boolean isNotNull() {
		return !this.nullable;
	}

	public boolean isHasEnums() { return isIntType() && this.enums != null && this.enums.size() > 1; }

	private static Pattern enumPattern = Pattern.compile("(\\d+)[ :：]?(\\S+?)\\b");
	private List<EnumValue> findEnums(List<String> descriptions) {
		//操作类型(1注册,2登录,3重置密码,4修改手机)
		List<EnumValue> enums = new LinkedList<>();
		for (String desc : descriptions) {
			Matcher matcher = enumPattern.matcher(desc);
			while (matcher.find()) {
				enums.add(new EnumValue(Integer.parseInt(matcher.group(1)), matcher.group(2)));
			}
			if (enums.size() > 1) {
				break;
			} else {
				enums.clear();
			}
		}
		return enums;
	}
}
