package com.hjon.modules.quartz.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionException;
import org.quartz.JobKey;
import org.quartz.SchedulerException;
import org.quartz.TriggerKey;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hjon.common.bean.Page;
import com.hjon.common.controller.BaseController;
import com.hjon.common.quartz.LocalQuartzManager;
import com.hjon.common.utils.NumberUtils;
import com.hjon.modules.quartz.entity.JobExecuteLog;
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
		int numberPage = NumberUtils.safeToInteger(
				this.getParameter("numPerPage"), 10);
		Map<String, Object> params = new HashMap<String, Object>();
		String jobName = this.getParameter("jobName");
		if (StringUtils.isNotBlank(jobName)) {
			params.put("JOB_NAME", "%" + jobName + "%");
			this.setAttribute("jobName", jobName);
		}
		Page data = quartzService.searchQuartz(pageNum, numberPage, params);
		this.setAttribute("data", data);

		return "quartz/quartzlist";

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
	public String quartzdelete() throws SchedulerException {
		String jobName = this.getParameter("jobName");
		LocalQuartzManager.removeJob(jobName, jobName, jobName, jobName);
		return "success";
	}

	@RequestMapping("quartz/quartzpause")
	@ResponseBody
	public String quartzpause() {
		String jobName = this.getParameter("jobName");
		try {
			LocalQuartzManager.pauseJob(new JobKey(jobName, jobName));

			return "success";
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			logger.error(e);
			return "停止失败";
		}

	}

	@RequestMapping("quartz/quartzresume")
	@ResponseBody
	public String quartzstart() {
		String jobName = this.getParameter("jobName");
		try {
			LocalQuartzManager.resumeTrigger(TriggerKey.triggerKey(jobName,
					jobName));
			return "success";
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			logger.error(e);
			return "重启失败";
		}

	}

	@RequestMapping("quartz/quartzexecuteFunction")
	@ResponseBody
	public String quartzexecuteFunction() {
		String jobName = this.getParameter("jobName");
		String jobClass = this.getParameter("jobClass");
		List<JobExecuteLog> log = jobExecuteLogService.getJobExecuteLog(
				jobName, 1);
		if (log != null && log.size() > 0) {
			return "该任务正在执行，不能重复执行";
		} else {
			JobExecuteLog sirmJobExecuteLog = new JobExecuteLog();
			sirmJobExecuteLog.setName(jobName);
			sirmJobExecuteLog.setStartTime(new Date());
			sirmJobExecuteLog.setType(2);
			// sirmJobExecuteLog.setEmpid(Integer.parseInt(RequestContext.getCurrentUser().getOrgId()));
			sirmJobExecuteLog.setStatus(1);
			// CommonServiceFactory.getSirmJobExecuteLogService().saveJobExecuteLog(sirmJobExecuteLog);
			jobExecuteLogService.saveOrUpdate(sirmJobExecuteLog);
			try {
				((Job) Class.forName(jobClass).newInstance()).execute(null);
				sirmJobExecuteLog.setEndTime(new Date());
				sirmJobExecuteLog.setStatus(2);
				jobExecuteLogService.saveOrUpdate(sirmJobExecuteLog);
				// CommonServiceFactory.getSirmJobExecuteLogService().saveJobExecuteLog(sirmJobExecuteLog);
			} catch (JobExecutionException e) {
				logger.error(jobName + "执行失败：" + jobClass, e);
				return "执行失败";
				// TODO Auto-generated catch block
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				logger.error(jobName + "执行失败：" + jobClass, e);
				return "执行失败";
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				logger.error(jobName + "执行失败：" + jobClass, e);
				return "执行失败";
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				logger.error(jobName + "找不到执行的代码：" + jobClass, e);
				return "找不到执行的代码";
			} finally {
				List<JobExecuteLog> executeLogs = jobExecuteLogService
						.getJobExecuteLog(jobName, 1);
				// List<ISirmJobExecuteLog> executeLogs =
				// CommonServiceFactory.getSirmJobExecuteLogService().getSirmJobExecuteLogs(jobname,
				// 1);
				if (executeLogs != null && executeLogs.size() > 0) {
					for (JobExecuteLog executeLog : executeLogs) {
						executeLog.setStatus(3);
						jobExecuteLogService.saveOrUpdate(executeLog);
						// CommonServiceFactory.getSirmJobExecuteLogService().saveJobExecuteLog(executeLog);
					}
				}
			}

		}

		return "success";

	}
}
