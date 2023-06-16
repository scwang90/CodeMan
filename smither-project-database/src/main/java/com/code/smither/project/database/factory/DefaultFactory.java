package com.code.smither.project.database.factory;

import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.api.DbFactory;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Setter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@Data
@AllArgsConstructor
@Setter(AccessLevel.PRIVATE)
public class DefaultFactory implements DbFactory {

    private DataBaseConfig config;

    @Override
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(config.getDbUrl(), config.getDbUsername(), config.getDbPassword());
    }

}
