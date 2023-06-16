package com.code.smither.project.database.factory;

import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.api.DbFactory;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import lombok.*;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * @author SCWANG
 * @since 2023/6/14
 */
@Data
@RequiredArgsConstructor
@Setter(AccessLevel.PRIVATE)
public class SshDbFactory implements DbFactory {

    private Session session = null;
    private String jdbcUrl = null;
    private final DataBaseConfig config;

    @Override
    public Connection getConnection() throws SQLException {
        Session session = confirmSession();
        String jdbcUrl = confirmPort(session);
        Properties props = new Properties();
        props.setProperty("user", config.getDbUsername());
        props.setProperty("password", config.getDbPassword());
        props.setProperty("useSSL", "false");
        return DriverManager.getConnection(jdbcUrl, props);
    }

    private String confirmPort(Session session) {
        if (jdbcUrl == null) {
            try {
                URI uri = new URI(config.getDbUrl().replace("jdbc:", ""));
                int forwardedPort = session.setPortForwardingL(0, uri.getHost(), uri.getPort());
                jdbcUrl = config.getDbUrl()
                        .replace(uri.getHost(), "localhost")
                        .replace(String.valueOf(uri.getPort()), String.valueOf(forwardedPort));
                Thread.sleep(3000);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        return jdbcUrl;
    }

    private Session confirmSession() {
        if (session == null) {
            try {
                JSch jsch = new JSch();
                Session session = jsch.getSession(config.getSshUser(), config.getSshHost(), config.getSshPort());
                session.setPassword(config.getSshPassword());
                session.setConfig("StrictHostKeyChecking", "no");
                session.connect();
                this.session = session;
            } catch (JSchException e) {
                throw new RuntimeException(e);
            }
        }
        return session;
    }
}
