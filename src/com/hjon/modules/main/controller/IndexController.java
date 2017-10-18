package com.hjon.modules.main.controller;

import com.hjon.common.controller.BaseController;
import com.hjon.common.utils.SystemUtils;
import com.hjon.config.CommonBannerUtils;
import com.hjon.modules.homepage.service.InformService;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Scope("prototype")
public class IndexController extends BaseController {

	@Resource(name = "informService")
	private InformService informService;

	@RequestMapping("index")
	public String index() {
		return "main/index";
	}

	@RequestMapping("left")
	public String left() {
		return "main/left";
	}

	@RequestMapping("right")
	public String right() {
		return "main/right";
	}

	@RequestMapping("product")
	public String product() {
		return "product";
	}

	@RequestMapping("about")
	public String about() {
		return "about";
	}

	@RequestMapping("test")
	public String test() {

		return "test";
	}

	@RequestMapping("back")
	public String back() {
		return "back";
	}
	@RequestMapping("informview")
	public String informview() {
		return "informview";
	}
	@RequestMapping("refreshCache")
	public void refreshCache() {
		super.refreshCache();
	}

	@RequestMapping("back/informlist")
	public String informlist() {
		return "back/informlist";
	}
}
