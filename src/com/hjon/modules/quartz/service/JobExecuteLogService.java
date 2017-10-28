package com.hjon.modules.quartz.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.quartz.entity.JobExecuteLog;

@Service("jobExecuteLogService")
@Transactional
public class JobExecuteLogService extends BaseService<JobExecuteLog> {
	public List<JobExecuteLog> getJobExecuteLog(String name ,int status){
		List<JobExecuteLog> jobExecuteLogs=this.query("from JobExecuteLog where name=? and status=?", new Object[]{name,status});
		return jobExecuteLogs;
	}
}
