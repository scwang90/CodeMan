server.port = 8080
server.address = 0.0.0.0

logging.level.root = info
logging.level.${packageName}.mapper = info
logging.level.${packageName}.controller = info

spring.datasource.url = ${jdbc.url}
spring.datasource.username = ${jdbc.username}
spring.datasource.password = ${jdbc.password}
spring.datasource.type = com.alibaba.druid.pool.DruidDataSource

spring.jackson.date-format=yyyy-MM-dd HH:mm:ss
spring.jackson.time-zone=GMT+8

mybatis.mapper-locations=classpath:/mapper/*.xml