package com.hjon.modules.workflow.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.quartz.SchedulerException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hjon.common.bean.Page;
import com.hjon.common.controller.BaseController;
import com.hjon.common.utils.JsonUtil;
import com.hjon.common.utils.NumberUtils;
import com.hjon.modules.workflow.entity.FlowDots;
import com.hjon.modules.workflow.entity.FlowNode;
import com.hjon.modules.workflow.entity.FlowPaths;
import com.hjon.modules.workflow.entity.ProcessInfo;
import com.hjon.modules.workflow.service.FlowDotsService;
import com.hjon.modules.workflow.service.FlowNodeService;
import com.hjon.modules.workflow.service.FlowPathsService;
import com.hjon.modules.workflow.service.FlowPropsService;
import com.hjon.modules.workflow.service.ProcessListService;
import com.hjon.modules.workflow.service.ProcessService;

@Controller
@Scope("prototype")
public class ProcessController extends BaseController {

	@Resource(name = "processService")
	private ProcessService processService;

	@Resource(name = "flowDotsService")
	private FlowDotsService flowDotsService;

	@Resource(name = "flowPropsService")
	private FlowPropsService flowPropsService;

	@Resource(name = "flowPathsService")
	private FlowPathsService flowPathsService;

	@Resource(name = "processListService")
	private ProcessListService processListService;

	@Resource(name = "flowNodeService")
	private FlowNodeService flowNodeService;

	Logger logger = Logger.getLogger(ProcessController.class);

	@RequestMapping("workflow/processlist")
	public String list() {
		int pageNum = NumberUtils
				.safeToInteger(this.getParameter("pageNum"), 1);
		int numberPage = NumberUtils.safeToInteger(
				this.getParameter("numPerPage"), 10);
		Map<String, Object> params = new HashMap<String, Object>();
		String status = this.getParameter("status");
		if (StringUtils.isNotBlank(status)) {
			params.put("status", status);
			this.setAttribute("status", status);
		}
		String processType = this.getParameter("processType");
		if (StringUtils.isNotBlank(processType)) {
			params.put("processType", processType);
			this.setAttribute("processType", processType);
		}
		Page data = processService.searchProcess(pageNum, numberPage, params);
		this.setAttribute("data", data);
		return "workflow/processlist";

	}

	@RequestMapping("workflow/processsave")
	@ResponseBody
	public String processsave() {
		int id = NumberUtils.safeToInteger(this.getParameter("id"), -1);
		ProcessInfo processInfo = new ProcessInfo();
		if (id != -1) {
			processInfo = processService.get(id);

		} else {
			processInfo.setUpdatetimestamp(new Date());
		}
		this.setEntityValueFromPage(processInfo);
		processService.saveOrUpdate(processInfo);
		return "success";
	}

	@RequestMapping("workflow/processdelete")
	@ResponseBody
	public String processdelete() throws SchedulerException {

		return "success";
	}

	@RequestMapping("workflow/drawprocess")
	public String drawprocess() {

		// IWorkflowDrawService _workdraw =
		// WorkflowServiceFactory.getWorkflowDrawService();
		// IWorkflowBaseService _workbase =
		// WorkflowServiceFactory.getWorkflowBaseService();
		// IWorkflowAdvService _workadv =
		// WorkflowServiceFactory.getWorkflowAdvService();

		String _type = request.getParameter("type");
		if ("EDIT".equals(_type)) {
			request.setAttribute("editable", true);
		} else {
			request.setAttribute("editable", false);
		}

		Integer processid = NumberUtils.safeToInteger(
				this.getParameter("processid"), -1);
		ProcessInfo process = processService.get(processid);
		// IWorkflowProcess _process = _workbase.loadProcess(_processid);
		if (process == null) {
			logger.info("ID为:" + processid + "的流程不存在");
			return "not exist";
		}
		request.setAttribute("processid", processid);
		request.setAttribute("processtype", process.getProcesstype());

		// 面板大小
		Map<String, Map<String, String>> _svgmap = flowPropsService
				.getFlowPropsMap(processid, ProcessInfo.ENTITY_NAME);
		request.setAttribute("svgwidth", MapUtils.getInteger(
				MapUtils.getMap(_svgmap, "svgwidth"), "value", 3000));
		request.setAttribute("svgheight", MapUtils.getInteger(
				MapUtils.getMap(_svgmap, "svgheight"), "value", 1000));

		Map<String, Object> _myflow = new HashMap<String, Object>();
		// TODO
		// if (!_workdraw.checkIsDrawFlow(_processid)) { // 如果空的，说明是旧的流程，
		// // 要把流程数据转换成新的数据
		// logger.info("旧流程图形化操作：");
		// _myflow = _workadv.changeProcess(_processid);
		// } else {
		// logger.info("新流程图形化操作：");
		// _myflow = _workdraw.getFlowDataMap(_processid);
		// }
		_myflow = this.getFlowDataMap(processid);
		request.setAttribute("flowdata", new JSONObject(_myflow).toString());

		List<Map<String, Object>> _ownerlinkoriginlist = processListService
				.findParaListByName("OwnerLinkOrigin");
		request.setAttribute("ownerlinkoriginlist", _ownerlinkoriginlist);
		request.setAttribute("ownerlinkoriginlistJSON", new JSONArray(
				_ownerlinkoriginlist).toString().replaceAll("\"", "'"));

		List<Map<String, Object>> _autoskiplist = processListService
				.findParaListByName("AutoSkip");
		request.setAttribute("autoskiplist", _autoskiplist);
		return "workflow/drawprocess";
	}

