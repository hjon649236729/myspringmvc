package com.hjon.modules.quartz.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.quartz.entity.JobExecuteLog;
import com.hjon.modules.quartz.entity.JobInfo;

@Service("jobExecuteLogService")
@Transactional
public class JobExecuteLogService extends BaseService<JobExecuteLog> {

}
