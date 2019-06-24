package ${packageName}.annotations.dbmodel.interpreter;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import ${packageName}.annotations.dbmodel.Column;
import ${packageName}.annotations.dbmodel.DbIgnore;
import ${packageName}.annotations.dbmodel.Id;
import ${packageName}.annotations.dbmodel.Table;
import ${packageName}.util.AfStringUtil;

/**
 * db.annotation 解释器
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class Interpreter {
	
	/**
	 * 获取field是否是数据库列
	 */
	public static boolean isColumn(Field field) {
		int modify = field.getModifiers();
		return !Modifier.isFinal(modify) && !Modifier.isStatic(modify) 
				&& !Modifier.isTransient(modify) 
				&& !field.isAnnotationPresent(DbIgnore.class);
	}
	/**
	 * 获取field的列名称
	 */
	public static String getColumnName(Field field) {
		if (field.isAnnotationPresent(Column.class)) {
			Column column = field.getAnnotation(Column.class);
			if (AfStringUtil.isNotEmpty(column.value())) {
				return column.value();
			}
		}
		if (field.isAnnotationPresent(Id.class)) {
			Id id = field.getAnnotation(Id.class);
			if (AfStringUtil.isNotEmpty(id.value())) {
				return id.value();
			}
		}
		return field.getName();
	}
	/**
	 * 获取clazz数据表名称
	 */
	public static String getTableName(Class<?> clazz) {
		if (clazz.isAnnotationPresent(Table.class)) {
			Table table = clazz.getAnnotation(Table.class);
			if (table.value().length() > 0) {
				return table.value();
			}
		}
		return clazz.getSimpleName();
	}
	/**
	 * 获取clazz的主键ID名称
	 */
	public static String getIdName(Class<?> clazz) {
		Field field = getIdField(clazz);
		if (field != null) {
			Id id = field.getAnnotation(Id.class);
			if (id == null || id.value().trim().length() == 0) {
				return field.getName();
			}
			return id.value();
		}
		return "ID";
	}

	/**
	 * 获取clazz的主键ID名称
	 */
	public static Field getIdField(Class<?> clazz) {
		List<Field> fields = new ArrayList<Field>();
		while (!clazz.equals(Object.class)) {
			for (Field field : clazz.getDeclaredFields()) {
				fields.add(field);
			}
			clazz = clazz.getSuperclass();
		}
		List<Field> cloumns = new ArrayList<Field>();
		for (Field field : fields) {
			if (isColumn(field)) {
				if (isPrimaryKey(field)) {
					return field;
				}
				cloumns.add(field);
			}
		}
		for (Field field : cloumns) {
			String name = field.getName().toLowerCase(Locale.ENGLISH);
			if (name.endsWith("id")) {
				return field;
			}
		}
		return null;
	}

	/**
	 * 判断 Field 是否为 ID字段
	 */
	public static boolean isPrimaryKey(Field field) {
		return field.isAnnotationPresent(Id.class)
				|| (field.isAnnotationPresent(Column.class)
				&& field.getAnnotation(Column.class).id());
	}

}
