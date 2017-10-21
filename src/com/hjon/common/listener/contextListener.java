package com.hjon.common.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.context.ServletContextAware;

import com.hjon.config.CommonSettingUtils;
import com.hjon.modules.common.entity.CommonSetting;
import com.hjon.modules.common.service.CommonBannerService;
import com.hjon.modules.common.service.CommonEnumService;
import com.hjon.modules.common.service.CommonSettingService;

public class contextListener implements InitializingBean, ServletContextAware {
	@Resource(name = "commonSettingService")
	private CommonSettingService commonSettingService;
	@Resource(name = "commonEnumService")
	private CommonEnumService commonEnumService;
	@Resource(name = "commonBannerService")
	private CommonBannerService commonBannerService;

	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void setServletContext(ServletContext context) {
		// TODO Auto-generated method stub

		try {
			/*
			 * Properties prop = new Properties(); InputStream in =
			 * contextListener.class .getResourceAsStream("/file.properties");
			 * prop.load(in); Constant.SitePath = context.getRealPath("/");
			 * Constant.UploadFileRootPath = prop.getProperty("ResourcePath")
			 * .trim(); Constant.LogPath = prop.getProperty("LogPath").trim();
			 * Constant.FileType = prop.getProperty("FileType").trim();
			 */
			// 全局变量加入缓存设置
			List<CommonSetting> settings = commonSettingService.getAll(Order
					.asc("module"));
			for (CommonSetting setting : settings) {
				Map<String, String> map = new HashMap<String, String>();
				map.put(setting.getModule(), setting.getName());
				CommonSettingUtils.commonSetting.put(map, setting);
			}
			// 枚举值加入缓存
			/*
			 * List<CommonEnum> commonEnums = commonEnumService.getAll(Order
			 * .asc("module")); for (CommonEnum commonEnum : commonEnums) {
			 * Map<String, String> param = new HashMap<String, String>();
			 * param.put(commonEnum.getModule(), commonEnum.getType());
			 * List<CommonEnum> commonEnumTemps = CommonEnumUtils.commonEnum
			 * .get(param); if (commonEnumTemps != null) {
			 * commonEnumTemps.add(commonEnum);
			 * CommonEnumUtils.commonEnum.put(param, commonEnumTemps); } else {
			 * commonEnumTemps = new ArrayList<CommonEnum>();
			 * commonEnumTemps.add(commonEnum);
			 * CommonEnumUtils.commonEnum.put(param, commonEnumTemps); } } //
			 * Banner加入缓存 CommonBannerUtils.commonBanner =
			 * commonBannerService.findCommonBanner();
			 */
		} catch (Exception e) {

			throw new RuntimeException(e.getMessage());
		}

	}
}
