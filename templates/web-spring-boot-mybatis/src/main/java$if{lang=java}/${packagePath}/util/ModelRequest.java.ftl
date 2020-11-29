package ${packageName}.util;

import ${packageName}.exception.ClientException;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.util.StringUtils;

import java.lang.reflect.Field;

/**
 * Model 非空验证器
 * 主要用于更新接口 和 添加接口 使用同一个 Model 但是对非空检测有差异
 * 添加接口要求验证非空字段
 * 更新接口任何字段都可以为空
 * 要求：需要在 Model 中对非空字段添加 ApiModelProperty 注解，并设置 required=true
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class ModelRequest {

    /**
    * 验证客户端发送的参数中是否有不能为空，但是却没有传的参数
    * @param model 客户端发送参数
    */
    public static void validate(Object model) {
        if (model == null) {
            return;
        }
        try {
            Field[] fields = model.getClass().getDeclaredFields();
            for (Field field : fields) {
                if (field.isAnnotationPresent(ApiModelProperty.class)) {
                    ApiModelProperty annotation = field.getAnnotation(ApiModelProperty.class);
                    if (annotation.required() && !"id".equals(field.getName())) {
                        field.setAccessible(true);
                        Object o = field.get(model);
                        if (o == null || (o instanceof String && StringUtils.isEmpty(o))) {
                            throw new ClientException(annotation.value() + "不能为空");
                        }
                    }
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

}
