package com.hjon.modules.workflow.service;

import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.dao.CriterionCollection;
import com.hjon.common.service.BaseService;
import com.hjon.modules.workflow.entity.ProcessStep;

/**
 * WfExamplestep entity. @author MyEclipse Persistence Tools
 */
@Service
@Transactional
public class ProcessStepService extends BaseService<ProcessStep> {

	public List<ProcessStep> getSingleStepList(Integer processid) {
		CriterionCollection search = new CriterionCollection();
		search.Add(Restrictions.eq("processid", processid));
		search.Add(Restrictions.in("status", new Integer[] { 1, 2, 3 }));
		return this.getAll(search, Order.asc("sort"));
	}
}