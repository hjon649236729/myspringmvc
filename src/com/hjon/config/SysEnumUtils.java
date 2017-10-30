package com.hjon.config;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hjon.modules.common.entity.SysEnum;

/**
 * 根据module,type能确定一个SysEnumList 根据module,type,value能确定一个唯一的SysEnum Map<Map<String,
 * String>, List<SysEnum>>
 * 
 * @author hjon
 * 
 */
public class SysEnumUtils {

	public static Map<Map<String, String>, List<SysEnum>> SysEnum = new HashMap<Map<String, String>, List<SysEnum>>();

	public static List<SysEnum> getSysEnums(String module, String type) {
		Map<String, String> param = new HashMap<String, String>();
		param.put(module, type);
		return SysEnum.get(param);
	}

	public static SysEnum getSysEnum(String module, String type, String value) {
		List<SysEnum> SysEnums = getSysEnums(module, type);
		for (SysEnum eSysEnum : SysEnums) {
			if (value.equals(eSysEnum.getValue())) {
				return eSysEnum;
			}
		}
		return null;
	}

	public static String getSysEnumName(String module, String type, String value) {
		SysEnum sysEnum = getSysEnum(module, type, value);
		if (sysEnum != null) {
			return sysEnum.getName();
		} else {
			return null;
		}
	}
}
