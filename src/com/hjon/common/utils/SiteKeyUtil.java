package com.hjon.common.utils;

import javax.servlet.http.HttpServletRequest;

public class SiteKeyUtil {
	public static String getSiteTag(HttpServletRequest request)
	{
		String url = request.getRequestURL().toString().replace("http://","");
		String siteKey = url.substring(0, url.indexOf("/"));
		return siteKey;
	}
}
