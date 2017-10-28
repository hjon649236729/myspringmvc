package com.hjon.common.quartz;

public enum QuartzEnum {
	// JobExecuteLog Status字段
	STATUS_NORMAL(0),

	STATUS_PAUSED(1),

	STATUS_COMPLETE(2),

	STATUS_ERROR(3),

	STATUS_BLOCKED(4),

	STATUS_NONE(-1),
	//JobExecuteLog Type字段
	TYPE_AUTO(1),
	
	TYPE_HAND(2);
	// 定义私有变量
	private int value;

	private QuartzEnum(int val) {
		this.value = val;
	}

	public final int toInt() {
		return value;
	}
	
}
