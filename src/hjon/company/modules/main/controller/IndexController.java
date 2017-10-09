package hjon.company.modules.main.controller;

import hjon.company.common.controller.BaseController;
import hjon.company.common.utils.SystemUtils;
import hjon.company.config.CommonBannerUtils;
import hjon.company.modules.homepage.service.InformService;

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

	@RequestMapping("company")
	public String company() {
		return "company";
	}

	@RequestMapping("customer")
	public String customer() {
		return "customer";
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
