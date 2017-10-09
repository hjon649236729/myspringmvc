package hjon.company.modules.auth.controller;

import hjon.company.common.bean.ActionResult;
import hjon.company.common.bean.Page;
import hjon.company.common.controller.BaseController;
import hjon.company.common.dao.CriterionCollection;
import hjon.company.common.utils.CookieUtil;
import hjon.company.modules.auth.entity.UserInfo;
import hjon.company.modules.auth.service.UserInfoService;
import hjon.company.modules.common.service.CommonSettingService;
import hjon.company.modules.homepage.service.InformService;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletException;

import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@Scope("prototype")
public class UserController extends BaseController {
	@Resource(name = "userInfoService")
	private UserInfoService userInfoService;
	@Resource(name = "informService")
	private InformService informService;

	@RequestMapping("auth/user/list")
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
		Page data = userInfoService.pagedQuery(pageNum, numPerPage, search,
				order);
		this.setAttribute("Module", data);
		return "auth/userlist";
	}

	@RequestMapping("auth/user/edit")
	public String edit() {
		String id = this.getParameter("id");
		if (id != null && !"".equals(id)) {
			UserInfo userInfo = userInfoService.get(id);
			this.setAttribute("Module", userInfo);
		}
		return "auth/UserEdit";
	}

	@RequestMapping("auth/user/index")
	public String index() {
		try {
			CookieUtil.readCookieAndLogon(request, response, userInfoService);
			UserInfo user = this.getUser();
			if (user != null) {
				this.setAttribute("Module", user);
			} else {
				return "auth/login";
			}

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "auth/login";
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "auth/login";
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "auth/login";
		}
		return "main/index";
	}

	@RequestMapping("auth/user/checkLogin")
	public void checkLogin() {
		String userName = request.getParameter("userName");
		String passWord = request.getParameter("passWord");
		UserInfo userInfo = userInfoService.checkLogin(userName, passWord);
		if (userInfo != null) {
			CookieUtil.saveCookie(userInfo, response);
			this.setSession("login_user", userInfo);
			this.outputText("1");
		} else {
			this.outputText("2");
		}
	}

	@RequestMapping("login")
	public String login() {
		// parameterService.resetSystemParameter();
		CookieUtil.clearCookie(response);
		this.removeSession("login_user");
		this.removeSession("login_location");
		this.removeSession("userPermission");
		return "auth/login";
	}

	@RequestMapping("auth/user/save")
	public void save() {
		UserInfo user = new UserInfo();
		String id = request.getParameter("id");
		if (id != null && !"".equals(id)) {
			user = userInfoService.get(id);
			this.setEntityValueFromPage(user);
		} else {
			this.setEntityValueFromPage(user);
			user.setId(UUID.randomUUID().toString());
		}
		userInfoService.saveOrUpdate(user);
		ActionResult result = new ActionResult("UserList");
		this.outputText(result.toString());
	}

	@RequestMapping(value = "auth/user/delete", method = RequestMethod.POST)
	public void delete() {
		try {
			String ids = this.getParameter("ids");
			if (ids == null || ids.equals("")) {
				throw new Exception("参数错误:请选择要删除的项!");
			} else {
				userInfoService.batchDelete(ids.split(","));
			}
			this.outputText(new ActionResult("UserList", "").toString());
		} catch (Exception ex) {
			this.outputText(new ActionResult(300, ex.getMessage()).toString());
		}
	}

	@RequestMapping("home")
	public String home() {
		CriterionCollection search = new CriterionCollection();
		Order order = Order.desc("createTime");
		Page informList = informService.pagedQuery(1, 5, search, order);
		// parameterService.resetSystemParameter();
		// CookieUtil.clearCookie(response);
		// this.removeSession("login_user");
		// this.removeSession("login_location");
		// this.removeSession("userPermission");
		this.setAttribute("informList", informList);
		return "main/home";
	}
}