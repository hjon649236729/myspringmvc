package com.hjon.modules.quartz.controller;

import org.quartz.JobKey;
import org.quartz.SchedulerException;
import org.quartz.TriggerKey;

public class TestPasu {
	public static String JOB_NAME = "动态任务调度1_TestJob1";
	public static String TRIGGER_NAME = "动态任务触发器1_TestJob2";
	public static String JOB_GROUP_NAME = "动态任务_JOB_GROUP1_TestJob1";
	public static String TRIGGER_GROUP_NAME = "动态任务_trigger_GROUP1_TestJob2";

	public static void main(String[] args) {

		try {

			JobKey jobKey = new JobKey(JOB_NAME, JOB_GROUP_NAME);
			TriggerKey tirggerKey = new TriggerKey(TRIGGER_NAME,
					TRIGGER_GROUP_NAME);
			//	 QuartzManager.pauseJob(jobKey);// 暂停定时任务,
			QuartzManager.resumeJob(jobKey);// 恢复定时任务,
			//			QuartzManager.resumeTrigger(tirggerKey);
			
			try {
				Thread.sleep(10L * 1000L);
				// executing...
			} catch (Exception e) {
			}
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/*
		 * try { System.out.println(QuartzManager.isStarted()); } catch
		 * (SchedulerException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */
	}
}