	public Map getFlowDataMap(int processid) {
		HashMap _myflow = new HashMap();
		int num = 1;
		HashMap _parammap = new HashMap();
		HashMap status = new HashMap();
		HashMap paths = new HashMap();
		List _nodelist = flowNodeService.findFlowNode(processid);

		Iterator i$;
		Object var22;
		for (int _pathlist = 0; _pathlist < _nodelist.size(); ++_pathlist) {
			FlowNode i = (FlowNode) _nodelist.get(_pathlist);

			try {
				HashMap _paths = new HashMap();
				_paths.put("type", i.getType());
				HashMap _tp = new HashMap();
				_tp.put("text", i.getText());
				_paths.put("text", _tp);
				_paths.put("attr",
						JsonUtil.jsonToMap(new JSONObject(i.getAttr())));
				Map e = flowPropsService.getFlowPropsMap(i.getId(),i.getEntityname());
				HashMap _propsmap = new HashMap();
				Iterator props = e.keySet().iterator();

				while (props.hasNext()) {
					String _dotslist = (String) props.next();
					Map dots = (Map) e.get(_dotslist);
					i$ = dots.keySet().iterator();

					while (i$.hasNext()) {
						String _dot = (String) i$.next();
						var22 = (Map) _propsmap.get(_dotslist);
						if (var22 == null) {
							var22 = new HashMap();
						}

						((Map) var22).put(_dot, StringUtils
								.isBlank((String) dots.get(_dot)) ? ""
								: (String) dots.get(_dot));
						_propsmap.put(_dotslist, var22);
					}
				}

				_paths.put("props", _propsmap);
				status.put("rect" + num, _paths);
				_parammap.put(i.getId() + "_rect", "rect" + num);
				++num;
			} catch (JSONException var21) {
				logger.error("数据转换失败", var21);
			}
		}

		List var23 = flowPathsService.findFlowPaths(processid);

		for (int var24 = 0; var24 < var23.size(); ++var24) {
			FlowPaths var25 = (FlowPaths) var23.get(var24);

			try {
				HashMap var26 = new HashMap();
				var26.put("type", var25.getType());
				var26.put(
						"from",
						MapUtils.getString(_parammap, var25.getFromid()
								+ "_rect", ""));
				var26.put("to", MapUtils.getString(_parammap, var25.getToid()
						+ "_rect", ""));
				Map var27 = flowPropsService.getFlowPropsMap(var25.getId(),
						var25.getEntityname());
				HashMap var28 = new HashMap();
				Iterator var29 = var27.keySet().iterator();

				while (var29.hasNext()) {
					String var31 = (String) var29.next();
					Map var33 = (Map) var27.get(var31);
					Iterator var34 = var33.keySet().iterator();

					while (var34.hasNext()) {
						String _key = (String) var34.next();
						var22 = (Map) var28.get(var31);
						if (var22 == null) {
							var22 = new HashMap();
						}

						((Map) var22).put(_key, StringUtils
								.isBlank((String) var33.get(_key)) ? ""
								: (String) var33.get(_key));
						var28.put(var31, var22);
					}
				}

				var26.put("props", var28);
				List var30 = flowDotsService.findFlowDots(var25.getId());
				LinkedList var32 = new LinkedList();
				i$ = var30.iterator();

				while (i$.hasNext()) {
					FlowDots var35 = (FlowDots) i$.next();
					var32.add(JsonUtil.jsonToMap(new JSONObject(var35.getPos())));
				}

				var26.put("dots", var32);
				paths.put("path" + num, var26);
				++num;
			} catch (JSONException var20) {
				logger.error("数据转换失败", var20);
			}
		}

		_myflow.put("states", status);
		_myflow.put("paths", paths);
		return _myflow;
	}
}
