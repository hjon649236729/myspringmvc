package com.hjon.modules.workflow.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.workflow.entity.FlowDots;

/**
 * WfExamplestep entity. @author MyEclipse Persistence Tools
 */
@Service
@Transactional
public class FlowDotsService extends BaseService<FlowDots> {

	public List<FlowDots> findFlowDots(Integer processid) {
		// TODO Auto-generated method stub
		return this.queryByProperty("pathid", processid);
	}

}