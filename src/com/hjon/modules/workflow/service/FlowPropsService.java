package com.hjon.modules.workflow.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.common.utils.StringUtils;
import com.hjon.modules.workflow.entity.FlowProps;

/**
 * WfExamplestep entity. @author MyEclipse Persistence Tools
 */
@Service
@Transactional
public class FlowPropsService extends BaseService<FlowProps> {

	public Map<String, Map<String, String>> getFlowPropsMap(Integer sourceid,
			String sourcename) {
		StringBuilder sql = new StringBuilder();
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append("select name, key, value");
		sql.append(" from WF_FLOWPROPS");
		sql.append(" where 1=1 and status=0");
		if (sourceid > 0 && StringUtils.isNotBlank(sourcename)) {
			sql.append(" and sourceid=:sourceid and sourcename=:sourcename \n");
			params.put("sourceid", Integer.valueOf(sourceid));
			params.put("sourcename", sourcename);
		} else {
			sql.append(" and 1=2");
		}

		sql.append("order by sort asc");
		List<Map<String, Object>> result = this.createSqlQueryToMapList(
				sql.toString(), params);
		return this.changePropsToMap(result);
	}

	private Map<String, Map<String, String>> changePropsToMap(
			List<Map<String, Object>> list) {
		// TODO Auto-generated method stub
		Map<String, Map<String, String>> _res = new HashMap<String, Map<String, String>>();
		Map<String, Map<String, String>> _t = new HashMap<String, Map<String, String>>();
		Iterator<Map<String, Object>> messagenoticeMap = list.iterator();

		String noticeowners;
		while (messagenoticeMap.hasNext()) {
			Map<String, Object> _map2 = (Map<String, Object>) messagenoticeMap
					.next();
			String noticeownerssize = MapUtils.getString(_map2, "name", "");
			noticeowners = MapUtils.getString(_map2, "key", "");
			String i = MapUtils.getString(_map2, "value", "");
			Map<String, String> _map21 = _t.get(noticeownerssize);
			if (_map21 == null) {
				_map21 = new HashMap<String, String>();
			}

			_map21.put(noticeowners, i);
			_t.put(noticeownerssize, _map21);
			if (!noticeownerssize.startsWith("conditionowner")
					&& !noticeownerssize.startsWith("stepcondition")
					&& !noticeownerssize.startsWith("steplinkdo")
					&& !noticeownerssize.startsWith("messagenotice")) {
				_res.put(noticeownerssize, _map21);
			}
		}

		int var10;
		String var11;
		int var13;
		Map<String, String> var14;
		if (_t.containsKey("conditionownersize")) {
			var10 = MapUtils.getIntValue(_t.get("conditionownersize"), "value",
					0);
			var11 = "";

			for (var13 = 1; var13 <= var10; ++var13) {
				var11 = var11
						+ MapUtils.getString(_t.get("conditionowner" + var13),
								"value", "") + ",";
			}

			if (var11.endsWith(",")) {
				var11 = var11.substring(0, var11.length() - 1);
			}

			var14 = new HashMap<String, String>();
			var14.put("value", var11);
			_res.put("conditionowner", var14);
		}

		if (_t.containsKey("stepconditionsize")) {
			var10 = MapUtils.getIntValue(_t.get("stepconditionsize"), "value",
					0);
			var11 = "";

			for (var13 = 1; var13 <= var10; ++var13) {
				var11 = var11
						+ MapUtils.getString(_t.get("stepcondition" + var13),
								"value", "") + ",";
			}

			if (var11.endsWith(",")) {
				var11 = var11.substring(0, var11.length() - 1);
			}

			var14 = new HashMap<String, String>();
			var14.put("value", var11);
			_res.put("stepcondition", var14);
		}

		if (_t.containsKey("steplinkdosize")) {
			var10 = MapUtils.getIntValue(_t.get("steplinkdosize"), "value", 0);
			var11 = "";

			for (var13 = 1; var13 <= var10; ++var13) {
				var11 = var11
						+ MapUtils.getString(_t.get("steplinkdo" + var13),
								"value", "") + ",";
			}

			if (var11.endsWith(",")) {
				var11 = var11.substring(0, var11.length() - 1);
			}

			var14 = new HashMap<String, String>();
			var14.put("value", var11);
			_res.put("steplinkdo", var14);
		}

		if (_t.containsKey("messagenotice")) {
			Map<String, String> var12 = _t.get("messagenotice");
			Map<String, String> var16 = new HashMap<String, String>();
			Iterator<String> var17 = var12.keySet().iterator();

			while (var17.hasNext()) {
				noticeowners = (String) var17.next();
				if (!noticeowners.startsWith("noticeowners")) {
					var16.put(noticeowners, var12.get(noticeowners));
				}
			}

			var13 = MapUtils.getIntValue(var12, "noticeownerssize", 0);
			noticeowners = "";

			for (int var15 = 1; var15 <= var13; ++var15) {
				noticeowners = noticeowners
						+ MapUtils.getString(var12, "noticeowners" + var15, "")
						+ ",";
			}

			if (noticeowners.endsWith(",")) {
				noticeowners = noticeowners.substring(0,
						noticeowners.length() - 1);
			}

			var16.put("noticeowners", noticeowners);
			_res.put("messagenotice", var16);
		}

		return _res;
	}
}