server.port = 8080
server.address = 0.0.0.0

logging.level.root = info
logging.level.${packageName}.mapper = info
logging.level.${packageName}.controller = info

spring.datasource.url = ${jdbc.url}
spring.datasource.username = ${jdbc.username}
spring.datasource.password = ${jdbc.password}

spring.jackson.date-format=yyyy-MM-dd HH:mm:ss
spring.jackson.time-zone=GMT+8

mybatis.configuration.map-underscore-to-camel-case=true
mybatis.mapper-locations=classpath:/mapper/*.xml,classpath:/mapper/**/*.xml
<#if hasLogin>

#凭证有效时间 (秒钟)
app.auth.token.expiry = 36000
#凭证刷新间隔 (秒钟)
app.auth.token.refresh = 30
</#if>