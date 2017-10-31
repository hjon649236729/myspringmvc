package com.hjon.modules.quartz.entity;

import javax.persistence.Entity;


public class JobInfo {
	private String jobName;
	private String jobGroupName;
	private String jobDescription;
	private String triggerName;
	private String triggerGroupName;
	private String TriggerDescription;
	private Class jobClass;
	private String cron;
	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public String getJobGroupName() {
		return jobGroupName;
	}

	public void setJobGroupName(String jobGroupName) {
		this.jobGroupName = jobGroupName;
	}

	public String getJobDescription() {
		return jobDescription;
	}

	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
	}

	public String getTriggerName() {
		return triggerName;
	}

	public void setTriggerName(String triggerName) {
		this.triggerName = triggerName;
	}

	public String getTriggerGroupName() {
		return triggerGroupName;
	}

	public void setTriggerGroupName(String triggerGroupName) {
		this.triggerGroupName = triggerGroupName;
	}

	public String getTriggerDescription() {
		return TriggerDescription;
	}

	public void setTriggerDescription(String triggerDescription) {
		TriggerDescription = triggerDescription;
	}

	public Class getJobClass() {
		return jobClass;
	}

	public void setJobClass(Class jobClass) {
		this.jobClass = jobClass;
	}

	public String getCron() {
		return cron;
	}

	public void setCron(String cron) {
		this.cron = cron;
	}

}
