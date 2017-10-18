package com.hjon.config;

import com.hjon.modules.common.entity.CommonEnum;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 根据module,type能确定一个CommonEnumList 
 * 根据module,type,value能确定一个唯一的Enum  
 * Map<Map<String, String>, List<CommonEnum>>
 * 
 * @author hjon
 * 
 */
public class CommonEnumUtils {

	public static Map<Map<String, String>, List<CommonEnum>> commonEnum = new HashMap<Map<String, String>, List<CommonEnum>>();

	public static List<CommonEnum> getCommonEnums(String module, String type) {
		Map<String, String> param = new HashMap<String, String>();
		param.put(module, type);
		return commonEnum.get(param);
	}

	public static CommonEnum getCommonEnum(String module, String type,
			String value) {
		List<CommonEnum> commonEnums = getCommonEnums(module, type);
		for (CommonEnum commonEnum : commonEnums) {
			if (value.equals(commonEnum.getValue())) {
				return commonEnum;
			}
		}
		return null;
	}

	public static String getCommonEnumName(String module, String type,
			String value) {
		CommonEnum commonEnum = getCommonEnum(module, type, value);
		if (commonEnum != null) {
			return commonEnum.getName();
		} else {
			return null;
		}
	}
}
