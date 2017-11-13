package com.hjon.modules.workflow.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.workflow.entity.FlowNode;

/**
 * WfExamplestep entity. @author MyEclipse Persistence Tools
 */
@Service
@Transactional
public class FlowNodeService extends BaseService<FlowNode> {

	public List<FlowNode> findFlowNode(int processid) {
		// TODO Auto-generated method stub
		return this.queryByProperty("processid", processid);
	}

}