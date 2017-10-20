package com.hjon.modules.quartz.job;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class TestJob2 implements Job {
	Logger logger=Logger.getLogger(TestJob2.class);
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub
		logger.info("简单定时任务测试22222222222222");
		
	}

}
