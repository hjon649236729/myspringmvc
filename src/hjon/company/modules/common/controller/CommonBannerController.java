package hjon.company.modules.common.controller;

import hjon.company.common.bean.ActionResult;
import hjon.company.common.bean.Page;
import hjon.company.common.controller.BaseController;
import hjon.company.common.dao.CriterionCollection;
import hjon.company.modules.common.entity.CommonBanner;
import hjon.company.modules.common.service.CommonBannerService;

import java.util.UUID;

import javax.annotation.Resource;

import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;

@Controller
@Scope("prototype")
public class CommonBannerController extends BaseController {

	@Resource(name = "commonBannerService")
	private CommonBannerService commonBannerService;

	@RequestMapping("common/banner/list")
	public String list() {
		String orgId = this.getParameter("orgId");
		this.setAttribute("orgId", orgId);
		int pagBanner = this.getParameter("pagBanner") == null ? 1 : Integer
				.parseInt(this.getParameter("pagBanner"));
		int numPerPage = this.getParameter("numPerPage") == null ? 10 : Integer
				.parseInt(this.getParameter("numPerPage"));
		String orderField = this.getParameter("orderField");
		String orderDirection = this.getParameter("orderDirection");
		Order order = Order.desc("sort");
		CriterionCollection search = new CriterionCollection();
		if (orderField != null && !orderField.equals("")) {
			if (orderDirection.toLowerCase().equals("asc")) {
				order = Order.asc(orderField);
				this.setAttribute("orderDirection", "asc");
			} else {
				order = Order.desc(orderField);
				// this.setAttribute("orderDirection", "desc");
			}
			this.setAttribute("orderField", orderField);
		}
		// search.Add(Expression.eq("module", "COMMON"));
		// search.Add(Expression.eq("type", "BANNER"));
		Page data = commonBannerService.pagedQuery(pagBanner, numPerPage,
				search, order);

		this.setAttribute("Module", data);
		return "common/bannerlist";
	}

	@RequestMapping("common/banner/edit")
	public void edit() {
		String id = this.getParameter("id");
		if (id != null && !"".equals(id)) {
			// UserInfo userInfo = userInfoService.get(id);
			CommonBanner commonBanner = commonBannerService.get(id);
			Gson gson = new Gson();
			this.outputText(gson.toJson(commonBanner));
		}

	}

	@RequestMapping("common/banner/check")
	public void check() {

	}

	@RequestMapping("common/banner/save")
	public void save() {
		CommonBanner commonBanner = new CommonBanner();
		String id = request.getParameter("id");
		if (id != null && !"".equals(id)) {
			commonBanner = commonBannerService.get(id);
			this.setEntityValueFromPage(commonBanner);
			commonBannerService.saveOrUpdate(commonBanner);
		} else {
			this.setEntityValueFromPage(commonBanner);
			commonBanner.setId(UUID.randomUUID().toString());
			commonBannerService.saveOrUpdate(commonBanner);
		}
		this.saveAttachment("COMMONBANNER", commonBanner.getId());
		this.outputText("200");
		refreshCommonBanner();
	}

	@RequestMapping(value = "common/banner/delete", method = RequestMethod.POST)
	public void delete() {
		try {
			String ids = this.getParameter("ids");
			if (ids == null || ids.equals("")) {
				throw new Exception("参数错误:请选择要删除的项!");
			} else {
				this.batchDeleteAttachment("COMMONBANNER", ids.split(","));
				commonBannerService.batchDelete(ids.split(","));
			}
			refreshCommonBanner();
			this.outputText(new ActionResult("BannerList", "").toString());
		} catch (Exception ex) {
			this.outputText(new ActionResult(300, ex.getMessage()).toString());
		}
	}
}
