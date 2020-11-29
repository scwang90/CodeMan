package ${packageName}.util;

import com.github.houbb.bean.mapping.api.core.ICondition;
import com.github.houbb.bean.mapping.api.core.IContext;

/**
 * Bean 拷贝条件 - 非空才进行拷贝
 * 主要用于添加接口 和 更新接口
 * 把客户端传过来对参数 拷贝到 数据库 model 中
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class NotNullCondition implements ICondition {

    @Override
    public boolean condition(IContext context) {
        return context.getCurrentSourceField().getValue() != null;
    }

}