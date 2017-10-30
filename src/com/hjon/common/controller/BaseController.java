package com.hjon.common.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.hjon.common.listener.contextListener;
import com.hjon.common.utils.SiteKeyUtil;
import com.hjon.common.utils.StringUtils;
import com.hjon.config.BannerUtils;
import com.hjon.config.Constant;
import com.hjon.config.SettingUtils;
import com.hjon.config.SysEnumUtils;
import com.hjon.modules.auth.entity.UserInfo;
import com.hjon.modules.common.entity.Attachment;
import com.hjon.modules.common.entity.Setting;
import com.hjon.modules.common.entity.SysEnum;
import com.hjon.modules.common.service.AttachmentService;
import com.hjon.modules.common.service.BannerService;
import com.hjon.modules.common.service.SettingService;
import com.hjon.modules.common.service.SysEnumService;

@Controller
public class BaseController {
	@Autowired
	protected HttpServletRequest request;

	@Resource(name = "attachmentService")
	protected AttachmentService attachmentService;
	@Resource(name = "settingService")
	protected SettingService settingService;
	@Resource(name = "sysEnumService")
	protected SysEnumService sysEnumService;
	@Resource(name = "bannerService")
	protected BannerService bannerService;

	public HttpServletRequest getRequest() {
		return this.request;
	}

	@Autowired
	protected HttpServletResponse response;

	public HttpServletResponse getResponse() {
		return this.response;
	}

	public UserInfo getUser() {
		return (UserInfo) this.getSession("login_user");
	}

	/**
	 * 全局变量加入缓存设置
	 */
	public void refreshSetting() {
		SettingUtils.Setting = new HashMap<Map<String, String>, Setting>();

		List<Setting> settings = settingService.getAll(Order.asc("module"));
		for (Setting setting : settings) {
			Map<String, String> map = new HashMap<String, String>();
			map.put(setting.getModule(), setting.getName());
			SettingUtils.Setting.put(map, setting);
		}
	}

	/**
	 * 枚举值加入缓存
	 */
	public void refreshSysEnum() {
		SysEnumUtils.SysEnum = new HashMap<Map<String, String>, List<SysEnum>>();

		List<SysEnum> SysEnums = sysEnumService.getAll(Order.asc("module"));
		for (SysEnum SysEnum : SysEnums) {
			Map<String, String> param = new HashMap<String, String>();
			param.put(SysEnum.getModule(), SysEnum.getType());
			List<SysEnum> SysEnumTemps = SysEnumUtils.SysEnum.get(param);
			if (SysEnumTemps != null) {
				SysEnumTemps.add(SysEnum);
				SysEnumUtils.SysEnum.put(param, SysEnumTemps);
			} else {
				SysEnumTemps = new ArrayList<SysEnum>();
				SysEnumTemps.add(SysEnum);
				SysEnumUtils.SysEnum.put(param, SysEnumTemps);
			}
		}

	}

	/**
	 * Banner加入缓存
	 */
	public void refreshBanner() {

		BannerUtils.banner = bannerService.findBanner();
	}

	/**
	 * file.properties加入缓存
	 */
	public void refreshConstant() {
		try {
			Properties prop = new Properties();
			InputStream in = contextListener.class
					.getResourceAsStream("/file.properties");
			prop.load(in);
			// Constant.SitePath = context.getRealPath("/");
			Constant.UploadFileRootPath = prop.getProperty("ResourcePath")
					.trim();
			Constant.LogPath = prop.getProperty("LogPath").trim();
			Constant.FileType = prop.getProperty("FileType").trim();

		} catch (Exception e) {
			// LogHelper.Error(e);
			throw new RuntimeException(e.getMessage());
		}
	}

	public void refreshCache() {
		refreshBanner();
		refreshSysEnum();
		refreshSetting();
		refreshConstant();
	}

