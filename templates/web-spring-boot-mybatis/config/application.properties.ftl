server.port = 8080
server.address = 0.0.0.0

app.config.debug = true

logging.level.root = info
logging.level.${packageName}.mapper = info
logging.level.${packageName}.controller = info

spring.datasource.url = ${jdbc.url}
spring.datasource.username = ${jdbc.username}
spring.datasource.password = ${jdbc.password}

