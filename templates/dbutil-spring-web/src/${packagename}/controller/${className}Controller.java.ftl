package ${packagename}.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ${packagename}.controller.base.GeneralController;
import ${packagename}.model.${className};

/**
 * ${table.remark}Controller
 * @author ${author}
 */
@Controller
@RequestMapping("/${className}")
public class ${className}Controller extends GeneralController<${className}>{


}
