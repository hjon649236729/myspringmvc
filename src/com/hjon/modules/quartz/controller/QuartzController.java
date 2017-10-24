package com.hjon.modules.quartz.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hjon.common.bean.Page;
import com.hjon.common.controller.BaseController;
import com.hjon.common.quartz.LocalQuartzManager;
import com.hjon.common.utils.NumberUtils;
import com.hjon.modules.quartz.entity.JobInfo;
import com.hjon.modules.quartz.service.JobExecuteLogService;
import com.hjon.modules.quartz.service.QuartzService;

@Controller
@Scope("prototype")
public class QuartzController extends BaseController {

	@Resource(name = "quartzService")
	private QuartzService quartzService;

	@Resource(name = "jobExecuteLogService")
	private JobExecuteLogService jobExecuteLogService;
	Logger logger = Logger.getLogger(QuartzController.class);

	@RequestMapping("quartz/quartzlist")
	public String list() {

		int pageNum = NumberUtils
				.safeToInteger(this.getParameter("pageNum"), 1);
		int numPerPage = NumberUtils.safeToInteger(
				this.getParameter("numPerPage"), 10);
		Map<String, Object> params = new HashMap<String, Object>();
		String jobName=this.getParameter("jobName");
		if(StringUtils.isNotBlank(jobName)){
			params.put("JOB_NAME", jobName);
			this.setAttribute("jobName", jobName);
		}
		Page data = quartzService.searchQuartz(pageNum, numPerPage, params);
		this.setAttribute("data", data);
		
		return "common/quartz/quartzlist";

	}

	@RequestMapping("quartz/quartzsave")
	@ResponseBody
	public String quartzsave() {
		String planName = this.getParameter("planName");
		try {
			String planname = this.getParameter("planName");
			String cronExpression = this.getParameter("time");
			String jobClass = this.getParameter("jobClass");
			// String jobtype = "DEFAULT";
			String memo = this.getParameter("memo");
			// String status = this.getParameter("status");
			// String oldtypefunc = this.getParameter("oldtypefunc");
			// 原调度名称（带编号）
			String triggerName = this.getParameter("triggername");
			JobInfo job = new JobInfo();
			job.setJobName(planname);
			job.setJobGroupName(planname);
			job.setJobDescription(memo + "########$$%%:" + jobClass
					+ "########$$%%:" + cronExpression);

			job.setJobClass(Class.forName(jobClass));

			job.setTriggerName(planname);
			job.setTriggerGroupName(planname);
			job.setTriggerDescription(memo + "########$$%%:" + jobClass
					+ "########$$%%:" + cronExpression);

			job.setCron(cronExpression);
			if (quartzService.validatejobName(planname, planname)) {
				return "调度名称已存在";
			}
			int reqtype = NumberUtils.safeToInteger(
					this.getParameter("reqtype"), 0);
			if (reqtype == 0) {
				LocalQuartzManager.addJob(job);
			} else {
				String oldJobName = this.getParameter("oldJobName");
				LocalQuartzManager.modifyJob(oldJobName, oldJobName,
						oldJobName, oldJobName, job);
			}

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			logger.error(e);
			return "系统错误，请联系管理员";
		}

		return "success";
	}

	@RequestMapping("quartz/quartzdelete")
	@ResponseBody
	public String quartzdelete() {

		return "success";

	}

	@RequestMapping("quartz/quartzpause")
	@ResponseBody
	public String quartzpause() {

		return "success";

	}

	@RequestMapping("quartz/quartzstart")
	@ResponseBody
	public String quartzstart() {

		return "success";

	}
}
