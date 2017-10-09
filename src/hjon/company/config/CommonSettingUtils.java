package hjon.company.config;

import hjon.company.modules.common.entity.CommonSetting;

import java.util.HashMap;
import java.util.Map;
public class CommonSettingUtils {
	//map<map<module,name>,Setting>
	public static Map<Map<String, String>, CommonSetting> commonSetting=new HashMap<Map<String,String>, CommonSetting>();
	public static CommonSetting getCommonSetting(String module,String name){
		Map<String,String> param=new HashMap<String, String>();
		param.put(module, name);
		return commonSetting.get(param);
	}
	

}