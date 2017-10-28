package com.hjon.common.tag;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class FormatDateTag extends SimpleTagSupport {

	private String value;
	private String format;

	public void doTag() throws JspException, IOException {
		JspWriter out = getJspContext().getOut();
		long time = Long.valueOf(value);
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(time);
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String s = sdf.format(c.getTime());
		out.write(s);
	}
	
	public void setValue(String value) {
		this.value = value;
	}

	public void setFormat(String format) {
		this.format = format;
	}

}
