package com.hjon.modules.quartz.service;

import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.bean.Page;
import com.hjon.common.service.BaseService;
import com.hjon.common.utils.StringUtils;
import com.hjon.modules.quartz.entity.JobInfo;

@Service
@Transactional
public class QuartzService extends BaseService<JobInfo> {
	public Page searchQuartz(int pageNum, int numberPage,
			Map<String, Object> params) {
		StringBuffer sql = new StringBuffer(
				"SELECT T.TRIGGER_NAME,T.TRIGGER_GROUP,T.JOB_NAME,T.DESCRIPTION,T.START_TIME,T.NEXT_FIRE_TIME,T.PREV_FIRE_TIME,T.TRIGGER_STATE,T.TRIGGER_TYPE,  C.CRON_EXPRESSION,D.JOB_CLASS_NAME,D.JOB_CLASS_NAME CLASSNAME,T.JOB_GROUP FROM QRTZ_TRIGGERS T  LEFT JOIN QRTZ_CRON_TRIGGERS C ON T.TRIGGER_NAME = C.TRIGGER_NAME  LEFT JOIN QRTZ_JOB_DETAILS D ON D.JOB_NAME = T.JOB_NAME where 1 = 1");
		if (!StringUtils.isBlank(params.get("JOB_NAME"))) {
			sql.append(" AND JOB_NAME LIKE  '%" + ":JOB_NAME" + "%'");
		}
		return this.pagedQuery(sql.toString(), pageNum, numberPage, params);
	}

	public boolean validatejobName(String jobName, String jobGroupName) {
		StringBuffer sql = new StringBuffer(
				"select count(1) from qrtz_job_details where job_name=:jobName and job_group=:jobGroupName ");
		SQLQuery query = this.getSessionFactory().openSession()
				.createSQLQuery(sql.toString());
		query.setString("jobName", jobName);
		query.setString("jobGroupName", jobGroupName);

		List<Map> list = query.list();
		if (list != null && list.size() > 0) {
			return false;
		}
		return true;
	}
}
