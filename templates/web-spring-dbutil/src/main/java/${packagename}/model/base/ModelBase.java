package ${packagename}.model.base;

import ${packagename}.annotations.Must;
import ${packagename}.util.AfReflecter;
import ${packagename}.util.AfStringUtil;
import ${packagename}.util.ServiceException;

import java.lang.reflect.Field;

/**
 * model 基类
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class ModelBase {
    /**
     * 检测是否满足必须参数
     */
    public void check() throws Exception{
        Field[] fields = AfReflecter.getFieldAnnotation(this.getClass(), Must.class);
        for (Field field:fields){
            String name = field.getName() + ":" + field.getAnnotation(Must.class).value();
            Object val = AfReflecter.getMemberNoException(this, field.getName());
            if (val == null || AfStringUtil.isEmpty(val.toString())){
                throw new ServiceException("缺少参数["+name+"]");
            }
        }
    }
}
