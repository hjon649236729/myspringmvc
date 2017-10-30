package com.hjon.modules.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.dao.CriterionCollection;
import com.hjon.common.service.BaseService;
import com.hjon.modules.common.entity.SysMenu;

@Service
@Transactional
public class SysMenuService extends BaseService<SysMenu> {

	public List<SysMenu> getTopMenus(String syscode) {
		// TODO Auto-generated method stub
		// List<SysMenu> sysmenu=this.queryByProperty(propertyName, value)
		/*
		 * Map<String, Object> params = new HashMap<String, Object>();
		 * params.put("syscode", syscode); params.put("parentId", 0); Order
		 * order = Order.asc("order"); List<SysMenu> sysmenus =
		 * this.queryByProperty(params, order);
		 */
		// CriterionCollection search = new CriterionCollection();
		// search.Add(Expression.eq("syscode", 0));
		// search.Add(Expression.eq("parentId", 0));
		// Order order = Order.desc("order");
		List<SysMenu> sysmenus = this.queryByProperty("parentId", 0);
		return sysmenus;
	}

	public List<SysMenu> findSysMenuByParentId(int parentid) {
		// TODO Auto-generated method stub
		// Map<String, Object> params = new HashMap<String, Object>();
		// //params.put("syscode", "DEFAULT");
		// params.put("parentId", parentid);
		// Order order = Order.asc("order");
		// List<SysMenu> sysmenus = this.queryByProperty(params, order);
		List<SysMenu> sysmenus = this.queryByProperty("parentId", parentid);
		return sysmenus;
	}

}
