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
	WF_TYPE_START(1, "开始节点"), WF_TYPT_END(2, "结束节点"), WF_TYPE_DEAL(3, "处理节点"), WF_TYPE_LOGIC(
			4, "逻辑节点"), WF_TYPE_BRANCH(5, "分支节点"), WF_TYPE_MERGER(6, "合并节点"), WF_TYPE_SUBMIT(
			7, "提交节点");
	private String name;
	private Integer value;

	private WorkflowStepType() {
	}

	private WorkflowStepType(Integer value, String name) {
		this.value = value;
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}

	public static String getName(int index) {
		for (WorkflowStepType c : WorkflowStepType.values()) {
			if (c.getValue() == index) {
				return c.name;
			}
		}
		return null;
	}
}
