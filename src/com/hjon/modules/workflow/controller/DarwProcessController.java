package com.hjon.modules.workflow.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hjon.common.controller.BaseController;
import com.hjon.common.utils.JsonUtil;
import com.hjon.common.utils.NumberUtils;
import com.hjon.common.utils.StringUtils;
import com.hjon.modules.workflow.service.FlowDotsService;
import com.hjon.modules.workflow.service.FlowNodeService;
import com.hjon.modules.workflow.service.FlowPathsService;
import com.hjon.modules.workflow.service.FlowPropsService;
import com.hjon.modules.workflow.service.ProcessListService;

@Controller
@Scope("prototype")
public class DarwProcessController extends BaseController {
	Logger logger = Logger.getLogger(DarwProcessController.class);
	@Resource(name = "flowDotsService")
	private FlowDotsService flowDotsService;

	@Resource(name = "flowNodeService")
	private FlowNodeService flowNodeService;

	@Resource(name = "flowPathsService")
	private FlowPathsService flowPathsService;

	@Resource(name = "flowPropsService")
	private FlowPropsService flowPropsService;

	@Resource(name = "processListService")
	private ProcessListService processListService;

	/**
	 * ajax，通过processtype获得名称
	 * 
	 * @return
	 */
	@RequestMapping("drawprocess/getProcessTypeName")
	@ResponseBody
	public String getProcessTypeName() {
		int _processtype = NumberUtils.safeToInteger(
				this.getParameter("processtype"), 0);
		String _processtypename = "";

		if (_processtype > 0) {
			Map _map = new HashMap();
			_map = processListService.findParaByNameAndKey("ProcessType",
					_processtype);
			// Map _map = WorkflowServiceFactory.getWorkflowBaseService()
			// .findParaByNameAndKey("ProcessType", _processtype);
			_processtypename = MapUtils.getString(_map, "value", "");

			// try {
			return _processtypename;
			// } catch (IOException e) {
			// logger.info("返回结果时异常", e);
			// }
		}
		return null;
	}

	@RequestMapping("drawprocess/getProcessTypeName")
	@ResponseBody
	public Object saveMyflow() {
		// IWorkflowDrawService _workdraw =
		// WorkflowServiceFactory.getWorkflowDrawService();

		// int _processid = MapUtils.getIntValue(, "processid", 0);
		// String myflow = MapUtils.getString(map, "myflow", "");
		int _processid = NumberUtils.safeToInteger(
				this.getParameter("processid"), -1);
		String myflow = StringUtils.safeToString(this.getParameter("myflow"),
				"");
		try {
			Map<String, Object> _myflow = JsonUtil.jsonToMap(new JSONObject(
					myflow));
			// _workdraw.saveFlowData(_processid, _myflow);
		} catch (JSONException e) {
			logger.info("数据读取失败", e);
			return "数据有误，保存失败";
		}

		return null;
	}

	public Object saveSvgSize(Map map, HttpServletRequest request) {
		// IWorkflowDrawService _workdraw = WorkflowServiceFactory
		// .getWorkflowDrawService();

		int _processid = MapUtils.getIntValue(map, "processid", 0);
		int _svgwidth = MapUtils.getIntValue(map, "svgwidth", 3000);
		int _svgheight = MapUtils.getIntValue(map, "svgheight", 1000);

		try {
			// List<IWorkflowFlowProps> _svgwidthlist = _workdraw.findFlowProps(
			// _processid, IWorkflowProcess.ENTITY_NAME, "svgwidth");
			// if (_svgwidthlist.size() > 0) {
			// IWorkflowFlowProps _svgwidthprops = _svgwidthlist.get(0);
			// _svgwidthprops.setValue(Integer.toString(_svgwidth));
			// _workdraw.saveFlowProps(_svgwidthprops);
			// } else {
			// _workdraw.addFlowProp("svgwidth", "value",
			// Integer.toString(_svgwidth), _processid,
			// IWorkflowProcess.ENTITY_NAME);
			// }
			//
			// List<IWorkflowFlowProps> _svgheightlist =
			// _workdraw.findFlowProps(
			// _processid, IWorkflowProcess.ENTITY_NAME, "svgheight");
			// if (_svgheightlist.size() > 0) {
			// IWorkflowFlowProps _svgheightprops = _svgheightlist.get(0);
			// _svgheightprops.setValue(Integer.toString(_svgheight));
			// _workdraw.saveFlowProps(_svgheightprops);
			// } else {
			// _workdraw.addFlowProp("svgheight", "value",
			// Integer.toString(_svgheight), _processid,
			// IWorkflowProcess.ENTITY_NAME);
			// }
		} catch (Exception e) {
			logger.info("数据读取失败", e);
			return "数据有误，保存失败";
		}

		return null;
	}

