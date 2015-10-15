package ${packagename}.controller.base;

import ${packagename}.util.AfReflecter;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.*;

/**
 * Controller 层基类
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class BaseController {

	protected void bindModel(Model model, HttpServletRequest request) {
//		String title = "XXX后台管理系统";
//		model.addAttribute("title", title);
	}

	/**
	 * 将对象列表转成 map列表 用于Json过滤
	 *
	 * @param list     对象列表
	 * @param includes 包含转换的字段
	 * @return map 列表
	 * @throws Exception includes 中的参数错误
	 */
	protected List<Map<String, Object>> mapInclude(List<? extends Object> list, String[] includes) throws Exception {
		List<Map<String, Object>> map = new ArrayList<>();
		for (Object model : list) {
			map.add(mapInclude(model, includes));
		}
		return map;
	}

	/**
	 * 将对象转成 map 用于Json过滤
	 *
	 * @param model    对象
	 * @param includes 包含转换的字段
	 * @return map
	 * @throws Exception includes 中的参数错误
	 */
	protected Map<String, Object> mapInclude(Object model, String[] includes) throws Exception {
		Map<String, Object> map = new HashMap<>();
		if (model != null) {
			for (String include : includes) {
				map.put(include, AfReflecter.getMember(model, include));
			}
		}
		return map;
	}

	/**
	 * 将对象列表转成 map列表 用于Json过滤
	 *
	 * @param list     对象列表
	 * @param excludes 包含转换的字段
	 * @return map 列表
	 * @throws Exception includes 中的参数错误
	 */
	protected List<Map<String, Object>> mapExclude(List<? extends Object> list, String[] excludes) throws Exception {
		List<Map<String, Object>> map = new ArrayList<>();
		String[] includes = null;
		for (Object model : list) {
			if (model != null && includes == null) {
				includes = getInclude(model.getClass(), excludes);
			}
			map.add(mapInclude(model, includes));
		}
		return map;
	}

	/**
	 * 把 excludes 转成 includes
	 *
	 * @param clazz    model 类型
	 * @param excludes excludes
	 * @return includes
	 */
	private String[] getInclude(Class<? extends Object> clazz, String[] excludes) {
		List<String> ltInclude = new ArrayList<>();
		List<String> ltExclude = new ArrayList<>(Arrays.asList(excludes));
		Field[] fields = AfReflecter.getField(clazz);
		for (Field field : fields) {
			if (!Modifier.isStatic(field.getModifiers()) && !Modifier.isTransient(field.getModifiers())) {
				boolean include = true;
				for (int i = 0; i < ltExclude.size(); i++) {
					if (field.getName().equals(ltExclude.get(i))) {
						ltExclude.remove(i);
						include = false;
						break;
					}
				}
				if (include) ltInclude.add(field.getName());
			}
		}
		return ltInclude.toArray(new String[0]);
	}

}