	public void setEntityValueFromPage(Object entity) {
		HashMap<String, Object> fieldsMap = new HashMap<String, Object>();
		Field[] fields = entity.getClass().getDeclaredFields();
		Map<String, Method> methodMap = new HashMap<String, Method>();
		Method[] methods = entity.getClass().getDeclaredMethods();
		for (Method method : methods) {
			methodMap.put(method.getName().toLowerCase(), method);
		}
		for (Field column : fields) {
			String cValue = request.getParameter(column.getName());
			if (cValue != null) {
				cValue = cValue.trim();
				Method method = methodMap.get("set"
						+ column.getName().toLowerCase());
				if (method != null) {
					try {
						if (method.getParameterTypes()[0].equals(String.class)) {
							// char,varchar,longtext
							method.invoke(entity, cValue);
							continue;
						}
						if (method.getParameterTypes()[0].equals(Integer.class)
								|| method.getParameterTypes()[0]
										.equals(int.class)) {
							// int
							method.invoke(entity, Integer.parseInt(cValue));
							continue;
						}
						if (method.getParameterTypes()[0].equals(Long.class)
								|| method.getParameterTypes()[0]
										.equals(long.class)) {
							// long
							method.invoke(entity, Long.parseLong(cValue));
							continue;
						}
						if (method.getParameterTypes()[0]
								.equals(Timestamp.class)) {
							// datetime
							method.invoke(entity, Timestamp.parse(cValue));
							continue;
						}
						if (method.getParameterTypes()[0].equals(Date.class)) {
							method.invoke(entity, Date.valueOf(cValue));
						}
					} catch (Exception ex) {

					}
				}
			}
		}
	}

	public void deleteAttachment(String sourceEntity, String id) {
		List<Attachment> attachmentList = attachmentService.findAttachmentList(
				sourceEntity, id);
		attachmentService.batchDelete(attachmentList);
		// this.delete(id);
	}

	public void batchDeleteAttachment(String sourceEntity, String[] ids) {
		for (String id : ids) {
			if (!id.equals("")) {
				List<Attachment> attachmentList = attachmentService
						.findAttachmentList(sourceEntity, id);
				attachmentService.batchDelete(attachmentList);
				// this.delete(id);
			}
		}

	}

	public void saveAttachment(String sourceEntity, String sourceId) {
		// 如果有新添加的附件，则保存附件
		String fileNames = request.getParameter("fileName");
		String fileTypes = request.getParameter("fileType");
		String fileSizes = request.getParameter("fileSize");
		String savePaths = request.getParameter("savePath");
		if (!StringUtils.isBlank(fileNames) && !StringUtils.isBlank(fileTypes)
				&& !StringUtils.isBlank(fileSizes)
				&& !StringUtils.isBlank(savePaths)) {
			String[] fileName = fileNames.split(":");
			String[] fileType = fileTypes.split(":");
			String[] fileSize = fileSizes.split(":");
			String[] savePath = savePaths.split(":");
			for (int i = 0; i < fileName.length; i++) {
				if (!"".equals(fileName[i]) && !"".equals(fileType[i])
						&& !"".equals(fileSize[i]) && !"".equals(savePath[i])) {
					Attachment attachment = new Attachment();
					attachment.setId(UUID.randomUUID().toString());
					attachment.setName(fileName[i]);
					attachment.setFileType(fileType[i]);
					attachment.setFileSize(Double.valueOf(fileSize[i]));
					attachment.setStorePath(savePath[i]);
					attachment.setSourceEntity(sourceEntity);
					attachment.setSourceId(sourceId);
					attachment.setCreateTime(new java.util.Date());
					attachment.setType(1);
					attachmentService.saveOrUpdate(attachment);
				}
			}
		}
		// 如果对以前保存过的附件有删除操作，则删除附件
		String deleteAttachmentIds = request.getParameter("deleteAttachmentId");
		if (deleteAttachmentIds != null) {
			String[] deleteAttachmentId = deleteAttachmentIds.split(":");
			for (int i = 0; i < deleteAttachmentId.length; i++) {
				attachmentService.delete(deleteAttachmentId[i]);
			}
		}
	}

	public void saveAttachment(String sourceEntity, String sourceId,
			Integer type) {
		// 如果有新添加的附件，则保存附件
		String fileNames = request.getParameter("fileName");
		String fileTypes = request.getParameter("fileType");
		String fileSizes = request.getParameter("fileSize");
		String savePaths = request.getParameter("savePath");
		if (!StringUtils.isBlank(fileNames) && !StringUtils.isBlank(fileTypes)
				&& !StringUtils.isBlank(fileSizes)
				&& !StringUtils.isBlank(savePaths)) {
			String[] fileName = fileNames.split(":");
			String[] fileType = fileTypes.split(":");
			String[] fileSize = fileSizes.split(":");
			String[] savePath = savePaths.split(":");
			for (int i = 0; i < fileName.length; i++) {
				if (!"".equals(fileName[i]) && !"".equals(fileType[i])
						&& !"".equals(fileSize[i]) && !"".equals(savePath[i])) {
					Attachment attachment = new Attachment();
					attachment.setId(UUID.randomUUID().toString());
					attachment.setName(fileName[i]);
					attachment.setFileType(fileType[i]);
					attachment.setFileSize(Double.valueOf(fileSize[i]));
					attachment.setStorePath(savePath[i]);
					attachment.setSourceEntity(sourceEntity);
					attachment.setSourceId(sourceId);
					attachment.setCreateTime(new java.util.Date());
					attachment.setType(type);
					attachmentService.saveOrUpdate(attachment);
				}
			}

		}
		// 如果对以前保存过的附件有删除操作，则删除附件
		String deleteAttachmentIds = request.getParameter("deleteAttachmentId");
		if (deleteAttachmentIds != null) {
			String[] deleteAttachmentId = deleteAttachmentIds.split(":");
			for (int i = 0; i < deleteAttachmentId.length; i++) {
				attachmentService.delete(deleteAttachmentId[i]);
			}
		}
	}

