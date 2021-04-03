server.port = 8080
server.address = 0.0.0.0

logging.path = logging
logging.level.root = info

app.swagger.enabled = true

logging.level.root = info
logging.level.${packageName}.mapper = debug
logging.level.${packageName}.controller = info

spring.datasource.url = ${jdbc.url}
spring.datasource.username = ${jdbc.username}
spring.datasource.password = ${jdbc.password}

