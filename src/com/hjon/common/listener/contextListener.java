package com.hjon.common.listener;

import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.context.ServletContextAware;

import com.hjon.common.quartz.LocalQuartzManager;

public class contextListener implements InitializingBean, ServletContextAware {
	Logger logger = Logger.getLogger(contextListener.class);

	// @Resource(name = "commonSettingService")
	// private CommonSettingService commonSettingService;

	// @Resource(name = "commonEnumService")
	// private CommonEnumService commonEnumService;
	// @Resource(name = "commonBannerService")
	// private CommonBannerService commonBannerService;

	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void setServletContext(ServletContext context) {
		// TODO Auto-generated method stub
		// logger.info("contextListener.jaba----setServiceletContext");
		try {
			LocalQuartzManager.start();
			// System.out.println(userInfoService.get(1);
			// JobExecuteLog job = jobExecuteLogService.get(1);
			// if (job != null) {
			// System.out.println(job.getName());
			// }
			// try {
			// LocalQuartzManager.start();// 启动定时任务
			// } catch (SchedulerException e) {
			// // TODO Auto-generated catch block
			// logger.error("定时任务启动失败");
			// e.printStackTrace();
			// }
			/*
			 * Properties prop = new Properties(); InputStream in =
			 * contextListener.class .getResourceAsStream("/file.properties");
			 * prop.load(in); Constant.SitePath = context.getRealPath("/");
			 * Constant.UploadFileRootPath = prop.getProperty("ResourcePath")
			 * .trim(); Constant.LogPath = prop.getProperty("LogPath").trim();
			 * Constant.FileType = prop.getProperty("FileType").trim();
			 */
			// 全局变量加入缓存设置
			// List<CommonSetting> settings = commonSettingService.getAll(Order
			// .asc("module"));
			// for (CommonSetting setting : settings) {
			// Map<String, String> map = new HashMap<String, String>();
			// map.put(setting.getModule(), setting.getName());
			// CommonSettingUtils.commonSetting.put(map, setting);
			// }
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
