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
import com.hjon.modules.workflow.entity.FlowProps;
import com.hjon.modules.workflow.service.FlowPropsService;
import com.hjon.modules.workflow.service.ProcessListService;
import com.hjon.modules.workflow.service.ProcessUrlService;

@Controller
@Scope("prototype")
public class DrawProcessController extends BaseController {
	Logger logger = Logger.getLogger(DrawProcessController.class);
	
	@Resource(name = "processListService")
	private ProcessListService processListService;

	@Resource(name = "flowPropsService")
	private FlowPropsService flowPropsService;

	@Resource(name = "processUrlService")
	private ProcessUrlService processUrlService;

	/**
	 * ajax，通过processtype获得名称
	 * 
	 * @return
	 */
	@RequestMapping("drawprocess/getProcessTypeName")
	@ResponseBody
	public String getProcessTypeName() {
		int _processtype = NumberUtils.safeToInteger(
				this.getParameter("processtype"), 1);
		String _processtypename = "";

		if (_processtype > 0) {
			List<Map<String, Object>> mapList = processListService
					.findParaByNameAndKey("ProcessType", _processtype);
			if (mapList != null && mapList.size() > 0) {
				_processtypename = MapUtils.getString(mapList.get(0), "value",
						"");
			}
			return _processtypename;
		}
		return null;
	}

