package com.hjon.modules.quartz.controller;

import com.hjon.common.quartz.QuartzManager;
import com.hjon.modules.quartz.entity.JobInfo;
import com.hjon.modules.quartz.job.TestJob1;

public class TestStart {
	private static String JOB_NAME = "动态任务调度1";
	private static String TRIGGER_NAME = "动态任务触发器1";
	private static String JOB_GROUP_NAME = "动态任务_JOB_GROUP1";
	private static String TRIGGER_GROUP_NAME = "动态任务_trigger_GROUP1";
	private static String JOB_DISCRIPTION = "任务描述信息1";
	private static String TRIGGER_DISCRIPTION = "触发器描述信息1";
	private static String CRON = "0/2 * * * * ?";

	public static void main(String[] args) {
		try {
			JobInfo info = new JobInfo();
			info.setJobName(JOB_NAME);
			info.setJobGroupName(JOB_GROUP_NAME);
			info.setJobDescription(JOB_DISCRIPTION);
			info.setJobClass(TestJob1.class);
			info.setTriggerName(TRIGGER_NAME);
			info.setTriggerGroupName(TRIGGER_GROUP_NAME);
			info.setTriggerDescription(TRIGGER_DISCRIPTION);
			info.setCron(CRON);
			QuartzManager.addJob(info);
			// QuartzManager.add

			/*
			 * System.out.println("【系统启动】开始(每1秒输出一次)...");
			 * QuartzManager.addJob(JOB_NAME, JOB_GROUP_NAME, TRIGGER_NAME,
			 * TRIGGER_GROUP_NAME,
			 * Class.forName("com.hjon.modules.quartz.job.AuthJob"),
			 * "0/1 * * * * ?");
			 */

			// QuartzManager.startJobs();
			// Thread.sleep(5000);
			// System.out.println("【修改时间】开始(每5秒输出一次)...");
			// QuartzManager.modifyJobTime(JOB_NAME, JOB_GROUP_NAME,
			// TRIGGER_NAME,
			// TRIGGER_GROUP_NAME, "0/5 * * * * ?");
			//
			// Thread.sleep(6000);
			// System.out.println("【移除定时】开始...");
			// QuartzManager.removeJob(JOB_NAME, JOB_GROUP_NAME, TRIGGER_NAME,
			// TRIGGER_GROUP_NAME);
			// System.out.println("【移除定时】成功");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
