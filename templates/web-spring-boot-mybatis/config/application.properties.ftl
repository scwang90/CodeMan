server.port = 8080
server.address = 0.0.0.0

app.error.original = true
app.swagger.enabled = true

logging.path = logs
logging.level.root = info
logging.level.${packageName}.mapper = debug
logging.level.${packageName}.controller = info
<#if features.has('network')>
logging.level.${packageName}.ok-http = debug
</#if>
logging.level.${packageName}.model.api.ApiResult = trace
logging.level.org.apache.coyote.http11.Http11InputBuffer = debug
logging.level.org.springframework.web.method.HandlerMethod = trace
logging.level.org.springframework.web.servlet.DispatcherServlet = trace
logging.level.org.springframework.web.servlet.mvc.method.annotation = trace

spring.datasource.url = ${jdbc.url}?serverTimezone=Asia/Shanghai
spring.datasource.username = ${jdbc.username}
spring.datasource.password = ${jdbc.password}

app.cors.allowedOriginPatterns = *
