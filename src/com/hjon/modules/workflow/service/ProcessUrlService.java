package com.hjon.modules.workflow.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.workflow.entity.ProcessUrl;

/**
 * WfExamplestep entity. @author MyEclipse Persistence Tools
 */
@Service
@Transactional
public class ProcessUrlService extends BaseService<ProcessUrl> {

	public List<Map<String, Object>> getProcessUrlListByType(int type) {
		StringBuffer sql = new StringBuffer();
		sql.append("select pu.id as keyvalue,pu.name ");
		sql.append("from WF_PROCESSURL pu ");
		sql.append("where pu.status=1 ");
		Map<String, Object> _params = new HashMap<String, Object>();
		if (type > 0) {
			sql.append("and (pu.type=:type or pu.type=0) ");
			_params.put("type", Integer.valueOf(type));
		} else if (type == -1) {
			sql.append("and pu.type>0 ");
		}

		return this.createSqlQueryToMapList(sql.toString(), _params);
	}
}