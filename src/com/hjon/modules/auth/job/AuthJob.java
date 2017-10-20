package com.hjon.modules.auth.job;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;

public class AuthJob implements StatefulJob {
	Logger logger=Logger.getLogger(AuthJob.class);
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub
		logger.info("简单定时任务测试1");
	}

}