	public Object getOwnerLinkOriginListJSON() {
		// IWorkflowBaseService _workbase = WorkflowServiceFactory
		// .getWorkflowBaseService();
		// List<Map> _ownerlinkoriginlist = _workbase
		// .findParaListByName("OwnerLinkOrigin");
		// List<Map> _autoskiplist = _workbase.findParaListByName("AutoSkip");
		//
		List<Map> _res = new LinkedList<Map>();
		// Map _map = new HashMap();
		// _map.put("ownerlinkoriginlist", _ownerlinkoriginlist);
		// _map.put("autoskiplist", _autoskiplist);
		// _res.add(_map);
		try {
			response.getWriter().println(new JSONArray(_res));
		} catch (IOException e) {
			logger.info("返回结果时异常", e);
		}
		return null;
	}

	public Object checkStepName() { // 貌似没有意义
		String _stepname = request.getParameter("stepname");
		Boolean _res = true;
		if (StringUtils.isNotBlank(_stepname)) {

		} else {
			_res = false;
		}
		try {
			response.getWriter().println(_res);
		} catch (IOException e) {
			logger.info("返回结果时异常", e);
		}
		return null;
	}

	/**
	 * ajax
	 * 
	 * @return
	 */
	@RequestMapping("drawprocess/getProcessTypeName")
	@ResponseBody
	public Object getPointtypeList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);

		if (_processtype > 0) {
			List<Map> _res = findProcessListWithHeader("StepStage",
					_processtype);
			try {
				response.getWriter().println(new JSONArray(_res));
			} catch (IOException e) {
				logger.info("返回结果时异常", e);
			}
		}
		return null;
	}

	@RequestMapping("drawprocess/getProcessUrlList")
	@ResponseBody
	public Object getProcessUrlList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			// List<Map> _pointtypelist = WorkflowServiceFactory
			// .getWorkflowBaseService().getProcessUrlListByType(
			// _processtype);
			List<Map> _res = new LinkedList<Map>();
			// Map _map = new HashMap();
			// _map.put("name", "无");
			// _map.put("value", 0);
			// _res.add(_map);
			//
			// for (Map map : _pointtypelist) {
			// _map = new HashMap();
			// _map.put("name", MapUtils.getString(map, "name", ""));
			// _map.put("value", MapUtils.getIntValue(map, "key", 0));
			// _res.add(_map);
			// }

			try {
				response.getWriter().println(new JSONArray(_res));
			} catch (IOException e) {
				logger.info("返回结果时异常", e);
			}
		}
		return null;
	}

	@RequestMapping("drawprocess/getSubmitOwnerList")
	@ResponseBody
	public Object getSubmitOwnerList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map> _res = findProcessListNoHeader("SubmitOwner",
					_processtype);
			try {
				response.getWriter().println(new JSONArray(_res));
			} catch (IOException e) {
				logger.info("返回结果时异常", e);
			}
		}
		return null;
	}

	@RequestMapping("drawprocess/getJudgeTypeList")
	@ResponseBody
	public Object getJudgeTypeList() {
		List<Map> _res = new LinkedList<Map>();
		Map _map = new HashMap();

		List<Map> _judgetypelist = findProcessListNoHeader("JudgeType", 0);
		_map.put("JudgeType", _judgetypelist);

		List<Map> _coojudgelist = findProcessListNoHeader("CooJudge", 0);
		_map.put("CooJudge", _coojudgelist);

		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map> _resultdeal = new LinkedList<Map>();
			Map _hh = new HashMap();
			_hh.put("name", "请选择");
			_hh.put("value", 0);
			_resultdeal.add(_hh);
			_resultdeal.addAll(findProcessListNoHeader("ResultDeal",
					_processtype));
			_map.put("ResultDeal", _resultdeal);
		}
		try {
			_res.add(_map);
			response.getWriter().println(new JSONArray(_res));
		} catch (IOException e) {
			logger.info("返回结果时异常", e);
		}
		return null;
	}

	@RequestMapping("drawprocess/getStepDealerList")
	@ResponseBody
	public Object getStepDealerList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map> _res = findProcessListWithHeader("StepDealer",
					_processtype);
			try {
				response.getWriter().println(new JSONArray(_res));
			} catch (IOException e) {
				logger.info("返回结果时异常", e);
			}
		}
		return null;
	}

	@RequestMapping("drawprocess/getStepConditionList")
	@ResponseBody
	public Object getStepConditionList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map> _res = new LinkedList<Map>();
			Map _map = new HashMap();

			List<Map> _linkiftypelist = findProcessListNoHeader("LinkIfType",
					_processtype);
			_map.put("LinkIfType", _linkiftypelist);

			List<Map> _mathmarklist = findProcessListNoHeader("MathMark", 0);
			_map.put("MathMark", _mathmarklist);

			List<Map> _linkifresultlist = findProcessListNoHeader(
					"LinkIfResult", 0);
			_map.put("LinkIfResult", _linkifresultlist);

			List<Map> _judgeresultlist = findProcessListNoHeader("JudgeResult",
					0);
			_map.put("JudgeResult", _judgeresultlist);

			try {
				_res.add(_map);
				response.getWriter().println(new JSONArray(_res));
			} catch (IOException e) {
				logger.info("返回结果时异常", e);
			}
		}
		return null;
	}

	@RequestMapping("drawprocess/getMessageRemindList")
	@ResponseBody
	public Object getMessageRemindList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map> _res = new LinkedList<Map>();
			Map _map = new HashMap();
			_map.put("name", "无");
			_map.put("value", "");
			_res.add(_map);

			// Map<String, String> messagemap = CommonServiceFactory
			// .getMessageService()
			// .findTemplateByProcessType(_processtype);
			// for (String _key : messagemap.keySet()) {
			// String _value = messagemap.get(_key);
			// _map = new HashMap();
			// _map.put("name", _value);
			// _map.put("value", _key);
			// _res.add(_map);
			// }

			try {

				response.getWriter().println(new JSONArray(_res));
			} catch (IOException e) {
				logger.info("返回结果时异常", e);
			}
		}
		return null;
	}

	@RequestMapping("drawprocess/getMessageNoticeList")
	@ResponseBody
	public Object getMessageNoticeList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map> _res = new LinkedList<Map>();
			Map _map = new HashMap();

			List<Map> messagelist = new LinkedList<Map>();
			_map = new HashMap();
			_map.put("name", "无");
			_map.put("value", "");
			messagelist.add(_map);
			// Map<String, String> messagemap = CommonServiceFactory
			// .getMessageService()
			// .findTemplateByProcessType(_processtype);
			// for (String _key : messagemap.keySet()) {
			// String _value = messagemap.get(_key);
			// _map = new HashMap();
			// _map.put("name", _value);
			// _map.put("value", _key);
			// messagelist.add(_map);
			// }

			List<Map> stepdealerlist = findProcessListWithHeader("StepDealer",
					_processtype);

			try {
				_map = new HashMap();
				_map.put("messagenotice", messagelist);
				_map.put("specialnoticer", stepdealerlist);
				_res.add(_map);
				response.getWriter().println(new JSONArray(_res));
			} catch (IOException e) {
				logger.info("返回结果时异常", e);
			}
		}
		return null;
	}

	@RequestMapping("drawprocess/getSpecialTaskList")
	@ResponseBody
	public Object getSpecialTaskList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map> _res = this.findProcessListWithHeader("SpecialTask",
					_processtype);
			// try {
			return new JSONArray(_res);
			/*
			 * } catch (IOException e) { logger.info("返回结果时异常", e); }
			 */
		}
		return null;
	}

	private List<Map> findProcessListWithHeader(String name, int processtype) {
		List<Map> _res = new LinkedList<Map>();
		// List<Map> _processlist = WorkflowServiceFactory
		// .getWorkflowBaseService().findParaListByNameAndType(name,
		// processtype);
		Map _map = new HashMap();
		_map.put("name", "无");
		_map.put("value", 0);
		_res.add(_map);

		// for (Map map : _processlist) {
		// _map = new HashMap();
		// _map.put("name", MapUtils.getString(map, "value", ""));
		// _map.put("value", MapUtils.getIntValue(map, "key", 0));
		// _res.add(_map);
		// }
		return _res;
	}

	private List<Map> findProcessListNoHeader(String name, int processtype) {
		List<Map> _res = new LinkedList<Map>();
		// List<Map> _processlist = WorkflowServiceFactory
		// .getWorkflowBaseService().findParaListByNameAndType(name,
		// processtype);
		// for (Map map : _processlist) {
		// Map _map = new HashMap();
		// _map.put("name", MapUtils.getString(map, "value", ""));
		// _map.put("value", MapUtils.getIntValue(map, "key", 0));
		// _res.add(_map);
		// }
		return _res;
	}

}
