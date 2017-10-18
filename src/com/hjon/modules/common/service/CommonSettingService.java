package com.hjon.modules.common.service;

import com.hjon.common.service.BaseService;
import com.hjon.modules.common.entity.CommonSetting;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CommonSettingService extends BaseService<CommonSetting> {
	public CommonSetting getSettingByModuleAndName(String module, String name) {
		List<CommonSetting> settingList = this.query(
				"from CommonSetting where module=? and name=?", new Object[] {
						module, name });
		if (settingList != null && settingList.size() > 0) {
			return settingList.get(0);
		}
		return null;

	}
}
