package hjon.company.modules.common.controller;

import hjon.company.common.bean.ActionResult;
import hjon.company.common.bean.AutoCompleteData;
import hjon.company.common.bean.Page;
import hjon.company.common.controller.BaseController;
import hjon.company.common.dao.CriterionCollection;
import hjon.company.config.CommonEnumUtils;
import hjon.company.modules.common.entity.CommonEnum;
import hjon.company.modules.common.service.CommonEnumService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
public class CommonEnumController extends BaseController {
	@Resource(name = "commonEnumService")
	private CommonEnumService commonEnumService;

	@RequestMapping("common/enum/list")
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
		String type = this.getParameter("type");
		if (type != null && !type.equals("")) {
			search.Add(Expression.like("type", "%" + type + "%"));
			this.setAttribute("type", type);
		}
		Page data = commonEnumService.pagedQuery(pageNum, numPerPage, search,
				order);
		this.setAttribute("Module", data);
		return "common/enumlist";
	}

	@RequestMapping("common/enum/edit")
	public void edit() {
		String id = this.getParameter("id");
		if (id != null && !"".equals(id)) {
			// UserInfo userInfo = userInfoService.get(id);
			CommonEnum commonEnum = commonEnumService.get(id);
			Gson gson = new Gson();
			this.outputText(gson.toJson(commonEnum));
		}

	}

	@RequestMapping("common/enum/save")
	public void save() {
		CommonEnum commonEnum = new CommonEnum();
		String id = request.getParameter("id");
		if (id != null && !"".equals(id)) {
			commonEnum = commonEnumService.get(id);
			this.setEntityValueFromPage(commonEnum);
			commonEnumService.saveOrUpdate(commonEnum);
			List<CommonEnum> tempCommonEnums = CommonEnumUtils.getCommonEnums(
					commonEnum.getModule(), commonEnum.getType());
			if (tempCommonEnums == null) {
				tempCommonEnums = new ArrayList<CommonEnum>();
			}
		} else {
			String module = request.getParameter("module");
			String type = request.getParameter("type");
			String value = request.getParameter("value");
			CommonEnum commonEnumTest = commonEnumService.getCommonEnum(module,
					type, value);
			if (commonEnumTest != null) {
				// ActionResult result = new ActionResult(300,"模块和名称已存在");
				this.outputText("已存在");
			} else {
				this.setEntityValueFromPage(commonEnum);
				commonEnum.setId(UUID.randomUUID().toString());
				commonEnumService.saveOrUpdate(commonEnum);
			}
		}
		refreshCommonEnum();
		this.outputText("200");
	}

	@RequestMapping(value = "common/enum/delete", method = RequestMethod.POST)
	public void delete() {
		try {
			String ids = this.getParameter("ids");
			if (ids == null || ids.equals("")) {
				throw new Exception("参数错误:请选择要删除的项!");
			} else {
				commonEnumService.batchDelete(ids.split(","));
			}
			refreshCommonEnum();
			this.outputText(new ActionResult("EnumList", "").toString());
		} catch (Exception ex) {
			this.outputText(new ActionResult(300, ex.getMessage()).toString());
		}

	}

	@RequestMapping(value = "common/enum/autoComplate")
	public void autoComplate() {
		String p = request.getParameter("p");
		String module = request.getParameter("module");
		String type = request.getParameter("type");
		List<CommonEnum> commonEnums = commonEnumService.findCommonEnums(
				module, type, p);
		List<AutoCompleteData> result = new ArrayList<AutoCompleteData>();
		if (commonEnums != null) {
			for (CommonEnum commonEnum : commonEnums) {
				AutoCompleteData data = new AutoCompleteData();
				data.setId(commonEnum.getValue());
				data.setText(commonEnum.getName());
				result.add(data);
			}
		}
		String rs = new Gson().toJson(result);
		this.outputText(rs);
	}

	@RequestMapping(value = "common/enum/select")
	public void select() {
		String module = request.getParameter("module");
		String type = request.getParameter("type");
		List<CommonEnum> commonEnums = commonEnumService.findCommonEnums(
				module, type);
		List<AutoCompleteData> result = new ArrayList<AutoCompleteData>();
		if (commonEnums != null) {
			for (CommonEnum commonEnum : commonEnums) {
				AutoCompleteData data = new AutoCompleteData();
				data.setId(commonEnum.getValue());
				data.setText(commonEnum.getName());
				result.add(data);
			}
		}
		String rs = new Gson().toJson(result);
		this.outputText(rs);
	}
}