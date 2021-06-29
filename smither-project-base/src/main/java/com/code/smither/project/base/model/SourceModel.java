package com.code.smither.project.base.model;

import com.code.smither.engine.api.Model;
import com.code.smither.engine.api.Task;
import com.code.smither.project.base.api.ClassConverter;
import com.code.smither.project.base.api.LangRootModel;
import com.code.smither.project.base.util.StringUtil;
import lombok.Data;

import java.io.File;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 模板根 Model
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("ALL")
@Data
public class SourceModel implements LangRootModel {

    private Table table;
    private Table organTable;            //机构表
    private Table loginTable;            //用户登录表
    private List<Table> loginTables;     //用户登录表（多表登录）
    private List<Table> tables;          //数据库所有表
    private TableColumn orgColumn;       //机构所在列
    private TableColumn codeColumn;      //编码所在列
    private DatabaseJdbc jdbc;
    private String className;
    private String tableName;
    private String author;
    private String packageName;
    private String packagePath;
    private String projectName;
    private String charset;
    private String dbType;
    private String lang;                //程序设计语言
    private Date now = new Date();
    private Features features;          //特性列表（可以指定使用模板中的某种特性功能或代码）
    private boolean hasCode;            //是否有编码
    private boolean hasOrgan;           //是否有机构 需要同时含有登录、并且登录表中含有机构Id 才算
    private boolean hasLogin;           //是否有登录功能
    private boolean hasMultiLogin;      //是否有多表登录功能
    private boolean hasStringId;        //是否含有字符串Id
    private boolean hasIntegerId;       //时候含有整形Id

    public SourceModel() {
    }

    public SourceModel(String author, String packageName) {
        super();
        this.author = author;
        this.packageName = packageName;
    }

    public SourceModel(Table table) {
        this.table = table;
        this.className = table.getClassName();
    }

    public void setUpNow(String now) {
        if (now != null && now.length() > 0) {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                this.now = dateFormat.parse(now);
            } catch (ParseException e) {
                dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                try {
                    this.now = dateFormat.parse(now);
                } catch (ParseException ex) {
                    ex.printStackTrace();
                    this.now = new Date();
                }
            }
        } else {
            this.now = new Date();
        }
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
        this.packagePath = packageName.replace(".", File.separatorChar + "");
//        this.packagePath = packagePath.replace("::", File.separatorChar + "");
    }

    //<editor-fold desc="接口实现">
    @Override
    public List<? extends Model> getModels() {
        return tables;
    }

    @Override
    public void bindModel(Model model) {
        if (model instanceof Table) {
            this.table = (Table) model;
            this.tableName = ((Table) model).getName();
            this.className = ((Table) model).getClassName();
        }
    }

    @Override
    public void bindClassConverter(ClassConverter converter) {
        if (tables != null) {
            for (Table table : tables) {
                table.setClassName(converter.converterClassName(table.getName()));
                table.setClassNameUpper(table.getClassName().toUpperCase());
                table.setClassNameLower(table.getClassName().toLowerCase());
                table.setClassNameCamel(StringUtil.lowerFirst(table.getClassName()));
                if (table.getColumns() != null) {
                    for (TableColumn column : table.getColumns()) {
                        column.setFieldType(converter.converterFieldType(column));
                        column.setFieldName(converter.converterFieldName(column.getName()));
                        column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
                        column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));
                    }
                }
            }
        }
    }

    @Override
    public boolean isModelTask(Task task) {
        String path = task.getTemplateFile().getAbsolutePath();
        return path.matches(".*\\$\\{(table\\.\\S+?|(class|table)Name)\\S*?}.*");
//        return path.contains("${className}") || path.contains("${tableName}") || path.matches(".*\\$\\{table\\.\\S+?}.*");
    }

    public boolean isHasIntegerId() {
        for (Table table : tables) {
            if (table.isHasId() && table.getIdColumn().isAutoIncrement()) {
                return true;
            }
        }
        return hasStringId;
    }

    public boolean isHasStringId() {
        for (Table table : tables) {
            if (table.isHasId() && table.getIdColumn().isStringType()) {
                return true;
            }
        }
        return hasIntegerId;
    }

    //</editor-fold>
}
