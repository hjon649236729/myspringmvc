package hjon.company.modules.auth.service;

import hjon.company.common.dao.CriterionCollection;
import hjon.company.common.service.BaseService;
import hjon.company.modules.auth.entity.UserInfo;

import java.util.List;

import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserInfoService extends BaseService<UserInfo> {

	public UserInfo getUserInfoByName(String userName) {
		// UserInfo userInfo=this.getHibernateTemplate();
		CriterionCollection search = new CriterionCollection();
		search.Add(Expression.eq("userName", userName));
		UserInfo userInfo = new UserInfo();
		Order order = Order.asc("id");
		List<UserInfo> userList = getAll(search, order);
		if (userList != null && userList.size() > 0) {
			return userList.get(0);
		} else {
			return null;
		}
	}

	public UserInfo checkLogin(String userName, String passWord) {
		CriterionCollection search = new CriterionCollection();
		search.Add(Expression.eq("userName", userName));
		search.Add(Expression.eq("passWord", passWord));
		Order order = Order.asc("id");
		List<UserInfo> userList = getAll(search, order);
		if (userList != null && userList.size() > 0) {
			return userList.get(0);
		} else {
			return null;
		}
	}
}
