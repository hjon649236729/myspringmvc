package com.hjon.modules.common.service;

import com.hjon.common.service.BaseService;
import com.hjon.modules.common.entity.CommonEnum;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CommonEnumService extends BaseService<CommonEnum> {
	public CommonEnum getCommonEnum(String module, String type, String value) {
		List<CommonEnum> commonEnumList = this.query(
				"from CommonEnum where module=? and type=? and value=?",
				new Object[] { module, type, value });
		if (commonEnumList != null && commonEnumList.size() > 0) {
			return commonEnumList.get(0);
		}
		return null;
	}

	public List<CommonEnum> findCommonEnums(String module, String type) {
		List<CommonEnum> commonEnumList = this.query(
				"from CommonEnum where module=? and type=?", new Object[] {
						module, type });
		return commonEnumList;
	}

	public List<CommonEnum> findCommonEnums(String module, String type, String p) {
		List<CommonEnum> commonEnumList = this
				.query("from CommonEnum where module=? and type=? and(name like ? or shortPinYin like ? or fullPinYin like ?)",
						new Object[] { module, type, p + "%", p + "%", p + "%" });
		return commonEnumList;
	}
	
}
