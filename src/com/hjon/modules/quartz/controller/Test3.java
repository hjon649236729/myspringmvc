package com.hjon.modules.quartz.controller;

public class Test3 {
	public static String JOB_NAME = "动态任务调度3";
	public static String TRIGGER_NAME = "动态任务触发器3";
	public static String JOB_GROUP_NAME = "动态任务_JOB_GROUP3";
	public static String TRIGGER_GROUP_NAME = "动态任务_trigger_GROUP3";

	public static void main(String[] args) {
		try {
			System.out.println("【系统启动】开始(每1秒输出一次)...");
			QuartzManager.addJob(JOB_NAME, JOB_GROUP_NAME, TRIGGER_NAME,
					TRIGGER_GROUP_NAME,
					Class.forName("com.hjon.modules.quartz.job.AuthJob"),
					"0/1 * * * * ?");

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
