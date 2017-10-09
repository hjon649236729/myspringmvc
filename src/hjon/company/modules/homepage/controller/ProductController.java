package hjon.company.modules.homepage.controller;

import hjon.company.common.bean.ActionResult;
import hjon.company.common.bean.Page;
import hjon.company.common.controller.BaseController;
import hjon.company.common.dao.CriterionCollection;
import hjon.company.modules.homepage.entity.Product;
import hjon.company.modules.homepage.service.ProductService;

import java.util.UUID;

import javax.annotation.Resource;

import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@Scope("prototype")
public class ProductController extends BaseController {
	@Resource(name = "productService")
	private ProductService productService;

	@RequestMapping("homepage/product/list")
	public String list() {
		String orgId = this.getParameter("orgId");
		this.setAttribute("orgId", orgId);
		int pageNum = this.getParameter("pageNum") == null ? 1 : Integer
				.parseInt(this.getParameter("pageNum"));
		int numPerPage = this.getParameter("numPerPage") == null ? 20 : Integer
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
		String userName = this.getParameter("userName");
		if (userName != null && !userName.equals("")) {
			search.Add(Expression.like("userName", "%" + userName + "%"));
			this.setAttribute("userName", userName);
		}
		Page data = productService.pagedQuery(pageNum, numPerPage, search,
				order);
		this.setAttribute("Module", data);
		return "homepage/ProductList";
	}

	@RequestMapping("homepage/product/edit")
	public String edit() {
		String id = this.getParameter("id");
		if (id != null && !"".equals(id)) {
			// UserInfo userInfo = userInfoService.get(id);
			Product product = productService.get(id);
			this.setAttribute("Module", product);
		}
		return "homepage/ProductEdit";
	}

	@RequestMapping("homepage/product/view")
	public String view() {
		String id = this.getParameter("id");
		if (id != null && !"".equals(id)) {
			// UserInfo userInfo = userInfoService.get(id);
			Product product = productService.get(id);
			this.setAttribute("Module", product);
		}
		return "homepage/productView";
	}

	@RequestMapping("homepage/product/save")
	public void save() {
		Product product = new Product();
		String id = request.getParameter("id");
		if (id != null && !"".equals(id)) {
			product = productService.get(id);
			this.setEntityValueFromPage(product);
		} else {
			this.setEntityValueFromPage(product);
			product.setId(UUID.randomUUID().toString());
		}
		productService.saveOrUpdate(product);
		ActionResult result = new ActionResult("ProductList");
		this.outputText(result.toString());
	}

	@RequestMapping(value = "homepage/product/delete", method = RequestMethod.POST)
	public void delete() {
		try {
			String ids = this.getParameter("ids");
			if (ids == null || ids.equals("")) {
				throw new Exception("参数错误:请选择要删除的项!");
			} else {
				productService.batchDelete(ids.split(","));
			}
			this.outputText(new ActionResult("ProductList", "").toString());
		} catch (Exception ex) {
			this.outputText(new ActionResult(300, ex.getMessage()).toString());
		}
	}
}