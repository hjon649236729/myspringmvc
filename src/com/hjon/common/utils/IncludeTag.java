package com.hjon.common.utils;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.jsp.JspException;

public class IncludeTag extends AbstractIncludeTag {
    private StringBuffer uri = new StringBuffer();

    public IncludeTag() {
    }

    public void setUri(String uri) {
        this.uri.append(uri.startsWith("/")?"":"/");
        this.uri.append(uri);
    }

    public void addParameter(String name, String value) {
        if(!StringUtils.isBlank(name) && !StringUtils.isBlank(value)) {
            if(this.uri.indexOf("?") == -1) {
                this.uri.append("?");
            } else {
                this.uri.append("&");
            }

            this.uri.append(name);
            this.uri.append("=");
            this.uri.append(value);
        }
    }

    public void clearParameters() {
        this.uri.setLength(0);
    }

    public int doEndTag() throws JspException {
        try {
            this.pageContext.include(this.uri.toString());
            this.uri = new StringBuffer();
        } catch (ServletException var2) {
            var2.printStackTrace();
        } catch (IOException var3) {
            var3.printStackTrace();
        }

        return 6;
    }
}
