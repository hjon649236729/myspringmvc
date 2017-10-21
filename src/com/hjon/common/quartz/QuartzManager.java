package com.hjon.common.quartz;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.StdSchedulerFactory;
import org.quartz.impl.matchers.GroupMatcher;

import com.hjon.modules.quartz.entity.JobInfo;

public class QuartzManager {
	private static Scheduler scheduler = getScheduler();

	/**
	 * 创建一个调度对象
	 * 
	 * @return
	 * @throws SchedulerException
	 */
	private static Scheduler getScheduler() {
		SchedulerFactory sf = new StdSchedulerFactory();
		Scheduler scheduler = null;
		try {
			scheduler = sf.getScheduler();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		return scheduler;
	}

	public static Scheduler getInstanceScheduler() {
		return scheduler;
	}

	/**
	 * @Description: 添加一个定时任务
	 * 
	 * @param jobName
	 *            任务名
	 * @param jobGroupName
	 *            任务组名
	 * @param jobDescription
	 *            任务描述
	 * @param triggerName
	 *            触发器名
	 * @param jobClass
	 *            任务
	 * @param cron
	 *            时间设置，参考quartz说明文档
	 */

	public static void addJob(String jobName, String jobGroupName,
			String jobDescription, String triggerName, String triggerGroupName,
			String triggerDescription, Class jobClass, String cron) {
		try {
			JobBuilder jobBuilder = JobBuilder.newJob(jobClass);
			// 任务名，任务组，任务执行类
			jobBuilder.withIdentity(jobName, jobGroupName);
			jobBuilder.withDescription(jobDescription);
			JobDetail jobDetail = jobBuilder.build();

			// 触发器
			TriggerBuilder<Trigger> triggerBuilder = TriggerBuilder
					.newTrigger();
			// 触发器名,触发器组
			triggerBuilder.withIdentity(triggerName, triggerGroupName);

			triggerBuilder.withDescription(triggerDescription);
			triggerBuilder.startNow();
			// 触发器时间设定
			triggerBuilder.withSchedule(CronScheduleBuilder.cronSchedule(cron));
			// 创建Trigger对象
			CronTrigger trigger = (CronTrigger) triggerBuilder.build();

			// 调度容器设置JobDetail和Trigger
			scheduler.scheduleJob(jobDetail, trigger);

			// 启动
			if (!scheduler.isShutdown()) {
				scheduler.start();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 添加一个定时任务
	 * 
	 * @param jobName
	 *            任务名
	 * @param jobGroupName
	 *            任务组名
	 * @param jobDescription
	 *            任务描述
	 * @param triggerName
	 *            触发器名
	 * @param triggerGroupName
	 *            触发器组名
	 * @param triggerDescription
	 *            触发器描述
	 * @param jobClass
	 *            任务
	 * @param cron
	 *            时间设置，参考quartz说明文档
	 */

	public static void addJob(JobInfo info) {
		try {
			JobBuilder jobBuilder = JobBuilder.newJob(info.getJobClass());
			// 任务名，任务组，任务执行类
			jobBuilder.withIdentity(info.getJobName(), info.getJobGroupName());
			jobBuilder.withDescription(info.getJobDescription());
			JobDetail jobDetail = jobBuilder.build();

			// 触发器
			TriggerBuilder<Trigger> triggerBuilder = TriggerBuilder
					.newTrigger();
			// 触发器名,触发器组
			triggerBuilder.withIdentity(info.getTriggerName(),
					info.getTriggerGroupName());

			triggerBuilder.withDescription(info.getTriggerDescription());
			triggerBuilder.startNow();
			// 触发器时间设定
			triggerBuilder.withSchedule(CronScheduleBuilder.cronSchedule(info
					.getCron()));
			// 创建Trigger对象
			CronTrigger trigger = (CronTrigger) triggerBuilder.build();

			// 调度容器设置JobDetail和Trigger
			scheduler.scheduleJob(jobDetail, trigger);

			// 启动
			if (!scheduler.isShutdown()) {
				scheduler.start();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 修改一个任务的触发时间
	 * 
	 * @param jobName
	 * @param jobGroupName
	 * @param triggerName
	 *            触发器名
	 * @param triggerGroupName
	 *            触发器组名
	 * @param cron
	 *            时间设置，参考quartz说明文档
	 */
	public static void modifyJobTime(String jobName, String jobGroupName,
			String jobDescription, String triggerName, String triggerGroupName,
			String triggerDescription, Class jobClass, String cron) {
		try {

			TriggerKey triggerKey = TriggerKey.triggerKey(triggerName,
					triggerGroupName);
			CronTrigger trigger = (CronTrigger) scheduler
					.getTrigger(triggerKey);
			if (trigger == null) {
				return;
			}

			String oldTime = trigger.getCronExpression();
			if (!oldTime.equalsIgnoreCase(cron)) {
				/** 方式一 ：调用 rescheduleJob 开始 */
				// 触发器
				TriggerBuilder<Trigger> triggerBuilder = TriggerBuilder
						.newTrigger();
				// 触发器名,触发器组
				triggerBuilder.withIdentity(triggerName, triggerGroupName);
				triggerBuilder.startNow();
				// 触发器时间设定
				triggerBuilder.withSchedule(CronScheduleBuilder
						.cronSchedule(cron));

				// 创建Trigger对象
				trigger = (CronTrigger) triggerBuilder.build();
				// 方式一 ：修改一个任务的触发时间
				scheduler.rescheduleJob(triggerKey, trigger);
				/** 方式一 ：调用 rescheduleJob 结束 */

				/** 方式二：先删除，然后在创建一个新的Job */
				// JobDetail jobDetail =
				// sched.getJobDetail(JobKey.jobKey(jobName, jobGroupName));
				// Class<? extends Job> jobClass = jobDetail.getJobClass();
				// removeJob(jobName, jobGroupName, triggerName,
				// triggerGroupName);
				// addJob(jobName, jobGroupName, triggerName, triggerGroupName,
				// jobClass, cron);
				/** 方式二 ：先删除，然后在创建一个新的Job */
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 修改任务
	 * 
	 * @param oldjobName
	 * @param oldJobGroupName
	 * @param triggerName
	 *            触发器名
	 * @param triggerGroupName
	 *            触发器组名
	 * @param cron
	 *            时间设置，参考quartz说明文档
	 */
	public static void modifyJob(String oldjobName, String oldJobGroupName,
			String oldTriggerName, String oldTriggerGroupName, JobInfo job) {

		JobDetail jobDetail;
		try {
			jobDetail = scheduler.getJobDetail(JobKey.jobKey(oldjobName,
					oldJobGroupName));
			Class<? extends Job> jobClass1 = jobDetail.getJobClass();
			removeJob(oldjobName, oldJobGroupName, oldTriggerName,
					oldTriggerGroupName);
			addJob(job);
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/*
		 * try {
		 * 
		 * }
		 */

		// TriggerKey triggerKey = TriggerKey.triggerKey(triggerName,
		// triggerGroupName);
		// CronTrigger trigger = (CronTrigger) scheduler
		// .getTrigger(triggerKey);
		// if (trigger == null) {
		// return;
		// }
		//
		// String oldTime = trigger.getCronExpression();
		// if (!oldTime.equalsIgnoreCase(cron)) {
		/** 方式一 ：调用 rescheduleJob 开始 */
		// // 触发器
		// TriggerBuilder<Trigger> triggerBuilder = TriggerBuilder
		// .newTrigger();
		// // 触发器名,触发器组
		// triggerBuilder.withIdentity(triggerName, triggerGroupName);
		// triggerBuilder.startNow();
		// // 触发器时间设定
		// triggerBuilder.withSchedule(CronScheduleBuilder
		// .cronSchedule(cron));
		//
		// // 创建Trigger对象
		// trigger = (CronTrigger) triggerBuilder.build();
		// // 方式一 ：修改一个任务的触发时间
		// scheduler.rescheduleJob(triggerKey, trigger);
		/** 方式一 ：调用 rescheduleJob 结束 */

		/** 方式二：先删除，然后在创建一个新的Job */
		// JobDetail jobDetail = scheduler.getJobDetail(JobKey.jobKey(
		// jobName, jobGroupName));
		// Class<? extends Job> jobClass1 = jobDetail.getJobClass();
		// removeJob(jobName, jobGroupName, triggerName,
		// triggerGroupName);
		// addJob(jobName, jobGroupName, triggerName, triggerGroupName,
		// jobClass, cron);
		/** 方式二 ：先删除，然后在创建一个新的Job */
		// }
		// } catch (Exception e) {
		// throw new RuntimeException(e);
		// }
	}

	/**
	 * 暂停一个JOB任务，调用这个方法
	 * 
	 * @param jobkey
	 * @throws SchedulerException
	 */
	public static void pauseJob(JobKey jobkey) throws SchedulerException {
		scheduler.pauseJob(jobkey);
	}

	/**
	 * 停止多个job任务
	 * 
	 * @param groupmatcher
	 * @throws SchedulerException
	 */
	public static void pauseJobs(GroupMatcher<JobKey> groupmatcher)
			throws SchedulerException {
		scheduler.pauseJobs(groupmatcher);
	}

	/**
	 * @Description: 移除一个任务
	 * 
	 * @param jobName
	 * @param jobGroupName
	 * @param triggerName
	 * @param triggerGroupName
	 */
	public static void removeJob(String jobName, String jobGroupName,
			String triggerName, String triggerGroupName) {
		try {

			TriggerKey triggerKey = TriggerKey.triggerKey(triggerName,
					triggerGroupName);

			scheduler.pauseTrigger(triggerKey);// 停止触发器
			scheduler.unscheduleJob(triggerKey);// 移除触发器
			scheduler.deleteJob(JobKey.jobKey(jobName, jobGroupName));// 删除任务
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description:启动所有定时任务
	 */
	public static void startJobs() {
		try {

			scheduler.start();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description:关闭所有定时任务
	 */
	public static void shutdownJobs() {
		try {

			if (!scheduler.isShutdown()) {
				scheduler.shutdown();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 检查调度是否启动
	 * 
	 * @return
	 * @throws SchedulerException
	 */
	public static boolean isStarted() throws SchedulerException {
		return scheduler.isStarted();
	}

	/**
	 * 启动一个调度对象
	 * 
	 * @throws SchedulerException
	 */
	public static void start() throws SchedulerException {
		scheduler.start();
	}

	/**
	 * 关闭调度信息
	 * 
	 * @throws SchedulerException
	 */
	public static void shutdown() throws SchedulerException {
		scheduler.shutdown();
	}

	/**
	 * 添加调度的job信息
	 * 
	 * @param jobdetail
	 * @param trigger
	 * @return
	 * @throws SchedulerException
	 */
	public static Date scheduleJob(JobDetail jobdetail, Trigger trigger)
			throws SchedulerException {
		return scheduler.scheduleJob(jobdetail, trigger);
	}

	/**
	 * 添加相关的触发器
	 * 
	 * @param trigger
	 * @return
	 * @throws SchedulerException
	 */
	public static Date scheduleJob(Trigger trigger) throws SchedulerException {
		return scheduler.scheduleJob(trigger);
	}

	/**
	 * 添加多个job任务
	 * 
	 * @param triggersAndJobs
	 * @param replace
	 * @throws SchedulerException
	 */
	public static void scheduleJobs(
			Map<JobDetail, Set<? extends Trigger>> triggersAndJobs,
			boolean replace) throws SchedulerException {
		scheduler.scheduleJobs(triggersAndJobs, replace);
	}

	/**
	 * 停止调度Job任务
	 * 
	 * @param triggerkey
	 * @return
	 * @throws SchedulerException
	 */
	public static boolean unscheduleJob(TriggerKey triggerkey)
			throws SchedulerException {
		return scheduler.unscheduleJob(triggerkey);
	}

	/**
	 * 停止调度多个触发器相关的job
	 * 
	 * @param list
	 * @return
	 * @throws SchedulerException
	 */
	public static boolean unscheduleJobs(List<TriggerKey> triggerKeylist)
			throws SchedulerException {
		return scheduler.unscheduleJobs(triggerKeylist);
	}

	/**
	 * 重新恢复触发器相关的job任务
	 * 
	 * @param triggerkey
	 * @param trigger
	 * @return
	 * @throws SchedulerException
	 */
	public static Date rescheduleJob(TriggerKey triggerkey, Trigger trigger)
			throws SchedulerException {
		return scheduler.rescheduleJob(triggerkey, trigger);
	}

	/**
	 * 添加相关的job任务
	 * 
	 * @param jobdetail
	 * @param flag
	 * @throws SchedulerException
	 */
	public static void addJob(JobDetail jobdetail, boolean flag)
			throws SchedulerException {
		scheduler.addJob(jobdetail, flag);
	}

	/**
	 * 删除相关的job任务
	 * 
	 * @param jobkey
	 * @return
	 * @throws SchedulerException
	 */
	public static boolean deleteJob(JobKey jobkey) throws SchedulerException {
		return scheduler.deleteJob(jobkey);
	}

	/**
	 * 删除相关的多个job任务
	 * 
	 * @param jobKeys
	 * @return
	 * @throws SchedulerException
	 */
	public static boolean deleteJobs(List<JobKey> jobKeys)
			throws SchedulerException {
		return scheduler.deleteJobs(jobKeys);
	}

	/**
	 * 
	 * @param jobkey
	 * @throws SchedulerException
	 */
	public static void triggerJob(JobKey jobkey) throws SchedulerException {
		scheduler.triggerJob(jobkey);
	}

	/**
	 * 
	 * @param jobkey
	 * @param jobdatamap
	 * @throws SchedulerException
	 */
	public static void triggerJob(JobKey jobkey, JobDataMap jobdatamap)
			throws SchedulerException {
		scheduler.triggerJob(jobkey, jobdatamap);
	}

	/**
	 * 停止相关的触发器
	 * 
	 * @param triggerkey
	 * @throws SchedulerException
	 */
	public static void pauseTrigger(TriggerKey triggerkey)
			throws SchedulerException {
		scheduler.pauseTrigger(triggerkey);
	}

	/**
	 * 停止使用多个的触发器
	 * 
	 * @param triggerkey
	 * @throws SchedulerException
	 */
	public void pauseTriggers(GroupMatcher<TriggerKey> groupmatcher)
			throws SchedulerException {
		scheduler.pauseTriggers(groupmatcher);
	}

	/**
	 * 恢复单个job任务
	 * 
	 * @param jobkey
	 * @throws SchedulerException
	 */
	public static void resumeJob(JobKey jobkey) throws SchedulerException {
		scheduler.resumeJob(jobkey);
	}

	/**
	 * 恢复多个job任务
	 * 
	 * @param matcher
	 * @throws SchedulerException
	 */
	public static void resumeJobs(GroupMatcher<JobKey> matcher)
			throws SchedulerException {
		scheduler.resumeJobs(matcher);
	}

	/**
	 * 恢复单个job任务
	 * 
	 * @param triggerkey
	 * @throws SchedulerException
	 */
	public static void resumeTrigger(TriggerKey triggerkey)
			throws SchedulerException {
		scheduler.resumeTrigger(triggerkey);
	}

	/**
	 * 恢复多个Triggers任务
	 * 
	 * @param triggerkey
	 * @throws SchedulerException
	 */
	public static void resumeTriggers(GroupMatcher<TriggerKey> groupmatcher)
			throws SchedulerException {
		scheduler.resumeTriggers(groupmatcher);
	}

	/**
	 * 暂停调度中所有的job任务
	 * 
	 * @throws SchedulerException
	 */
	public void pauseAll() throws SchedulerException {
		scheduler.pauseAll();
	}

	/**
	 * 恢复调度中所有的job的任务
	 * 
	 * @throws SchedulerException
	 */
	public void resumeAll() throws SchedulerException {
		scheduler.resumeAll();
	}

}