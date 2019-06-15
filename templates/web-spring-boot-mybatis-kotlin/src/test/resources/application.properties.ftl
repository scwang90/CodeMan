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