	public void outputText(String text) {
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		try {
			PrintWriter out = response.getWriter();
			out.print(text);
			out.flush();
			out.close();
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}
	}

	public void outputFile(String fileName, String content) {
		response.setContentType("text/plain;charset=utf-8");
		response.setHeader("Content-disposition", "attachment;filename="
				+ fileName);
		try {
			response.getWriter().print(content);
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}

	}

	public void outputImage(String imgPath) throws IOException {
		String fileName = imgPath.substring(imgPath.lastIndexOf("/") + 1);
		HttpServletResponse response = (HttpServletResponse) request
				.getAttribute("response");
		ServletOutputStream out = response.getOutputStream();
		response.setContentType("image/jpg");
		response.setHeader("Content-disposition", "inline;filename=" + fileName);
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			bis = new BufferedInputStream(new FileInputStream(imgPath));
			bos = new BufferedOutputStream(out);
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (IOException e) {
			throw e;
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
	}

	public void setAttribute(String key, Object value) {
		request.setAttribute(key, value);
	}

	public String getAttribute(String key) {
		return request.getAttribute(key) == null ? null : request.getAttribute(
				key).toString();
	}

	public InputStream getInputStream() throws IOException {
		return request.getInputStream();
	}

	public String getParameter(String key) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return request.getParameter(key) == null ? null : request.getParameter(
				key).toString();
	}

	public void setSession(String key, Object value) {
		String siteTag = SiteKeyUtil.getSiteTag(request);
		request.getSession().setAttribute(siteTag + key, value);
	}

	public Object getSession(String key) {
		String siteTag = SiteKeyUtil.getSiteTag(request);
		return request.getSession().getAttribute(siteTag + key);
	}

	public void removeSession(String key) {
		String siteTag = SiteKeyUtil.getSiteTag(request);
		request.getSession().removeAttribute(siteTag + key);
	}

	/**
	 * 添加cookie
	 * 
	 * @param response
	 * @param name
	 *            cookie的名称
	 * @param value
	 *            cookie的值
	 * @param maxAge
	 *            cookie存放的时间(以秒为单位,假如存放三天,即3*24*60*60; 如果值为0,cookie将随浏览器关闭而清除)
	 */
	public void addCookie(String name, String value, int maxAge) {
		HttpServletResponse response = (HttpServletResponse) request
				.getAttribute("response");
		Cookie cookie = new Cookie(name, value);
		cookie.setPath("/");
		if (maxAge > 0)
			cookie.setMaxAge(maxAge);
		response.addCookie(cookie);
	}

	/**
	 * 获取cookie的值
	 * 
	 * @param request
	 * @param name
	 *            cookie的名称
	 * @return
	 */
	public String getCookieByName(String name) {
		Map<String, Cookie> cookieMap = getAllCookie(request);
		if (cookieMap.containsKey(name)) {
			Cookie cookie = cookieMap.get(name);
			return cookie.getValue();
		} else {
			return null;
		}
	}

	public Map<String, Cookie> getAllCookie(HttpServletRequest request) {
		Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
		Cookie[] cookies = request.getCookies();
		if (null != cookies) {
			for (int i = 0; i < cookies.length; i++) {
				cookieMap.put(cookies[i].getName(), cookies[i]);
			}
		}
		return cookieMap;
	}

	public String getSiteKey() {
		String siteTag = SiteKeyUtil.getSiteTag(request);
		return siteTag;
	}

	public String decodeUrl(String paramter) {
		try {
			return URLDecoder.decode(paramter, "UTF-8");
		} catch (UnsupportedEncodingException e) {
		}
		throw new RuntimeException();
	}

	// 检索%时，对%进行转义
	public String checkTemp(String temp) {
		String[] strArr = new String[temp.length()];
		String str = "";
		for (int i = 0; i < strArr.length; i++) {
			strArr[i] = temp.substring(i, i + 1);
			if (strArr[i].equals("%")) {
				str += "\\" + strArr[i];
				continue;
			}
			str += strArr[i];
		}
		return str;
	}
}
