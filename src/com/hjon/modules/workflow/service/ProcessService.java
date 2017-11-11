package com.hjon.modules.workflow.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.bean.Page;
import com.hjon.common.service.BaseService;
import com.hjon.common.utils.StringUtils;
import com.hjon.modules.workflow.entity.ProcessInfo;

/**
 * WfExamplestep entity. @author MyEclipse Persistence Tools
 */
@Service
@Transactional
public class ProcessService extends BaseService<ProcessInfo> {

	@Resource(name = "processService")
	private ProcessService processService;

	@Resource(name = "flowDotsService")
	private FlowDotsService flowDotsService;

	@Resource(name = "flowNodeService")
	private FlowNodeService flowNodeService;

	@Resource(name = "flowPathsService")
	private FlowPathsService flowPathsService;

	public Page searchProcess(int pageNum, int numberPage,
			Map<String, Object> params) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT p.id, p.name, p.status, pl.value AS statusname, p.processcode, pl2.value AS processtypename, p.processtype, p.processbrief, p.sysversion, p.phoneshow");
		sql.append(" FROM WF_PROCESS p LEFT JOIN WF_PROCESSLIST pl ON pl.NAME = 'ProcessStatus' AND p.STATUS = pl.KEY");
		sql.append(" LEFT JOIN WF_PROCESSLIST pl2 ON pl2.NAME = 'ProcessType' AND p.processtype = pl2.KEY");
		sql.append(" WHERE (p.status = 1 OR p.status = 2)");

		if (StringUtils.isNotBlank(params.get("status"))) {
			sql.append(" AND p.status = :status");
		}

		if (StringUtils.isNotBlank(params.get("processType"))) {
			sql.append("AND p.processtype=:processType");
		}
		return this.pagedQuery(sql.toString(), pageNum, numberPage, params);
	}
}