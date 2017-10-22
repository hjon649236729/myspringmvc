package com.hjon.common.quartz;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobListener;
import org.quartz.Trigger;
import org.quartz.Trigger.CompletedExecutionInstruction;
import org.quartz.TriggerListener;

import com.hjon.common.utils.SpringContextUtil;
import com.hjon.modules.quartz.entity.JobExecuteLog;
import com.hjon.modules.quartz.service.JobExecuteLogService;

public class LocalTriggerListener implements TriggerListener, JobListener {

	Logger logger = Logger.getLogger(LocalTriggerListener.class);
	private Map threadMap = new HashMap();
	// @Resource
	JobExecuteLogService jobExecuteLogService;

	public LocalTriggerListener() {
		jobExecuteLogService = SpringContextUtil
				.getBean("jobExecuteLogService");
	}

	@Override
	public void jobExecutionVetoed(JobExecutionContext arg0) {
		// TODO Auto-generated method stub
		// logger.info("jobExecutionVetoed");
	}

	@Override
	public void jobToBeExecuted(JobExecutionContext arg0) {
		// TODO Auto-generated method stub
		// logger.info("jobToBeExecuted");
	}

	@Override
	public void jobWasExecuted(JobExecutionContext jobExecutionContext,
			JobExecutionException e) {
		if (threadMap != null && threadMap.get(Thread.currentThread()) != null) {
			if (e != null) {
				JobExecuteLog jobExecuteLog = (JobExecuteLog) threadMap
						.get(Thread.currentThread());
				try {
					jobExecuteLog.setEndTime(new Date());
					jobExecuteLog.setStatus(3);
					jobExecuteLogService.saveOrUpdate(jobExecuteLog);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
				/*
				 * LocalQuartzManager.updateStatus(jobExecutionContext
				 * .getJobDetail().getName(), 2);
				 */

			} else {
				JobExecuteLog jobExecuteLog = (JobExecuteLog) threadMap
						.get(Thread.currentThread());
				try {
					jobExecuteLog.setEndTime(new Date());
					jobExecuteLog.setStatus(2);
					jobExecuteLogService.saveOrUpdate(jobExecuteLog);
				} catch (Exception ex) {
					logger.error("jobWasExecuted failed.["
							+ jobExecutionContext.getTrigger().getJobKey()
									.getName() + "]", e);
				}
				// LocalQuartzManager.updateRunTime(jobExecutionContext
				// .getTrigger().getJobName(), 2);
				// LocalQuartzManager.updateStatus(jobExecutionContext
				// .getTrigger().getJobName(), 1);
			}
		}
		// logger.info("jobWasExecuted");
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		// logger.info("getName");
		return "LocalTriggerListener";
	}

	@Override
	public void triggerComplete(Trigger arg0, JobExecutionContext arg1,
			CompletedExecutionInstruction arg2) {
		// logger.info("triggerComplete");
		// TODO Auto-generated method stub

	}

	@Override
	public void triggerFired(Trigger trigger,
			JobExecutionContext jobExecutionContext) {

		JobExecuteLog sirmJobExecuteLog = new JobExecuteLog();
		JobDataMap jobDataMap = jobExecutionContext.getMergedJobDataMap();
		sirmJobExecuteLog.setName(trigger.getJobKey().getName());
		sirmJobExecuteLog.setStartTime(new Date());
		if (jobDataMap != null && jobDataMap.get("executeType") != null
				&& jobDataMap.get("executeType").equals("hand")
				&& jobDataMap.get("empid") != null) {
			sirmJobExecuteLog.setType(2);
			sirmJobExecuteLog.setEmpid(Integer.parseInt(jobDataMap.get("empid")
					.toString()));
		} else {
			sirmJobExecuteLog.setType(1);
			sirmJobExecuteLog.setEmpid(0);
		}
		sirmJobExecuteLog.setStatus(1);
		jobExecuteLogService.saveOrUpdate(sirmJobExecuteLog);
		threadMap.put(Thread.currentThread(), sirmJobExecuteLog);
		logger.info("triggerFired");
	}

	@Override
	public void triggerMisfired(Trigger arg0) {
		// TODO Auto-generated method stub
		logger.info("triggerMisfired");

	}

	@Override
	public boolean vetoJobExecution(Trigger arg0, JobExecutionContext arg1) {
		// TODO Auto-generated method stub
		logger.info("vetoJobExecution");
		return false;
	}

}
