package com.hjon.modules.workflow.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.workflow.entity.FlowPaths;

/**
 * WfExamplestep entity. @author MyEclipse Persistence Tools
 */
@Service
@Transactional
public class FlowPathsService extends BaseService<FlowPaths> {

	public List<FlowPaths> findFlowPaths(int processid) {
		// TODO Auto-generated method stub
		return this.queryByProperty("processid", processid);
	}

}