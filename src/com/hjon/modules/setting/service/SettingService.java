package com.hjon.modules.setting.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.setting.entity.Setting;

@Service
@Transactional
public class SettingService extends BaseService<Setting> {
	public Setting getSetting(String module, String name) {
		List<Setting> settingList = this.query(
				"from Setting where module=? and name=?", new Object[] {
						module, name });
		if (settingList != null && settingList.size() > 0) {
			return settingList.get(0);
		}
		return null;

	}
}
