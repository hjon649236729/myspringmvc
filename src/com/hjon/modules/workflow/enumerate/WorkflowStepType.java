package com.hjon.modules.workflow.enumerate;

public enum WorkflowStepType {
	// public static final WorkflowStepType WF_TYPE_START = new
	// WorkflowStepType("1", 1, "开始节点", (String)null);
	// public static final WorkflowStepType WF_TYPE_END = new
	// WorkflowStepType("2", 2, "结束节点", (String)null);
	// public static final WorkflowStepType WF_TYPE_DEAL = new
	// WorkflowStepType("3", 3, "处理节点", (String)null);
	// public static final WorkflowStepType WF_TYPE_LOGIC = new
	// WorkflowStepType("4", 4, "逻辑节点", (String)null);
	// public static final WorkflowStepType WF_TYPE_BRANCH = new
	// WorkflowStepType("5", 5, "分支节点", (String)null);
	// public static final WorkflowStepType WF_TYPE_MERGER = new
	// WorkflowStepType("6", 6, "合并节点", (String)null);
	// public static final WorkflowStepType WF_TYPE_SUBMIT = new
	// WorkflowStepType("7", 7, "提交节点", (String)null);
	// public static final WorkflowStepType WF_TYPE_REPORT = new
	// WorkflowStepType("12", 2, "结束节点2", (String)null);
	WF_TYPE_START(1, "开始节点");
	
	
	private WorkflowStepType(Integer value, String Name) {
	}

}
