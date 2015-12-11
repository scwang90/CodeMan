package ${packagename}.model.base;

import ${packagename}.annotations.Must;
import ${packagename}.annotations.dbmodel.interpreter.Interpreter;
import ${packagename}.util.AfReflecter;
import ${packagename}.util.AfStringUtil;
import ${packagename}.util.ServiceException;

import java.lang.reflect.Field;
import java.util.UUID;

/**
 * model 基类
 * @author 树朾
 * @date 2015-09-30 18:37:15 中国标准时间
 */
public class ModelBase {
    /**
     * 检测是否满足必须参数
     */
    public void check() throws Exception{
        check(this);
    }

    public static void check(Object model) {
        Field[] fields = AfReflecter.getFieldAnnotation(model.getClass(), Must.class);
        for (Field field:fields){
            String name = field.getName() + ":" + field.getAnnotation(Must.class).value();
            Object val = AfReflecter.getMemberNoException(model, field.getName());
            if (val == null || AfStringUtil.isEmpty(val.toString())){
                throw new ServiceException("缺少参数["+name+"]");
            }
        }
    }

    /**
     * 检查ID字段是否为空，否则设置一个新ID
     */
    public void fillNullID() {
        fillNullID(this);
    }

    /**
     * 检查ID字段是否为空，否则设置一个新ID
     * @param model 数据model
     */
    public static void fillNullID(Object model) {
        Class<?> clazz = model.getClass();
        Field field = Interpreter.getIdField(clazz);
        if (field != null) {
            field.setAccessible(true);
            try {
                Object id = field.get(model);
                if(id == null || id.toString().trim().length() == 0){
                    field.set(model, UUID.randomUUID().toString());
                }
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
    }

}
