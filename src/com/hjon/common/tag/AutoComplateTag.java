package com.hjon.common.tag;

import com.hjon.common.utils.IncludeTag;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;

public class AutoComplateTag extends IncludeTag {
	private String id;
	private String name;
	private String hidden;
	private String width;
	private String defaultValue;
	private String readOnly;
	private String disabled;
	private String title;
	private String emptyText;
	private String selectOnFocus;
	private String clazz;
	private String jsParam;
	private String showOnFocus;
	private String multiple;
	private String onChangeCall;
	
	@Override
	public int doStartTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest) pageContext
				.getRequest();
		request.setAttribute("id", id);
		request.setAttribute("name", name);
		request.setAttribute("hidden", hidden);
		request.setAttribute("width", width);
		request.setAttribute("defaultValue", defaultValue);
		request.setAttribute("readOnly", readOnly);
		request.setAttribute("disabled", disabled);
		request.setAttribute("title", title);
		request.setAttribute("emptyText", emptyText);
		request.setAttribute("selectOnFocus",selectOnFocus );
		request.setAttribute("clazz", clazz);
		request.setAttribute("jsParam", jsParam);
		request.setAttribute("showOnFocus", showOnFocus);
		request.setAttribute("multiple", multiple);
		request.setAttribute("onChangeCall", onChangeCall);
		this.setUri("/WEB-INF/page/tag/autoComplate.jsp");
		return Tag.EVAL_BODY_INCLUDE;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getHidden() {
		return hidden;
	}

	public void setHidden(String hidden) {
		this.hidden = hidden;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	public String getReadOnly() {
		return readOnly;
	}

	public void setReadOnly(String readOnly) {
		this.readOnly = readOnly;
	}

	public String getDisabled() {
		return disabled;
	}

	public void setDisabled(String disabled) {
		this.disabled = disabled;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getEmptyText() {
		return emptyText;
	}

	public void setEmptyText(String emptyText) {
		this.emptyText = emptyText;
	}

	public String getSelectOnFocus() {
		return selectOnFocus;
	}

	public void setSelectOnFocus(String selectOnFocus) {
		this.selectOnFocus = selectOnFocus;
	}

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

	public String getJsParam() {
		return jsParam;
	}

	public void setJsParam(String jsParam) {
		this.jsParam = jsParam;
	}

	public String getShowOnFocus() {
		return showOnFocus;
	}

	public void setShowOnFocus(String showOnFocus) {
		this.showOnFocus = showOnFocus;
	}

	public String getMultiple() {
		return multiple;
	}

	public void setMultiple(String multiple) {
		this.multiple = multiple;
	}

	public String getOnChangeCall() {
		return onChangeCall;
	}

	public void setOnChangeCall(String onChangeCall) {
		this.onChangeCall = onChangeCall;
	}
}
