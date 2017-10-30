package com.hjon.modules.common.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.common.entity.SysEnum;

@Service
@Transactional
public class SysEnumService extends BaseService<SysEnum> {
	public SysEnum getSysEnum(String module, String type, String value) {
		List<SysEnum> sysEnumList = this.query(
				"from SysEnum where module=? and type=? and value=?",
				new Object[] { module, type, value });
		if (sysEnumList != null && sysEnumList.size() > 0) {
			return sysEnumList.get(0);
		}
		return null;
	}

	public List<SysEnum> findSysEnums(String module, String type) {
		List<SysEnum> sysEnumList = this.query(
				"from SysEnum where module=? and type=?", new Object[] {
						module, type });
		return sysEnumList;
	}

	public List<SysEnum> findSysEnums(String module, String type, String p) {
		List<SysEnum> sysEnumList = this
				.query("from SysEnum where module=? and type=? and(name like ? or shortPinYin like ? or fullPinYin like ?)",
						new Object[] { module, type, p + "%", p + "%", p + "%" });
		return sysEnumList;
	}

}
