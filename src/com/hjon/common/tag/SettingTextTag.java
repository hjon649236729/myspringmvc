package com.hjon.common.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.hjon.config.SettingUtils;
import com.hjon.modules.common.entity.Setting;

public class SettingTextTag extends SimpleTagSupport {
	private String module;
	private String name;

	public void doTag() throws JspException, IOException {
		JspWriter out = getJspContext().getOut();
		Setting setting = SettingUtils.getSetting(module,name);
		if (setting != null) {
			out.println(setting.getValue());
		} else {
			out.println("");
		}
	}

	public void setModule(String module) {
		this.module = module;
	}

	public void setName(String name) {
		this.name = name;
	}

}
