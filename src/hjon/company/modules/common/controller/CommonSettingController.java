package hjon.company.modules.common.controller;

import hjon.company.common.bean.ActionResult;
import hjon.company.common.bean.Page;
import hjon.company.common.controller.BaseController;
import hjon.company.common.dao.CriterionCollection;
import hjon.company.config.CommonEnumUtils;
import hjon.company.config.CommonSettingUtils;
import hjon.company.modules.common.entity.CommonSetting;
import hjon.company.modules.common.service.CommonSettingService;

import java.util.HashMap;
import java.util.Map;
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
public class CommonSettingController extends BaseController {
	@Resource(name = "commonSettingService")
	private CommonSettingService commonSettingService;

	@RequestMapping("common/setting/list")
	public String list() {
		String orgId = this.getParameter("orgId");
		this.setAttribute("orgId", orgId);
		int pageNum = this.getParameter("pageNum") == null ? 1 : Integer
				.parseInt(this.getParameter("pageNum"));
		int numPerPage = this.getParameter("numPerPage") == null ? 10 : Integer
				.parseInt(this.getParameter("numPerPage"));
		String orderField = this.getParameter("orderField");
		String orderDirection = this.getParameter("orderDirection");
		Order order = Order.desc("createTime");
		CriterionCollection search = new CriterionCollection();
		if (orderField != null && !orderField.equals("")) {
			if (orderDirection.toLowerCase().equals("asc")) {
				order = Order.asc(orderField);
				this.setAttribute("orderDirection", "asc");
			} else {
				order = Order.desc(orderField);
				this.setAttribute("orderDirection", "desc");
			}
			this.setAttribute("orderField", orderField);
		}
		String module = this.getParameter("module");
		if (module != null && !module.equals("")) {
			search.Add(Expression.like("module", "%" + module + "%"));
			this.setAttribute("module", module);
		}
		String name = this.getParameter("name");
		if (name != null && !name.equals("")) {
			search.Add(Expression.like("name", "%" + name + "%"));
			this.setAttribute("name", name);
		}
		Page data = commonSettingService.pagedQuery(pageNum, numPerPage,
				search, order);
		this.setAttribute("Module", data);
		return "common/settinglist";
	}

	@RequestMapping("common/setting/edit")
	public void edit() {
		String id = this.getParameter("id");
		if (id != null && !"".equals(id)) {
			// UserInfo userInfo = userInfoService.get(id);
			CommonSetting setting = commonSettingService.get(id);
			Gson gson = new Gson();
			this.outputText(gson.toJson(setting));
		}

	}

	@RequestMapping("common/setting/save")
	public void save() {
		CommonSetting setting = new CommonSetting();
		String id = request.getParameter("id");
		if (id != null && !"".equals(id)) {
			setting = commonSettingService.get(id);
			this.setEntityValueFromPage(setting);
			commonSettingService.saveOrUpdate(setting);
		} else {
			String module = request.getParameter("module");
			String name = request.getParameter("name");
			CommonSetting settingTest = commonSettingService
					.getSettingByModuleAndName(module, name);
			if (settingTest != null) {
				// ActionResult result = new ActionResult(300,"模块和名称已存在");
				this.outputText("模块和名称已存在");
			} else {
				this.setEntityValueFromPage(setting);
				setting.setId(UUID.randomUUID().toString());
				commonSettingService.saveOrUpdate(setting);

			}
		}
		// 保存之后，更新缓存中的settingUtils里的值
		refreshCommonEnum();
		this.outputText("200");
	}

	@RequestMapping(value = "common/setting/delete", method = RequestMethod.POST)
	public void delete() {
		try {
			String ids = this.getParameter("ids");
			if (ids == null || ids.equals("")) {
				throw new Exception("参数错误:请选择要删除的项!");
			} else {
				commonSettingService.batchDelete(ids.split(","));
			}
			refreshCommonEnum();
			this.outputText(new ActionResult("SettingList", "").toString());
		} catch (Exception ex) {
			this.outputText(new ActionResult(300, ex.getMessage()).toString());
		}
	}
}