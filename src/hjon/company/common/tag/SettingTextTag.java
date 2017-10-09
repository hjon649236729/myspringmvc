package hjon.company.common.tag;

import hjon.company.config.CommonSettingUtils;
import hjon.company.modules.common.entity.CommonSetting;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class SettingTextTag extends SimpleTagSupport {
	private String module;
	private String name;

	public void doTag() throws JspException, IOException {
		JspWriter out = getJspContext().getOut();
		CommonSetting setting = CommonSettingUtils.getCommonSetting(module,name);
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
