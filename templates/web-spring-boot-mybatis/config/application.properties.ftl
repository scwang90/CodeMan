server.port = 8080
server.address = 0.0.0.0

app.error.original = true
app.swagger.enabled = true

logging.path = logs
logging.level.root = info
logging.level.${packageName}.mapper = debug
logging.level.${packageName}.controller = info
logging.level.org.apache.coyote.http11 = debug
logging.level.org.springframework.web.method = trace
logging.level.org.springframework.web.servlet = trace

spring.datasource.url = ${jdbc.url}?serverTimezone=Asia/Shanghai
spring.datasource.username = ${jdbc.username}
spring.datasource.password = ${jdbc.password}

app.cors.allowedOriginPatterns = *
