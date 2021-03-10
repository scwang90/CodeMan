server.port = 8080
server.address = 0.0.0.0
server.servlet.context-path = /

logging.level.root = info
logging.level.${packageName}.mapper = info
logging.level.${packageName}.controller = info

spring.datasource.url = ${jdbc.url}
spring.datasource.username = ${jdbc.username}
spring.datasource.password = ${jdbc.password}
spring.datasource.type = com.alibaba.druid.pool.DruidDataSource

spring.jackson.date-format=yyyy-MM-dd HH:mm:ss
spring.jackson.time-zone=GMT+8

spring.servlet.multipart.max-file-size = 80MB
spring.servlet.multipart.max-request-size= 102400KB

mybatis.mapper-locations=classpath:/mapper/*.xml,classpath:/mapper/**/*.xml

#文档框架测试访问主机（负债均衡/内网穿透并且时需要配置，未配置时使用）
swagger.host=
swagger.enabled=false

#客户端访问链接（负债均衡/内网穿透并且使用到框架中的上传时需要）
client.visit-host=

#凭证有效时间 (秒钟)
auth.token.expiry = 36000
#凭证刷新间隔 (秒钟)//小程序网络框架未能实现更新token，把刷新时间关闭
auth.token.refresh = 30
