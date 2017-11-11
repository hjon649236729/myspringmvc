package com.hjon.modules.workflow.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.quartz.SchedulerException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hjon.common.bean.Page;
import com.hjon.common.controller.BaseController;
import com.hjon.common.utils.NumberUtils;
import com.hjon.modules.quartz.controller.QuartzController;
import com.hjon.modules.workflow.entity.ProcessInfo;
import com.hjon.modules.workflow.service.FlowDotsService;
import com.hjon.modules.workflow.service.FlowNodeService;
import com.hjon.modules.workflow.service.FlowPathsService;
import com.hjon.modules.workflow.service.FlowPropsService;
import com.hjon.modules.workflow.service.ProcessService;

@Controller
@Scope("prototype")
public class ProcessController extends BaseController {

	@Resource(name = "processService")
	private ProcessService processService;

	@Resource(name = "flowDotsService")
	private FlowDotsService flowDotsService;

	@Resource(name = "flowNodeService")
	private FlowNodeService flowNodeService;

	@Resource(name = "flowPathsService")
	private FlowPathsService flowPathsService;

	@Resource(name = "flowPropsService")
	private FlowPropsService flowPropsService;

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
		// String jobName = this.getParameter("jobName");
		// LocalprocessManager.removeJob(jobName, jobName, jobName, jobName);
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

		Integer processId = NumberUtils.safeToInteger(
				this.getParameter("processid"), -1);
		ProcessInfo process = processService.get(processId);
		// IWorkflowProcess _process = _workbase.loadProcess(_processid);
		if (process == null) {
			logger.info("ID为:" + processId + "的流程不存在");
			return "not exist";
		}
		request.setAttribute("processid", processId);
		request.setAttribute("processtype", process.getProcesstype());

		// 面板大小
		// Map<String, Map<String, String>> _svgmap = _workdraw.getFlowPropsMap(
		// _processid, IWorkflowProcess.ENTITY_NAME);
		Map<String, Map<String, String>> _svgmap = flowPropsService
				.getFlowPropsMap(processId, ProcessInfo.ENTITY_NAME);
		request.setAttribute("svgwidth", MapUtils.getInteger(
				MapUtils.getMap(_svgmap, "svgwidth"), "value", 3000));
		request.setAttribute("svgheight", MapUtils.getInteger(
				MapUtils.getMap(_svgmap, "svgheight"), "value", 1000));

		Map<String, Object> _myflow = new HashMap<String, Object>();
//
//		if (!_workdraw.checkIsDrawFlow(_processid)) { // 如果空的，说明是旧的流程，
//														// 要把流程数据转换成新的数据
//			logger.info("旧流程图形化操作：");
//			_myflow = _workadv.changeProcess(_processid);
//		} else {
//			logger.info("新流程图形化操作：");
//			_myflow = _workdraw.getFlowDataMap(_processid);
//		}

		request.setAttribute("flowdata", new JSONObject(_myflow).toString());

		List<Map> _ownerlinkoriginlist = _workbase
				.findParaListByName("OwnerLinkOrigin");
		request.setAttribute("ownerlinkoriginlist", _ownerlinkoriginlist);
		request.setAttribute("ownerlinkoriginlistJSON", new JSONArray(
				_ownerlinkoriginlist).toString().replaceAll("\"", "'"));

		List<Map> _autoskiplist = _workbase.findParaListByName("AutoSkip");
		request.setAttribute("autoskiplist", _autoskiplist);
		return "workflow/drawprocess";
	}

}