	@RequestMapping("drawprocess/saveMyFlow")
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
			// TODO
			// _workdraw.saveFlowData(_processid, _myflow);
		} catch (JSONException e) {
			logger.info("数据读取失败", e);
			return "数据有误，保存失败";
		}

		return null;
	}

	@RequestMapping("drawprocess/saveSvgSize")
	@ResponseBody
	public Object saveSvgSize(Map map, HttpServletRequest request) {
		// IWorkflowDrawService _workdraw = WorkflowServiceFactory
		// .getWorkflowDrawService();

		int _processid = MapUtils.getIntValue(map, "processid", 0);
		int _svgwidth = MapUtils.getIntValue(map, "svgwidth", 3000);
		int _svgheight = MapUtils.getIntValue(map, "svgheight", 1000);

		try {
			// List<IWorkflowFlowProps> _svgwidthlist = _workdraw.findFlowProps(
			// _processid, IWorkflowProcess.ENTITY_NAME, "svgwidth");
			List<FlowProps> _svgwidthlist = flowPropsService.findFlowProps(
					_processid, FlowProps.ENTITY_NAME, "svgwidth");
			if (_svgwidthlist.size() > 0) {
				FlowProps _svgwidthprops = _svgwidthlist.get(0);
				_svgwidthprops.setValue(Integer.toString(_svgwidth));
				flowPropsService.saveFlowProps(_svgwidthprops);
			} else {

				flowPropsService.addFlowProp("svgwidth", "value",
						Integer.toString(_svgwidth), _processid,
						FlowProps.ENTITY_NAME);
			}

			List<FlowProps> _svgheightlist = flowPropsService.findFlowProps(
					_processid, FlowProps.ENTITY_NAME, "svgheight");
			if (_svgheightlist.size() > 0) {
				FlowProps _svgheightprops = _svgheightlist.get(0);
				_svgheightprops.setValue(Integer.toString(_svgheight));
				flowPropsService.saveFlowProps(_svgheightprops);
			} else {
				flowPropsService.addFlowProp("svgheight", "value",
						Integer.toString(_svgheight), _processid,
						FlowProps.ENTITY_NAME);
			}
		} catch (Exception e) {
			logger.info("数据读取失败", e);
			return "数据有误，保存失败";
		}

		return null;
	}

	@RequestMapping("drawprocess/getOwnerLinkOriginListJSON")
	@ResponseBody
	public Object getOwnerLinkOriginListJSON() {
		// IWorkflowBaseService _workbase = WorkflowServiceFactory
		// .getWorkflowBaseService();
		List<Map<String, Object>> _ownerlinkoriginlist = processListService
				.findParaListByName("OwnerLinkOrigin");
		List<Map<String, Object>> _autoskiplist = processListService
				.findParaListByName("AutoSkip");

		List<Map<String, Object>> _res = new LinkedList<Map<String, Object>>();
		Map<String, Object> _map = new HashMap<String, Object>();
		_map.put("ownerlinkoriginlist", _ownerlinkoriginlist);
		_map.put("autoskiplist", _autoskiplist);
		_res.add(_map);
		JSONArray result=new JSONArray(_res);
		return new JSONArray(_res).toString();
		// try {
		// response.getWriter().println(new JSONArray(_res));
		// } catch (IOException e) {
		// logger.info("返回结果时异常", e);
		// }
	}

	public Object checkStepName() { // 貌似没有意义
		String _stepname = request.getParameter("stepname");
		Boolean _res = true;
		if (StringUtils.isNotBlank(_stepname)) {

		} else {
			_res = false;
		}
		// try {
		// response.getWriter().println(_res);
		// } catch (IOException e) {
		// logger.info("返回结果时异常", e);
		// }
		return _res;
	}

	@RequestMapping("drawprocess/getPointtypeList")
	@ResponseBody
	public Object getPointtypeList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);

		if (_processtype > 0) {
			List<Map<String, Object>> _res = findProcessListWithHeader(
					"StepStage", _processtype);
			/*
			 * try { response.getWriter().println(new JSONArray(_res)); } catch
			 * (IOException e) { logger.info("返回结果时异常", e); }
			 */
			JSONArray result=new JSONArray(_res);
			return new JSONArray(_res).toString();
		}
		return null;
	}

	@RequestMapping("drawprocess/getProcessUrlList")
	@ResponseBody
	public Object getProcessUrlList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			// List<Map<String, Object>> _pointtypelist = WorkflowServiceFactory
			// .getWorkflowBaseService().getProcessUrlListByType(
			// _processtype);
			List<Map<String, Object>> _pointtypelist = processUrlService
					.getProcessUrlListByType(_processtype);
			List<Map<String, Object>> _res = new LinkedList<Map<String, Object>>();
			Map<String, Object> _map = new HashMap<String, Object>();
			// _map.put("name", "无");
			// _map.put("value", 0);
			// _res.add(_map);
			//
			for (Map<String, Object> map : _pointtypelist) {
				_map = new HashMap<String, Object>();
				_map.put("name", MapUtils.getString(map, "name", ""));
				_map.put("value", MapUtils.getIntValue(map, "keyvalue", 0));
				_res.add(_map);
			}
			JSONArray result=new JSONArray(_res);
			return new JSONArray(_res).toString();
			// try {
			// response.getWriter().println(new JSONArray(_res));
			// } catch (IOException e) {
			// logger.info("返回结果时异常", e);
			// }
		}
		return null;
	}

	@RequestMapping("drawprocess/getSubmitOwnerList")
	@ResponseBody
	public Object getSubmitOwnerList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map<String, Object>> _res = findProcessListNoHeader(
					"SubmitOwner", _processtype);
			JSONArray result=new JSONArray(_res);
			return new JSONArray(_res).toString();
			// try {
			// response.getWriter().println(new JSONArray(_res));
			// } catch (IOException e) {
			// logger.info("返回结果时异常", e);
			// }
		}
		return null;
	}

	@RequestMapping("drawprocess/getJudgeTypeList")
	@ResponseBody
	public Object getJudgeTypeList() {
		List<Map<String, Object>> _res = new LinkedList<Map<String, Object>>();
		Map<String, Object> _map = new HashMap<String, Object>();

		List<Map<String, Object>> _judgetypelist = findProcessListNoHeader(
				"JudgeType", 0);
		_map.put("JudgeType", _judgetypelist);

		List<Map<String, Object>> _coojudgelist = findProcessListNoHeader(
				"CooJudge", 0);
		_map.put("CooJudge", _coojudgelist);

		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map<String, Object>> _resultdeal = new LinkedList<Map<String, Object>>();
			Map<String, Object> _hh = new HashMap<String, Object>();
			_hh.put("name", "请选择");
			_hh.put("value", 0);
			_resultdeal.add(_hh);
			_resultdeal.addAll(findProcessListNoHeader("ResultDeal",
					_processtype));
			_map.put("ResultDeal", _resultdeal);
		}
		JSONArray result=new JSONArray(_res);
		return new JSONArray(_res).toString();
		// try {
		// _res.add(_map);
		// response.getWriter().println(new JSONArray(_res));
		// } catch (IOException e) {
		// logger.info("返回结果时异常", e);
		// }
	}

	@RequestMapping("drawprocess/getStepDealerList")
	@ResponseBody
	public Object getStepDealerList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map<String, Object>> _res = findProcessListWithHeader(
					"StepDealer", _processtype);
			JSONArray result=new JSONArray(_res);
			return new JSONArray(_res).toString();
			// try {
			// response.getWriter().println(new JSONArray(_res));
			// } catch (IOException e) {
			// logger.info("返回结果时异常", e);
			// }
		}
		return null;
	}

	@RequestMapping("drawprocess/getStepConditionList")
	@ResponseBody
	public Object getStepConditionList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map<String, Object>> _res = new LinkedList<Map<String, Object>>();
			Map<String, Object> _map = new HashMap<String, Object>();

			List<Map<String, Object>> _linkiftypelist = findProcessListNoHeader(
					"LinkIfType", _processtype);
			_map.put("LinkIfType", _linkiftypelist);

			List<Map<String, Object>> _mathmarklist = findProcessListNoHeader(
					"MathMark", 0);
			_map.put("MathMark", _mathmarklist);

			List<Map<String, Object>> _linkifresultlist = findProcessListNoHeader(
					"LinkIfResult", 0);
			_map.put("LinkIfResult", _linkifresultlist);

			List<Map<String, Object>> _judgeresultlist = findProcessListNoHeader(
					"JudgeResult", 0);
			_map.put("JudgeResult", _judgeresultlist);
			JSONArray result=new JSONArray(_res);
			return new JSONArray(_res).toString();
			// try {
			// _res.add(_map);
			// response.getWriter().println(new JSONArray(_res));
			// } catch (IOException e) {
			// logger.info("返回结果时异常", e);
			// }
		}
		return null;
	}

	@RequestMapping("drawprocess/getMessageRemindList")
	@ResponseBody
	public Object getMessageRemindList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map<String, Object>> _res = new LinkedList<Map<String, Object>>();
			Map<String, Object> _map = new HashMap<String, Object>();
			Map<String, String> messagemap = new HashMap<String, String>();
			// TODO 需要添加Message方法
			// Map<String, String> messagemap = CommonServiceFactory
			// .getMessageService()
			// .findTemplateByProcessType(_processtype);

			for (String _key : messagemap.keySet()) {
				String _value = messagemap.get(_key);
				_map = new HashMap<String, Object>();
				_map.put("name", _value);
				_map.put("value", _key);
				_res.add(_map);
			}
			JSONArray result=new JSONArray(_res);
			return new JSONArray(_res).toString();
			// try {
			//
			// response.getWriter().println(new JSONArray(_res));
			// } catch (IOException e) {
			// logger.info("返回结果时异常", e);
			// }
		}
		return null;
	}

	@RequestMapping("drawprocess/getMessageNoticeList")
	@ResponseBody
	public Object getMessageNoticeList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 0);
		if (_processtype > 0) {
			List<Map<String, Object>> _res = new LinkedList<Map<String, Object>>();
			Map<String, Object> _map = new HashMap<String, Object>();

			List<Map<String, Object>> messagelist = new LinkedList<Map<String, Object>>();
			Map<String, String> messagemap = new HashMap<String, String>();
			// TODO 需要添加Message方法
			// Map<String, String> messagemap = CommonServiceFactory
			// .getMessageService()
			// .findTemplateByProcessType(_processtype);
			for (String _key : messagemap.keySet()) {
				String _value = messagemap.get(_key);
				_map = new HashMap<String, Object>();
				_map.put("name", _value);
				_map.put("value", _key);
				messagelist.add(_map);
			}

			List<Map<String, Object>> stepdealerlist = findProcessListWithHeader(
					"StepDealer", _processtype);

			// try {
			_map = new HashMap<String, Object>();
			_map.put("messagenotice", messagelist);
			_map.put("specialnoticer", stepdealerlist);
			_res.add(_map);
			// response.getWriter().println(new JSONArray(_res));
			// } catch (IOException e) {
			// logger.info("返回结果时异常", e);
			// }
			JSONArray result=new JSONArray(_res);
			return new JSONArray(_res).toString();
		}
		return null;
	}

	@RequestMapping("drawprocess/getSpecialTaskList")
	@ResponseBody
	public Object getSpecialTaskList() {
		int _processtype = NumberUtils.safeToInteger(
				request.getParameter("processtype"), 1);
		if (_processtype > 0) {
			List<Map<String, Object>> _res = this.findProcessListWithHeader(
					"SpecialTask", _processtype);
			// try {
			// response.getWriter().println(new JSONArray(_res));
			// } catch (IOException e) { logger.info("返回结果时异常", e);
			// }
			JSONArray result=new JSONArray(_res);
			return new JSONArray(_res).toString();
		}
		return null;
	}

	private List<Map<String, Object>> findProcessListWithHeader(String name,
			int processtype) {
		List<Map<String, Object>> _res = new LinkedList<Map<String, Object>>();
		// List<Map> _processlist = WorkflowServiceFactory
		// .getWorkflowBaseService().findParaListByNameAndType(name,
		// processtype);
		List<Map<String, Object>> _processlist = processListService
				.findParaByNameAndKey(name, processtype);
		Map<String, Object> _map = new HashMap<String, Object>();
		// _map.put("name", "无");
		// _map.put("value", 0);
		// _res.add(_map);

		for (Map<String, Object> map : _processlist) {
			_map = new HashMap<String, Object>();
			_map.put("name", MapUtils.getString(map, "value", ""));
			_map.put("value", MapUtils.getIntValue(map, "key", 0));
			_res.add(_map);
		}
		return _res;
	}

	private List<Map<String, Object>> findProcessListNoHeader(String name,
			int processtype) {
		List<Map<String, Object>> _res = new LinkedList<Map<String, Object>>();
		// List<Map> _processlist = WorkflowServiceFactory
		// .getWorkflowBaseService().findParaListByNameAndType(name,
		// processtype);
		List<Map<String, Object>> _processlist = processListService
				.findParaByNameAndKey(name, processtype);
		for (Map<String, Object> map : _processlist) {
			Map<String, Object> _map = new HashMap<String, Object>();
			_map.put("name", MapUtils.getString(map, "value", ""));
			_map.put("value", MapUtils.getIntValue(map, "key", 0));
			_res.add(_map);
		}
		return _res;
	}

}
