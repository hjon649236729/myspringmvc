package com.hjon.modules.quartz.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.auth.entity.UserInfo;

@Service
@Transactional
public class QuartzService extends BaseService<UserInfo> {

	private List findTrigderList(String var1) {
		return null;

	}
	private boolean validatejobName(String jobName,String jobGroupName){
		
		
		return true;
	}

}
