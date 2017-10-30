package com.hjon.config;

import java.util.HashMap;
import java.util.Map;

import com.hjon.modules.common.entity.Setting;

public class SettingUtils {
	// map<map<module,name>,Setting>
	public static Map<Map<String, String>, Setting> Setting = new HashMap<Map<String, String>, Setting>();

	public static Setting getSetting(String module, String name) {
		Map<String, String> param = new HashMap<String, String>();
		param.put(module, name);
		return Setting.get(param);
	}

}