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

	public List<Map<String, Object>> findParaByNameAndKey(String name, int key) {
		Map<String, Object> params = new HashMap<String, Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select pl.key,pl.value,pl.name,pl.valueads ");
		sql.append("from WF_PROCESSLIST pl ");
		sql.append("where pl.name=:name and pl.key=:key");
		params.put("name", name);
		params.put("key", key);
		List<Map<String, Object>> list = this.createSqlQueryToMapList(
				sql.toString(), params);
		return list;
	}

	public List<Map<String, Object>> findParaListByName(String name) {
		Map<String, Object> params = new HashMap<String, Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select pl.key,pl.value,pl.name,pl.valueads ");
		sql.append("from WF_PROCESSLIST pl ");
		sql.append("where pl.status=1 and pl.name=:name");
		sql.append(" order by pl.sort");
		params.put("name", name);
		List<Map<String, Object>> list = this.createSqlQueryToMapList(
				sql.toString(), params);
		return list;
	}
}