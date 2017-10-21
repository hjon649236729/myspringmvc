package com.hjon.modules.quartz.controller;

import org.quartz.JobKey;
import org.quartz.SchedulerException;
import org.quartz.TriggerKey;

import com.hjon.common.quartz.QuartzManager;

public class TestPause {
	private static String JOB_NAME = "动态任务调度1";
	private static String TRIGGER_NAME = "动态任务触发器1";
	private static String JOB_GROUP_NAME = "动态任务_JOB_GROUP1";
	private static String TRIGGER_GROUP_NAME = "动态任务_trigger_GROUP1";
	private static String JOB_DISCRIPTION = "任务描述信息1";
	private static String TRIGGER_DISCRIPTION = "触发器描述信息1";
	private static String CRON = "0/2 * * * * ?";
	

	public static void main(String[] args) {

		try {
			
			JobKey jobKey = new JobKey(JOB_NAME, JOB_GROUP_NAME);
			TriggerKey tirggerKey = new TriggerKey(TRIGGER_NAME,
					TRIGGER_GROUP_NAME);
			// QuartzManager.pauseJob(jobKey);// 暂停定时任务,
			// QuartzManager.resumeTrigger(tirggerKey);//恢复定时任务
			QuartzManager.deleteJob(jobKey);//删除定时任务

			try {
				Thread.sleep(10L * 1000L);
				// executing...
			} catch (Exception e) {
			}
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
