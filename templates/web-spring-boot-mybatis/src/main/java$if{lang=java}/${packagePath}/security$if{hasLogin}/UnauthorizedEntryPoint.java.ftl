package ${packageName}.security;

import ${packageName}.constant.ResultCode;
import ${packageName}.model.api.ApiResult;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@AllArgsConstructor
public class UnauthorizedEntryPoint implements AuthenticationEntryPoint {

    private ObjectMapper mapper;

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) {
        ApiResult<Object> result = ApiResult.fail(ResultCode.Unauthorized);
        response.setStatus(HttpStatus.OK.value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        try {
            PrintWriter writer = response.getWriter();
            writer.print(mapper.writeValueAsString(result));
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}