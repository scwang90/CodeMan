server.port = 8080
server.address = 0.0.0.0
server.servlet.context-path = /

server.servlet.encoding.charset = UTF-8
server.servlet.encoding.force = true
server.servlet.encoding.enabled = true

logging.level.root = info
logging.level.${packageName}.mapper = info
logging.level.${packageName}.controller = info
logging.level.io.swagger.models.parameters = error
logging.level.org.apache.shiro = error

spring.datasource.url = jdbc:mysql://localhost:3306/database?serverTimezone=Asia/Shanghai
spring.datasource.username = username
spring.datasource.password = password
spring.datasource.type = com.zaxxer.hikari.HikariDataSource

spring.jackson.time-zone = GMT+8
spring.jackson.date-format = yyyy-MM-dd HH:mm:ss

spring.servlet.multipart.max-file-size = 80MB
spring.servlet.multipart.max-request-size = 102400KB

spring.web.resources.chain.cache=false
spring.web.resources.static-locations=./static/,classpath:/META-INF/resources/,classpath:/resources/,classpath:/static/,classpath:/public/

mybatis.configuration.map-underscore-to-camel-case = true
mybatis.mapper-locations = classpath:/mapper/*.xml,classpath:/mapper/**/*.xml

#跨域访问过滤设置
app.cors.allowedOriginPatterns = *localhost*;*127.0.0.1*;*0.0.0.0*

#文档框架测试访问主机（负债均衡/内网穿透并且时需要配置，未配置时使用）
app.swagger.host =
app.swagger.enabled = false

#客户端访问链接（负债均衡/内网穿透并且使用到框架中的上传时需要）
app.client.visit-host =

<#if hasLogin>
#凭证有效时间 (秒钟)
app.auth.token.expiry = 36000
#凭证刷新间隔 (秒钟)
app.auth.token.refresh = 30
</#if>
