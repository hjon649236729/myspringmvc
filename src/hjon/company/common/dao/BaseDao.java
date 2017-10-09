package hjon.company.common.dao;

import hjon.company.common.bean.Page;
import hjon.company.common.utils.BeanUtils;
import hjon.company.common.utils.GenericUtils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.internal.CriteriaImpl;
import org.hibernate.internal.CriteriaImpl.OrderEntry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class BaseDao<T> extends HibernateDaoSupport {
	@Autowired
	public void setSessionFactory0(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	protected Class<T> entityClass;

	public BaseDao() {
		entityClass = GenericUtils.getSuperClassGenericType(getClass());
	}

	private Session getCurrentSession() {
		return getHibernateTemplate().getSessionFactory().getCurrentSession();
	}

	public T get(Serializable id) {
		return (T) getCurrentSession().get(entityClass, id);
	}

	@SuppressWarnings("unchecked")
	public void saveOrUpdate(T newInstance) {
		getCurrentSession().saveOrUpdate(newInstance);
	}

	public void delete(T entity) {
		if (entity != null) {
			getCurrentSession().delete(entity);
		}
	}

	public List<T> getAll(Order... orders) {
		return (List<T>) getAll(new CriterionCollection(), orders);
	}

	public List getAll(CriterionCollection criterionCollection, Order... orders) {
		Criteria criteria = createCriteria(criterionCollection, orders);

		return (List<T>) criteria.list();
	}

	public List<T> query(final String hql, final Object... values) {
		return (List<T>) createQuery(hql, values).list();
	}

	public List<T> queryByProperty(String propertyName, Object value) {
		return (List<T>) createCriteria(
				new CriterionCollection(Restrictions.eq(propertyName, value)))
				.list();
	}

	public List<T> queryByProperty(String propertyName, Object value,
			Order... orders) {
		return (List<T>) createCriteria(
				new CriterionCollection(Restrictions.eq(propertyName, value)),
				orders).list();
	}

	public Page pagedQuery(String hql, int pageNo, int pageSize,
			Object... values) {
		String countQueryString = "select count(*) "
				+ removeSelect(removeOrders(hql));
		Query query = createQuery(countQueryString, values);
		long totalCount = Long.parseLong(query.uniqueResult().toString());
		if (totalCount < 1) {
			return new Page();
		}
		int startIndex = (pageNo - 1) * pageSize;
		query = createQuery(hql, values);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize)
				.list();
		return new Page(pageNo, totalCount, pageSize, list);
	}

	public List pagedQuery(String hql, Object... values) {
		Query query = createQuery(hql, values);
		List list = query.list();
		return list;
	}

	public Page pagedQuery(Criteria criteria, int pageNo, int pageSize) {
		CriteriaImpl criteriaImpl = (CriteriaImpl) criteria;

		// 先把Projection和OrderBy条件取出来,清空两者来执行Count操作
		Projection projection = criteriaImpl.getProjection();
		List<CriteriaImpl.OrderEntry> orderEntitys = null;
		try {
			orderEntitys = (List<OrderEntry>) BeanUtils.forceGetProperty(
					criteriaImpl, "orderEntries");
			BeanUtils.forceSetProperty(criteriaImpl, "orderEntries",
					new ArrayList());
		} catch (NoSuchFieldException e) {
			throw new RuntimeException(e.getMessage());
		}
		// 取得总的数据数
		long totalCount = criteria.setProjection(Projections.rowCount())
				.uniqueResult() == null ? 0 : (Long) criteria.setProjection(
				Projections.rowCount()).uniqueResult();
		// 将之前的Projection和OrderBy条件重新设回去
		criteria.setProjection(projection);
		if (projection == null) {
			criteria.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
		}

		try {
			BeanUtils.forceSetProperty(criteriaImpl, "orderEntries",
					orderEntitys);
		} catch (NoSuchFieldException e) {
			throw new RuntimeException(e.getMessage());
		}
		if (totalCount < 1)
			return new Page();
		int startIndex = (pageNo - 1) * pageSize;
		List data = criteria.setFirstResult(startIndex).setMaxResults(pageSize)
				.list();
		return new Page(pageNo, totalCount, pageSize, data);
	}

	public Page pagedQuery(int pageNo, int pageSize, Order... orders) {
		Criteria criteria = createCriteria(new CriterionCollection(), orders);
		return pagedQuery(criteria, pageNo, pageSize);
	}

	public Page pagedQuery(int pageNo, int pageSize,
			CriterionCollection criterionCollection, Order... orders) {
		Criteria criteria = createCriteria(criterionCollection, orders);
		return pagedQuery(criteria, pageNo, pageSize);
	}

	public long queryTotalCount(CriterionCollection criterionCollection) {
		Criteria criteria = createCriteria(criterionCollection);
		CriteriaImpl criteriaImpl = (CriteriaImpl) criteria;

		// 先把Projection和OrderBy条件取出来,清空两者来执行Count操作
		Projection projection = criteriaImpl.getProjection();
		List<CriteriaImpl.OrderEntry> orderEntitys = null;
		try {
			orderEntitys = (List<OrderEntry>) BeanUtils.forceGetProperty(
					criteriaImpl, "orderEntries");
			BeanUtils.forceSetProperty(criteriaImpl, "orderEntries",
					new ArrayList());
		} catch (NoSuchFieldException e) {
			throw new RuntimeException(e.getMessage());
		}
		// 取得总的数据数
		long totalCount = criteria.setProjection(Projections.rowCount())
				.uniqueResult() == null ? 0 : (Long) criteria.setProjection(
				Projections.rowCount()).uniqueResult();
		return totalCount;
	}

	public Query createQuery(String hql, Object... values) {
		Query query = getCurrentSession().createQuery(hql);
		if (values != null) {
			for (int i = 0; i < values.length; i++) {
				query.setParameter(i, values[i]);
			}
		}
		return query;
	}

	private Criteria createCriteria(CriterionCollection criterionCollection) {
		Criteria criteria = getCurrentSession().createCriteria(entityClass);
		if (criterionCollection.getItems().size() > 0) {
			for (Criterion c : criterionCollection.getItems()) {
				criteria.add(c);
			}
		}
		return criteria;
	}

	private Criteria createCriteria(CriterionCollection criterionCollection,
			Order... orders) {
		Criteria criteria = createCriteria(criterionCollection);
		if (orders != null) {
			for (Order order : orders) {
				criteria.addOrder(order);
			}
		}
		return criteria;
	}

	private String removeSelect(String hql) {
		int beginPos = hql.toLowerCase().indexOf("from");
		return hql.substring(beginPos);
	}

	private String removeOrders(String hql) {
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}

	// public SqlExecute getSqlExecute()
	// {
	// SqlExecute sqlExecute= new SqlExecute(getCurrentSession());
	// return sqlExecute;
	// }
}