package com.hjon.modules.auth.controller;

import javax.annotation.Resource;

import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hjon.common.bean.Page;
import com.hjon.common.controller.BaseController;
import com.hjon.common.dao.CriterionCollection;
import com.hjon.common.utils.NumberUtils;
import com.hjon.common.utils.StringUtils;
import com.hjon.modules.auth.service.UserInfoService;

@Controller
@Scope("prototype")
public class UserInfoController extends BaseController {

	@Resource(name = "userInfoService")
	private UserInfoService userInfoService;

	@RequestMapping("auth/userlist")
	public String userlist() {

		String orgId = this.getParameter("orgId");
		this.setAttribute("orgId", orgId);
		int pageNum = NumberUtils
				.safeToInteger(this.getParameter("pageNum"), 1);
		int numPerPage = NumberUtils.safeToInteger(
				this.getParameter("numPerPage"), 10);
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
		if (userName != null && !"".equals(userName)) {
			search.Add(Expression.like("userName", "%" + userName + "%"));
			this.setAttribute("userName", userName);
		}
		Page data = userInfoService.pagedQuery(pageNum, numPerPage, search,
				order);
		this.setAttribute("data", data);
		return "auth/userlist";
	}

	@RequestMapping("auth/useredit")
	public String useredit() {

		return "auth/useredit";
	}

	@RequestMapping("auth/usersave")
	public String save() {

		return "";
	}

	@RequestMapping("auth/userdelete")
	public String delete() {

		return "";
	}
}
