package com.hjon.common.quartz;

import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleScheduleBuilder;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

import com.hjon.modules.auth.job.AuthJob;

public class Util {

	public static void startSchedule() {
		try {
			// 1、创建一个JobDetail实例，指定Quartz
			JobDetail jobDetail = JobBuilder.newJob(AuthJob.class)
			// 任务执行类
					.withIdentity("quartz1", "quartz1")
					// 任务名，任务组
					.build();
			// 2、创建Trigger
			SimpleScheduleBuilder builder = SimpleScheduleBuilder
					.simpleSchedule()
					// 设置执行次数
					.repeatSecondlyForTotalCount(100);
			Trigger trigger = TriggerBuilder.newTrigger()
					.withIdentity("quartz1", "quartz1").startNow()
					.withSchedule(builder).build();
			// 3、创建Scheduler
			Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();
			scheduler.start();
			// 4、调度执行
			scheduler.scheduleJob(jobDetail, trigger);
			try {
				Thread.sleep(60000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}

			scheduler.shutdown();

		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}

}
