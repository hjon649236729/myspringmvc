package hjon.company.common.utils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

public abstract class AbstractIncludeTag extends BodyTagSupport {
    public AbstractIncludeTag() {
    }

    public abstract void addParameter(String var1, String var2);

    public abstract void clearParameters();

    public int doStartTag() throws JspException {
        this.clearParameters();
        return 6;
    }
}
