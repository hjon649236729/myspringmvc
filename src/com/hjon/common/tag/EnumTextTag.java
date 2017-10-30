package com.hjon.common.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.hjon.config.SysEnumUtils;

public class EnumTextTag extends SimpleTagSupport {

	private String module;
	private String type;
	private String value;

	public void doTag() throws JspException, IOException {
		JspWriter out = getJspContext().getOut();
		String name = SysEnumUtils.getSysEnumName(module, type, value);
		if (name != null) {
			out.println(name);
		} else {
			out.println("无此枚举项：" + value);
		}

	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
