package hjon.company.modules.homepage.controller;

import hjon.company.common.bean.ActionResult;
import hjon.company.common.bean.Page;
import hjon.company.common.controller.BaseController;
import hjon.company.common.dao.CriterionCollection;
import hjon.company.common.utils.StringUtils;
import hjon.company.modules.common.entity.CommonAttachment;
import hjon.company.modules.common.service.CommonAttachmentService;
import hjon.company.modules.homepage.entity.Inform;
import hjon.company.modules.homepage.service.InformService;

import java.util.Date;
import java.util.List;
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
public class InformController extends BaseController {
	@Resource(name = "informService")
	private InformService informService;

	@RequestMapping("homepage/inform/list")
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
		String title = this.getParameter("title");
		if (title != null && !title.equals("")) {
			search.Add(Expression.like("title", "%" + title + "%"));
			this.setAttribute("title", title);
		}
		Page data = informService
				.pagedQuery(pageNum, numPerPage, search, order);
		this.setAttribute("Module", data);
		return "homepage/informlist";
	}

	@RequestMapping("homepage/inform/edit")
	public void edit() {
		String id = this.getParameter("id");
		if (id != null && !"".equals(id)) {
			// UserInfo userInfo = userInfoService.get(id);
			Inform inform = informService.get(id);
			Gson gson = new Gson();
			this.outputText(gson.toJson(inform));
		}
		this.outputText("e");
	}

	@RequestMapping("homepage/inform/view")
	public String view() {
		String id = this.getParameter("id");
		if (id != null && !"".equals(id)) {
			// UserInfo userInfo = userInfoService.get(id);
			Inform inform = informService.get(id);
			this.setAttribute("inform", inform);
		}
		return "homepage/informview";
	}

	@RequestMapping("homepage/inform/save")
	public void save() {
		// 保存业务数据
		Inform inform = new Inform();
		String id = request.getParameter("id");
		if (id != null && !"".equals(id)) {
			inform = informService.get(id);
			this.setEntityValueFromPage(inform);
		} else {
			this.setEntityValueFromPage(inform);
			inform.setId(UUID.randomUUID().toString());
			inform.setCreateTime(new Date());
		}
		informService.saveOrUpdate(inform);
		saveAttachment("INFORM", inform.getId());
		// 查询数据库中有没有对应这条数据的附件，更新附件标识为附件数量
		List<CommonAttachment> tempAttachment = commonAttachmentService
				.findCommonAttachmentList("INFORM", inform.getId());
		if (tempAttachment != null && tempAttachment.size() > 0) {
			inform.setAttachmentFlag(1);
			informService.saveOrUpdate(inform);
		} else {
			inform.setAttachmentFlag(0);
			informService.saveOrUpdate(inform);
		}
		// ActionResult result = new ActionResult("InformList");
		this.outputText("success");
	}

	@RequestMapping(value = "homepage/inform/delete", method = RequestMethod.POST)
	public void delete() {
		try {
			String ids = this.getParameter("ids");
			if (ids == null || ids.equals("")) {
				throw new Exception("参数错误:请选择要删除的项!");
			} else {
				informService.batchDelete(ids.split(","));
			}
			this.outputText(new ActionResult("UserList", "").toString());
		} catch (Exception ex) {
			this.outputText(new ActionResult(300, ex.getMessage()).toString());
		}
	}

	@RequestMapping(value = "homepage/inform/top10inform", method = RequestMethod.POST)
	public void top10inform() {
		String type = this.getParameter("type");
		CriterionCollection search = new CriterionCollection();
		search.Add(Expression.eq("type", type));
		Order order = Order.desc("createTime");
		Page data = informService.pagedQuery(1, 5, search, order);
		Gson gson = new Gson();
		this.outputText(gson.toJson(data.getResult()));

	}

}