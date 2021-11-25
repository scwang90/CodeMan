package com.code.smither.project.database.impl;

import com.code.smither.project.base.constant.Database;
import com.code.smither.project.database.api.DbFactory;

/**
 * Sqlite 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class SqLiteTableSource extends DefaultDataSource {


    private Database database = new SqLiteDatabase();

    public SqLiteTableSource(DbFactory dbFactory) {
        this(dbFactory, false);
    }

    private SqLiteTableSource(DbFactory dbFactory, boolean autoclose) {
        super(dbFactory, autoclose);
    }

    @Override
    public Database getDatabase() {
        return database;
    }

    public static class SqLiteDatabase extends DefaultDatabase {

        static String keywords = "ABORT,ACTION,ADD,AFTER,ALL,ALTER,ANALYZE,AND,AS,ASC,ATTACH,AUTOINCREMENT,BEFORE,BEGIN,BETWEEN,BY,CASCADE,CASE,CAST,CHECK,COLLATE,COLUMN,COMMIT,CONFLICT,CONSTRAINT,CREATE,CROSS,CURRENT_DATE,CURRENT_TIME,CURRENT_TIMESTAMP,DATABASE,DEFAULT,DEFERRABLE,DEFERRED,DELETE,DESC,DETACH,DISTINCT,DROP,EACH,ELSE,END,ESCAPE,EXCEPT,EXCLUSIVE,EXISTS,EXPLAIN,FAIL,FOR,FOREIGN,FROM,FULL,GLOB,GROUP,HAVING,IF,IGNORE,IMMEDIATE,IN,INDEX,INDEXED,INITIALLY,INNER,INSERT,INSTEAD,INTERSECT,INTO,IS,ISNULL,JOIN,KEY,LEFT,LIKE,LIMIT,MATCH,NATURAL,NO,NOT,NOTNULL,NULL,OF,OFFSET,ON,OR,ORDER,OUTER,PLAN,PRAGMA,PRIMARY,QUERY,RAISE,REFERENCES,REGEXP,REINDEX,RELEASE,RENAME,REPLACE,RESTRICT,RIGHT,ROLLBACK,ROW,SAVEPOINT,SELECT,SET,TABLE,TEMP,TEMPORARY,THEN,TO,TRANSACTION,TRIGGER,UNION,UNIQUE,UPDATE,USING,VACUUM,VALUES,VIEW,VIRTUAL,WHEN,WHERE";

        SqLiteDatabase() {
            super(keywords.split(","));
        }

        @Override
        public String name() {
            return "sqlite";
        }
        @Override
        public String wrapperKeyword(String name) {
            return '`' + name + '`';
        }
    }
}

