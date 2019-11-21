package com.code.smither.project.base.constant;

public interface Database {

    String name();
    boolean isKeyword(String value);
    String wrapperKeyword(String name);

    enum Type {
        MySQL("mysql"), Oracle("oracle"), SQLServer("sqlserver"), SQLite("sqlite"), Unknown("unknown");
        public static final String PATTERN_MYSQL = "jdbc:mysql:.*";
        public static final String PATTERN_ORACLE = "jdbc:oracle:.*";
        public static final String PATTERN_SQL_LITE = "jdbc:sqlite:.*";
        public static final String PATTERN_SQL_SERVER = "jdbc:sqlserver:.*";
        public final String remark;
        Type(String remark) {
            this.remark = remark;
        }

        public static Type fromJdbcUrl(String jdbcUrl) {
            if (jdbcUrl == null) {
                return Unknown;
            } else if (jdbcUrl.matches(PATTERN_MYSQL)) {
                return MySQL;
            } else if (jdbcUrl.matches(PATTERN_ORACLE)) {
                return Oracle;
            } else if (jdbcUrl.matches(PATTERN_SQL_SERVER)) {
                return SQLServer;
            } else if (jdbcUrl.matches(PATTERN_SQL_LITE)) {
                return SQLite;
            }
            return Unknown;
        }
    }
}
