package com.hjon.modules.workflow.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.utils.StringUtils;
import com.hjon.modules.workflow.entity.ProcessInfo;
import com.hjon.modules.workflow.entity.ProcessStep;

import freemarker.template.utility.StringUtil;

@Service
@Transactional
public class DrawPorcessService {
	Logger logger = Logger.getLogger(DrawPorcessService.class);

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

	@Resource(name = "processStepService")
	private ProcessStepService processStepService;

	public Map changeProcess(int processid) {
		// IWorkflowDrawService _workdraw = WorkflowServiceFactory
		// .getWorkflowDrawService();
		// IWorkflowBaseService _workbase = WorkflowServiceFactory
		// .getWorkflowBaseService();
		// IWorkflowProcess _process = _workbase.loadProcess(processid);
		ProcessInfo process = processService.get(processid);
		if (process == null) {
			logger.info("ID:" + processid + "的流程不存在");
			return null;
		} else {
			HashMap _myflow = new HashMap();
			int num = 1;
			HashMap _parammap = new HashMap();
			HashMap status = new HashMap();
			HashMap paths = new HashMap();
			int _posx = 100;
			int _posy = 50;
			// List _steplist = _workbase.getSingleStepList(processid);
			List<ProcessStep> stepList = processStepService.queryByProperty(
					"processid", processid);
			Iterator<ProcessStep> stepIterator = stepList.iterator();

			HashMap _tp;
			String _torect;
			int path;
			int var58;
			String var67;
			String var69;
			Iterator var76;
			List var79;
			Map var81;
			int var86;
			String var88;
			int var90;
			String var94;
			while (stepIterator.hasNext()) {
				// Map i$ = (Map) _statemap.next();
				// int _stepmap = MapUtils.getIntValue(i$, "processstepid", 0);
				// IWorkflowProcessStep _processstepid = _workbase
				// .loadProcessStep(_stepmap);
				ProcessStep processStep = stepIterator.next();
				HashMap _processstep;
				HashMap _linklist;
				if (processStep.getSteptypeid().intValue() == WorkflowStepType.WF_TYPE_START
						.getEnumItemValue()) {
					_processstep = new HashMap();
					_processstep.put("type", "start");
					_tp = new HashMap();
					_tp.put("text", _processstepid.getName());
					_processstep.put("text", _tp);
					_tp = new HashMap();
					_tp.put("height", Integer.valueOf(50));
					_tp.put("width", Integer.valueOf(50));
					_tp.put("y", Integer.valueOf(_posy));
					_tp.put("x", Integer.valueOf(_posx));
					_processstep.put("attr", _tp);
					_parammap.put("_posx" + _stepmap, Integer.valueOf(_posx));
					_parammap.put("_posy" + _stepmap, Integer.valueOf(_posy));
					_posy += 100;
					_posx += 200;
					_linklist = new HashMap();
					_tp = new HashMap();
					_tp.put("value", "开始节点");
					_linklist.put("steptype", _tp);
					_tp = new HashMap();
					_tp.put("value", _processstepid.getName());
					_linklist.put("stepname", _tp);
					_tp = new HashMap();
					_tp.put("value", _processstepid.getStepCode());
					_linklist.put("stepcode", _tp);
					_processstep.put("props", _linklist);
					status.put("rect" + num, _processstep);
					_parammap.put("_rect" + _stepmap, "rect" + num);
					++num;
				} else {
					String i$1;
					if (_processstepid.getStepTypeId().intValue() == WorkflowStepType.WF_TYPE_END
							.getEnumItemValue()) {
						_processstep = new HashMap();
						_processstep.put("type", "end");
						_tp = new HashMap();
						_tp.put("text", _processstepid.getName());
						_processstep.put("text", _tp);
						_tp = new HashMap();
						_tp.put("height", Integer.valueOf(50));
						_tp.put("width", Integer.valueOf(50));
						_tp.put("y", Integer.valueOf(_posy));
						_tp.put("x", Integer.valueOf(_posx));
						_processstep.put("attr", _tp);
						_parammap.put("_posx" + _stepmap,
								Integer.valueOf(_posx));
						_parammap.put("_posy" + _stepmap,
								Integer.valueOf(_posy));
						_posy += 100;
						_posx += 200;
						_linklist = new HashMap();
						_tp = new HashMap();
						_tp.put("value", "结束节点");
						_linklist.put("steptype", _tp);
						_tp = new HashMap();
						_tp.put("value", _processstepid.getName());
						_linklist.put("stepname", _tp);
						_tp = new HashMap();
						_tp.put("value", _processstepid.getStepCode());
						_linklist.put("stepcode", _tp);
						i$1 = "";
						List var52 = _workbase.getProcessStepDoList(_stepmap,
								WorkflowStepDoType.WF_DOTYPE_PREDO
										.getEnumItemValue());
						if (var52.size() > 0) {
							for (Iterator var56 = var52.iterator(); var56
									.hasNext(); i$1 = i$1 + var58) {
								Map var59 = (Map) var56.next();
								var58 = MapUtils
										.getIntValue(var59, "taskid", 0);
								if (i$1.length() > 0) {
									i$1 = i$1 + ",";
								}
							}
						}

						_tp = new HashMap();
						_tp.put("value", i$1);
						_linklist.put("steppredo", _tp);
						_processstep.put("props", _linklist);
						status.put("rect" + num, _processstep);
						_parammap.put("_rect" + _stepmap, "rect" + num);
						++num;
					} else {
						String _sort;
						String _aftstepid;
						int _stepcondition;
						Iterator _steplinkdo;
						Map _linkiflist;
						int _linkdolist;
						String var89;
						if (_processstepid.getStepTypeId().intValue() == WorkflowStepType.WF_TYPE_SUBMIT
								.getEnumItemValue()) {
							_processstep = new HashMap();
							_processstep.put("type", "submit");
							_tp = new HashMap();
							_tp.put("text", _processstepid.getName());
							_processstep.put("text", _tp);
							_tp = new HashMap();
							_tp.put("height", Integer.valueOf(50));
							_tp.put("width", Integer.valueOf(100));
							_tp.put("y", Integer.valueOf(_posy));
							_tp.put("x", Integer.valueOf(_posx));
							_processstep.put("attr", _tp);
							_parammap.put("_posx" + _stepmap,
									Integer.valueOf(_posx));
							_parammap.put("_posy" + _stepmap,
									Integer.valueOf(_posy));
							_posy += 100;
							_posx += 200;
							_linklist = new HashMap();
							_tp = new HashMap();
							_tp.put("value", _processstepid.getName());
							_linklist.put("stepname", _tp);
							_tp = new HashMap();
							_tp.put("value", _processstepid.getStepCode());
							_linklist.put("stepcode", _tp);
							_tp = new HashMap();
							_tp.put("value", "提交节点");
							_linklist.put("steptype", _tp);
							_tp = new HashMap();
							_tp.put("value", String.valueOf(_processstepid
									.getPointTypeId()));
							_linklist.put("pointtypeid", _tp);
							_tp = new HashMap();
							_tp.put("value",
									String.valueOf(_processstepid.getUrlMark()));
							_linklist.put("processurl", _tp);
							_tp = new HashMap();
							i$1 = _processstepid.getStepTypeAds();
							int var51 = NumberTool.safeToInteger(i$1,
									Integer.valueOf(0)).intValue();
							_tp.put("value", String.valueOf(var51));
							_linklist.put("submitowner", _tp);
							List var55 = _workbase.getOwnerList(0, _stepmap);
							_sort = "";
							var58 = 0;
							Iterator var61 = var55.iterator();

							while (var61.hasNext()) {
								Map var62 = (Map) var61.next();
								int var66 = MapUtils.getIntValue(var62,
										"orgid", 0);
								_stepcondition = MapUtils.getIntValue(var62,
										"orgtype", 0);
								var69 = MapUtils
										.getString(var62, "orgname", "");
								if (_stepcondition == -1) {
									var58 = var66;
								} else if (_stepcondition != -2) {
									if (_sort.length() > 0) {
										_sort = _sort + ",";
									}

									_sort = _sort + var66 + ":" + var69 + ":"
											+ _stepcondition;
								}
							}

							_tp = new HashMap();
							_tp.put("value", _sort);
							_linklist.put("conditionowner", _tp);
							_tp = new HashMap();
							_tp.put("value", String.valueOf(var58));
							_linklist.put("stepdealer", _tp);
							_tp = new HashMap();
							_tp.put("value", String.valueOf(NumberTool
									.safeToInteger(
											_processstepid.getAgentType(),
											Integer.valueOf(2))));
							_linklist.put("agenttype", _tp);
							_tp = new HashMap();
							_tp.put("value", String.valueOf(NumberTool
									.safeToInteger(
											_processstepid.getPhoneshow(),
											Integer.valueOf(-1))));
							_linklist.put("phoneshow", _tp);
							_aftstepid = _processstepid.getCondition();
							String[] var64 = _aftstepid.split(";");
							if (var64.length >= 6) {
								_torect = var64[0];
								_tp = new HashMap();
								_tp.put("value", _torect);
								_linklist.put("messageremind", _tp);
								var67 = var64[3];
								var69 = var64[5];
								String var71 = "";
								var79 = _workbase.getOwnerListByGoto(0,
										_stepmap, -2);

								for (var76 = var79.iterator(); var76.hasNext(); var71 = var71
										+ var90 + ":" + var89 + ":" + var86) {
									var81 = (Map) var76.next();
									var90 = MapUtils.getIntValue(var81,
											"orgid", 0);
									var86 = MapUtils.getIntValue(var81,
											"orgtype", 0);
									var89 = MapUtils.getString(var81,
											"orgname", "");
									if (var71.length() > 0) {
										var71 = var71 + ",";
									}
								}

								_tp = new HashMap();
								_tp.put("value", var67);
								_tp.put("noticeowners", var71);
								_tp.put("specialnoticer", var69);
								_linklist.put("messagenotice", _tp);
							}

							_torect = "";
							List var68 = _workbase.getProcessStepDoList(
									_stepmap,
									WorkflowStepDoType.WF_DOTYPE_PREDO
											.getEnumItemValue());
							if (var68.size() > 0) {
								for (_steplinkdo = var68.iterator(); _steplinkdo
										.hasNext(); _torect = _torect
										+ _linkdolist) {
									_linkiflist = (Map) _steplinkdo.next();
									_linkdolist = MapUtils.getIntValue(
											_linkiflist, "taskid", 0);
									if (_torect.length() > 0) {
										_torect = _torect + ",";
									}
								}
							}

							_tp = new HashMap();
							_tp.put("value", _torect);
							_linklist.put("steppredo", _tp);
							_torect = "";
							var68 = _workbase.getProcessStepDoList(_stepmap,
									WorkflowStepDoType.WF_DOTYPE_AFTDO
											.getEnumItemValue());
							if (var68.size() > 0) {
								for (_steplinkdo = var68.iterator(); _steplinkdo
										.hasNext(); _torect = _torect
										+ _linkdolist) {
									_linkiflist = (Map) _steplinkdo.next();
									_linkdolist = MapUtils.getIntValue(
											_linkiflist, "taskid", 0);
									if (_torect.length() > 0) {
										_torect = _torect + ",";
									}
								}
							}

							_tp = new HashMap();
							_tp.put("value", _torect);
							_linklist.put("stepaftdo", _tp);
							_processstep.put("props", _linklist);
							status.put("rect" + num, _processstep);
							_parammap.put("_rect" + _stepmap, "rect" + num);
							++num;
						} else if (_processstepid.getStepTypeId().intValue() == WorkflowStepType.WF_TYPE_DEAL
								.getEnumItemValue()) {
							_processstep = new HashMap();
							_processstep.put("type", "judge");
							_tp = new HashMap();
							_tp.put("text", _processstepid.getName());
							_processstep.put("text", _tp);
							_tp = new HashMap();
							_tp.put("height", Integer.valueOf(50));
							_tp.put("width", Integer.valueOf(100));
							_tp.put("y", Integer.valueOf(_posy));
							_tp.put("x", Integer.valueOf(_posx));
							_processstep.put("attr", _tp);
							_parammap.put("_posx" + _stepmap,
									Integer.valueOf(_posx));
							_parammap.put("_posy" + _stepmap,
									Integer.valueOf(_posy));
							_posy += 100;
							_posx += 200;
							_linklist = new HashMap();
							_tp = new HashMap();
							_tp.put("value", _processstepid.getName());
							_linklist.put("stepname", _tp);
							_tp = new HashMap();
							_tp.put("value", _processstepid.getStepCode());
							_linklist.put("stepcode", _tp);
							_tp = new HashMap();
							_tp.put("value", "处理节点");
							_linklist.put("steptype", _tp);
							_tp = new HashMap();
							_tp.put("value", String.valueOf(_processstepid
									.getPointTypeId()));
							_linklist.put("pointtypeid", _tp);
							_tp = new HashMap();
							_tp.put("value",
									String.valueOf(_processstepid.getUrlMark()));
							_linklist.put("processurl", _tp);
							_tp = new HashMap();
							i$1 = _processstepid.getStepTypeAds();
							String[] _linkmap = i$1.split(" ");
							String _linkid = _linkmap[0];
							_sort = "";
							String _prestepid = "";
							_aftstepid = "";
							if (NumberTool.safeToInteger(_linkid,
									Integer.valueOf(0)).intValue() != 2
									&& NumberTool.safeToInteger(_linkid,
											Integer.valueOf(0)).intValue() != 5) {
								if (NumberTool.safeToInteger(_linkid,
										Integer.valueOf(0)).intValue() == 100) {
									_aftstepid = _linkmap[1];
								}
							} else {
								_sort = _linkmap[1];
								_prestepid = _linkmap[2];
							}

							_tp.put("value", _linkid + ":" + _sort + ":"
									+ _prestepid + ":" + _aftstepid);
							_linklist.put("judgetype", _tp);
							List _fromrect = _workbase
									.getOwnerList(0, _stepmap);
							_torect = "";
							_stepcondition = 0;
							_steplinkdo = _fromrect.iterator();

							String props;
							while (_steplinkdo.hasNext()) {
								_linkiflist = (Map) _steplinkdo.next();
								_linkdolist = MapUtils.getIntValue(_linkiflist,
										"orgid", 0);
								path = MapUtils.getIntValue(_linkiflist,
										"orgtype", 0);
								props = MapUtils.getString(_linkiflist,
										"orgname", "");
								if (path == -1) {
									_stepcondition = _linkdolist;
								} else if (path != -2) {
									if (_torect.length() > 0) {
										_torect = _torect + ",";
									}

									_torect = _torect + _linkdolist + ":"
											+ props + ":" + path;
								}
							}

							_tp = new HashMap();
							_tp.put("value", _torect);
							_linklist.put("conditionowner", _tp);
							_tp = new HashMap();
							_tp.put("value", String.valueOf(_stepcondition));
							_linklist.put("stepdealer", _tp);
							_tp = new HashMap();
							_tp.put("value", String.valueOf(NumberTool
									.safeToInteger(
											_processstepid.getAgentType(),
											Integer.valueOf(2))));
							_linklist.put("agenttype", _tp);
							_tp = new HashMap();
							_tp.put("value", String.valueOf(NumberTool
									.safeToInteger(
											_processstepid.getPhoneshow(),
											Integer.valueOf(-1))));
							_linklist.put("phoneshow", _tp);
							var69 = _processstepid.getCondition();
							String[] var70 = var69.split(";");
							String _aftposx;
							int path1;
							String var72;
							if (var70.length >= 6) {
								var72 = var70[0];
								_tp = new HashMap();
								_tp.put("value", var72);
								_linklist.put("messageremind", _tp);
								String var73 = var70[3];
								props = var70[5];
								_aftposx = "";
								List _aftposy = _workbase.getOwnerListByGoto(0,
										_stepmap, -2);

								int _staterect;
								String pathprops;
								for (Iterator rect = _aftposy.iterator(); rect
										.hasNext(); _aftposx = _aftposx
										+ _staterect + ":" + pathprops + ":"
										+ path1) {
									Map _stateprops = (Map) rect.next();
									_staterect = MapUtils.getIntValue(
											_stateprops, "orgid", 0);
									path1 = MapUtils.getIntValue(_stateprops,
											"orgtype", 0);
									pathprops = MapUtils.getString(_stateprops,
											"orgname", "");
									if (_aftposx.length() > 0) {
										_aftposx = _aftposx + ",";
									}
								}

								_tp = new HashMap();
								_tp.put("value", var73);
								_tp.put("noticeowners", _aftposx);
								_tp.put("specialnoticer", props);
								_linklist.put("messagenotice", _tp);
							}

							var72 = "";
							List var75 = _workbase.getProcessStepDoList(
									_stepmap,
									WorkflowStepDoType.WF_DOTYPE_PREDO
											.getEnumItemValue());
							Iterator var78;
							Map var85;
							if (var75.size() > 0) {
								for (var78 = var75.iterator(); var78.hasNext(); var72 = var72
										+ var86) {
									var85 = (Map) var78.next();
									var86 = MapUtils.getIntValue(var85,
											"taskid", 0);
									if (var72.length() > 0) {
										var72 = var72 + ",";
									}
								}
							}

							_tp = new HashMap();
							_tp.put("value", var72);
							_linklist.put("steppredo", _tp);
							var72 = "";
							var75 = _workbase.getProcessStepDoList(_stepmap,
									WorkflowStepDoType.WF_DOTYPE_AFTDO
											.getEnumItemValue());
							if (var75.size() > 0) {
								for (var78 = var75.iterator(); var78.hasNext(); var72 = var72
										+ var86) {
									var85 = (Map) var78.next();
									var86 = MapUtils.getIntValue(var85,
											"taskid", 0);
									if (var72.length() > 0) {
										var72 = var72 + ",";
									}
								}
							}

							_tp = new HashMap();
							_tp.put("value", var72);
							_linklist.put("stepaftdo", _tp);
							List var80 = _workbase.getOwnerLinkList(_stepmap);
							_aftposx = "";
							var88 = "";
							var89 = "";
							String var92 = "";
							var94 = "";

							for (path1 = 0; path1 < var80.size(); ++path1) {
								Map var96 = (Map) var80.get(path1);
								int _value = MapUtils.getIntValue(var96,
										"objid", 0);
								int _ownertype = MapUtils.getIntValue(var96,
										"linkleaf", 0);
								String _ownerstarter = StringUtil.safeToString(
										var96.get("ownerstarter"), "");
								String _ownerender = StringUtil.safeToString(
										var96.get("ownerender"), "");
								int _autoskip = MapUtils.getIntValue(var96,
										"linkroot", 1);
								_aftposx = _aftposx + (path1 == 0 ? "" : ",")
										+ _value;
								var88 = var88 + (path1 == 0 ? "" : ",")
										+ _ownertype;
								var89 = var89 + (path1 == 0 ? "" : ";")
										+ _ownerstarter;
								var92 = var92 + (path1 == 0 ? "" : ";")
										+ _ownerender;
								var94 = var94 + (path1 == 0 ? "" : ",")
										+ _autoskip;
							}

							_tp = new HashMap();
							_tp.put("value", _aftposx);
							_tp.put("ownertype", var88);
							_tp.put("ownerstarter", var89);
							_tp.put("ownerender", var92);
							_tp.put("autoskip", var94);
							_linklist.put("ownerlink", _tp);
							_processstep.put("props", _linklist);
							status.put("rect" + num, _processstep);
							_parammap.put("_rect" + _stepmap, "rect" + num);
							++num;
						}
					}
				}
			}

			HashMap var46 = new HashMap();
			Iterator var47 = _steplist.iterator();

			while (var47.hasNext()) {
				Map var48 = (Map) var47.next();
				int var49 = MapUtils.getIntValue(var48, "processstepid", 0);
				_workbase.loadProcessStep(var49);
				List var50 = _workbase.getStepLinkList(var49);

				for (Iterator var53 = var50.iterator(); var53.hasNext(); ++num) {
					Map var54 = (Map) var53.next();
					int var57 = MapUtils.getIntValue(var54, "objid", 0);
					int var60 = MapUtils.getIntValue(var54, "sort", 0);
					var58 = MapUtils.getIntValue(var54, "prestepid", 0);
					int var63 = MapUtils.getIntValue(var54, "aftstepid", 0);
					String var65 = MapUtils.getString(_parammap, "_rect"
							+ var58, "");
					_torect = MapUtils
							.getString(_parammap, "_rect" + var63, "");
					var67 = "";
					var69 = "";
					List var74 = _workbase.getStepLinkIfList(var57);
					int var82;
					if (var74.size() > 0) {
						Iterator var84 = var74.iterator();

						while (var84.hasNext()) {
							Map var77 = (Map) var84.next();
							var82 = MapUtils.getIntValue(var77, "iftype", 0);
							var90 = MapUtils.getIntValue(var77, "ifand", 0);
							var88 = MapUtils.getString(var77, "ifads", "");
							if (var67.length() > 0) {
								var67 = var67 + ",";
							}

							if (var82 >= 100000) {
								var67 = var67 + var82 + ":" + 0 + ":" + var88;
							} else {
								var67 = var67 + var82 + ":" + var90 + ":"
										+ var88;
							}
						}
					}

					var79 = _workbase.getStepLinkDoList(var57);
					if (var79.size() > 0) {
						for (var76 = var79.iterator(); var76.hasNext(); var69 = var69
								+ var90) {
							var81 = (Map) var76.next();
							var90 = MapUtils.getIntValue(var81, "dotype", 0);
							if (var69.length() > 0) {
								var69 = var69 + ",";
							}
						}
					}

					if (StringUtils.isNotBlank(var67)
							|| StringUtils.isNotBlank(var69)) {
						path = MapUtils.getInteger(_parammap, "_posx" + var58,
								Integer.valueOf(0)).intValue();
						var82 = MapUtils.getInteger(_parammap, "_posy" + var58,
								Integer.valueOf(0)).intValue();
						var90 = MapUtils.getInteger(_parammap, "_posx" + var63,
								Integer.valueOf(0)).intValue();

						for (var86 = MapUtils.getInteger(_parammap,
								"_posy" + var63, Integer.valueOf(0)).intValue(); MapUtils
								.getInteger(var46, "posx" + path,
										Integer.valueOf(0)).intValue() == 1
								&& MapUtils.getInteger(var46, "posy" + var86,
										Integer.valueOf(0)).intValue() == 1; path += 60) {
							;
						}

						HashMap var91 = new HashMap();
						var91.put("type", "state");
						_tp = new HashMap();
						_tp.put("text", "条件");
						var91.put("text", _tp);
						_tp = new HashMap();
						_tp.put("height", Integer.valueOf(50));
						_tp.put("width", Integer.valueOf(50));
						_tp.put("y", Integer.valueOf(var86));
						_tp.put("x", Integer.valueOf(path));
						var46.put("posx" + path, Integer.valueOf(1));
						var46.put("posy" + var86, Integer.valueOf(1));
						var91.put("attr", _tp);
						HashMap var93 = new HashMap();
						_tp = new HashMap();
						_tp.put("value", var67);
						var93.put("stepcondition", _tp);
						_tp = new HashMap();
						_tp.put("value", var69);
						var93.put("steplinkdo", _tp);
						var91.put("props", var93);
						status.put("rect" + num, var91);
						var94 = "rect" + num;
						++num;
						HashMap var95 = new HashMap();
						var95.put("type", "path");
						var95.put("from", var65);
						var95.put("to", var94);
						var95.put("dots", new LinkedList());
						var65 = var94;
						HashMap var97 = new HashMap();
						_tp = new HashMap();
						_tp.put("value", String.valueOf(var60));
						var97.put("sort", _tp);
						var95.put("props", var97);
						var60 = 0;
						paths.put("path" + num, var95);
						++num;
					}

					HashMap var83 = new HashMap();
					var83.put("type", "path");
					var83.put("from", var65);
					var83.put("to", _torect);
					var83.put("dots", new LinkedList());
					HashMap var87 = new HashMap();
					_tp = new HashMap();
					_tp.put("value", String.valueOf(var60));
					var87.put("sort", _tp);
					var83.put("props", var87);
					paths.put("path" + num, var83);
				}
			}

			_myflow.put("states", status);
			_myflow.put("paths", paths);
			return _myflow;
		}
	}
}
