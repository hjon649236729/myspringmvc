package com.hjon.modules.workflow.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.workflow.entity.ProcessList;

/**
 * WfExamplestep entity. @author MyEclipse Persistence Tools
 */
@Service
@Transactional
public class ProcessListService extends BaseService<ProcessList> {

	public Map<String, Object> findParaByNameAndKey(String name, int key) {
		Map<String, Object> params = new HashMap<String, Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select pl.key,pl.value,pl.name,pl.valueads ");
		sql.append("from WF_PROCESSLIST pl ");
		sql.append("where pl.name=:name and pl.key=:key");
		params.put(name, name);
		params.put("key", key);
		List<Map<String, Object>> list = this.createSqlQueryToMapList(
				sql.toString(), params);
		if (list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}
}