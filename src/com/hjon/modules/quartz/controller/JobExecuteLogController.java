package com.hjon.modules.quartz.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hjon.common.bean.Page;
import com.hjon.common.controller.BaseController;
import com.hjon.common.dao.CriterionCollection;
import com.hjon.common.utils.NumberUtils;
import com.hjon.modules.quartz.service.JobExecuteLogService;

@Controller
@Scope("prototype")
public class JobExecuteLogController extends BaseController {

	@Resource(name = "jobExecuteLogService")
	private JobExecuteLogService jobExecuteLogService;
	Logger logger = Logger.getLogger(QuartzController.class);

	@RequestMapping("quartz/jobexecuteloglist")
	public String list() {
		int pageNum = NumberUtils
				.safeToInteger(this.getParameter("pageNum"), 1);
		int numPerPage = NumberUtils.safeToInteger(
				this.getParameter("numPerPage"), 10);
		String orderField = this.getParameter("orderField");
		String orderDirection = this.getParameter("orderDirection");
		Order order = Order.desc("startTime");
		CriterionCollection search = new CriterionCollection();
		if (orderField != null && !orderField.equals("")) {
			if (orderDirection.toLowerCase().equals("asc")) {
				order = Order.asc(orderField);
				this.setAttribute("orderDirection", "asc");
			} else {
				order = Order.desc(orderField);
				this.setAttribute("orderDirection", "desc");
			}
			this.setAttribute("orderField", orderField);
		}
		Page data = new Page();
		String jobName = this.getParameter("jobName");
		if (jobName != null && !"".equals(jobName)) {
			search.Add(Expression.eq("name", jobName));
			this.setAttribute("jobName", jobName);
			data = jobExecuteLogService.pagedQuery(pageNum, numPerPage, search,
					order);
		}
		this.setAttribute("data", data);
		return "quartz/jobexecuteloglist";
	}

}
