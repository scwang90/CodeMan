package com.codesmither.engine.impl;

import com.codesmither.engine.api.EmptyFieldFiller;
import com.codesmither.engine.api.IRootModel;
import com.codesmither.engine.util.Reflecter;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

/**
 * 默认空字段填充器
 * Created by SCWANG on 2016/8/19.
 */
public class DefaultEmptyFieldFiller implements EmptyFieldFiller {

    @Override
    public IRootModel fill(IRootModel model) {
        fill((Object) model);
        return model;
    }

    private void fill(Object model) {
        Field[] fields = Reflecter.getField(model.getClass());
        for (Field field : fields) {
            if (!Modifier.isTransient(field.getModifiers()) && !Modifier.isStatic(field.getModifiers()) && !field.getName().startsWith("this$")) {
                try {
                    field.setAccessible(true);
                    Object value = field.get(model);
                    Class<?> type = field.getType();
                    if (value == null) {
                        if (Integer.class.equals(type)) {
                            field.set(model, 0);
                        } else if (Short.class.equals(type)) {
                            field.set(model, 0);
                        } else if (Long.class.equals(type)) {
                            field.set(model, 0L);
                        } else if (Float.class.equals(type)) {
                            field.set(model, 0f);
                        } else if (Double.class.equals(type)) {
                            field.set(model, 0D);
                        } else if (String.class.equals(type)) {
                            field.set(model, "");
                        } else if (List.class.equals(type)) {
                            field.set(model, new ArrayList<Objects>());
                        } else if (type.isArray()) {
                            field.set(model, new Object[0]);
                        }
                    } else if (type.isArray()) {
                        Object[] array = (Object[]) value;
                        for (Object item : array) {
                            fill(item);
                        }
                    } else if (Collection.class.isAssignableFrom(type)) {
                        Collection<?> collection = (Collection<?>) value;
                        for (Object item : collection) {
                            fill(item);
                        }
                    } else if (!type.isEnum()&&!type.isPrimitive()&&!type.getName().startsWith("java.lang.")) {
                        fill(value);
                    }
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
