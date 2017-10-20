package com.hjon.modules.quartz.controller;

import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.impl.JobDetailImpl;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hjon.common.controller.BaseController;

@Controller
@Scope("prototype")
public class QuartzController extends BaseController {

	@RequestMapping("quartz/list")
	public String list() {
		
		
		
		
		return "common/quartz/managercrontrigger";

	}
	
	public String saveCronTrigger() {
		// 获取触发器名称
		//String planname = maps.get("planname");
		/*String cronExpression = maps.get("time");
		String jobClass = maps.get("classcode");
		String jobtype = "DEFAULT";
		String memo = maps.get("memo");
		String status = maps.get("status");
		String oldtypefunc = maps.get("oldtypefunc");
		// 原调度名称（带编号）
		String triggerName = maps.get("triggername");*/
		String planname=this.getParameter("planName");
		String cronExpression=this.getParameter("time");
		String jobClass=this.getParameter("jobClass");
		String jobtype = "DEFAULT";
		String memo = this.getParameter("memo");
		String status = this.getParameter("status");
		String oldtypefunc = this.getParameter("oldtypefunc");
		// 原调度名称（带编号）
		String triggerName = this.getParameter("triggername");
		
		
		JobDetail jobDetail = null;
		try {
			Class obj = Class.forName(jobClass);
			 JobDetail job = JobBuilder.newJob().withIdentity("job1", "group1").build();
			/*
			jobDetail = new JobDetail(planname, jobtype, obj);
			jobDetail.setDescription(memo + "########$$%%:" + jobClass
					+ "########$$%%:" + cronExpression);*/
			
		} catch (Exception e) {
			e.printStackTrace();
			return "找不到执行的代码";
		}
		/*if (CommonServiceFactory.getSchedulerService().validatejobName(
				triggerName, planname, jobtype)) {
			return "计划调度名称重复";
		}*/
	//	String reqtype = maps.get("reqtype");
		//if (reqtype.equals("0")) {
			// 增加触发器
		//	CommonServiceFactory.getSchedulerService().schedule(planname,
		//			cronExpression, jobDetail);
	//	} else {
			// 修改触发器
	//		CommonServiceFactory.getSchedulerService().modifyTrigger(
				//	triggerName, oldtypefunc, cronExpression, jobDetail);
			// if (status.equals("1")) {
			// //
			// CommonServiceFactory.getSchedulerService().resumeTrigger(planname,
			// jobtype);
			// }
		//}
		// if (status.equals("0")) {
		// CommonServiceFactory.getSchedulerService().pauseTrigger(planname,
		// jobtype);
		// }
		return "";
	}
}
