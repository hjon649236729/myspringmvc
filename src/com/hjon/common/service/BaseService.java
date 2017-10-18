package com.hjon.common.service;

import com.hjon.common.bean.Page;
import com.hjon.common.dao.BaseDao;
import com.hjon.common.dao.CriterionCollection;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BaseService<T> extends BaseDao<T> {
	public T get(Serializable id) {
		return super.get(id);
	}

	@SuppressWarnings("unchecked")
	public void saveOrUpdate(T newInstance){	
		super.saveOrUpdate(newInstance);
	}
	
	@SuppressWarnings("unchecked")
	public void saveOrUpdate(List<T> lstInstance){	
		for(T instance : lstInstance){
			super.saveOrUpdate(instance);
		}
	}
    
	public void delete(T entity) {
		if(entity!=null)
		{
			super.delete(entity);
		}
	}
	
	public void delete(Serializable id) {
		delete(get(id));
	}
	
    public void batchDelete(String[] ids)
    {
        for(String id : ids)
        {
        	if(!id.equals(""))
        	{
        		delete(id);
        	}
        }
    }
    
    public void batchDelete(Integer[] ids)
    {
        for(Integer id : ids)
        {
        	if(!id.equals(""))
        	{
        		delete(id);
        	}
        }
    }
    public void batchDelete(Long[] ids)
    {
        for(Long id : ids)
        {
        	if(!id.equals(""))
        	{
        		delete(id);
        	}
        }
    }
    public void batchDelete(List<T> entities)
    {
        for(T ent : entities)
        {
            delete(ent);
        }
    }
	
    public List<T> getAll(Order ... orders)
    {
    	return super.getAll(orders);
    }
    
    public List<T> getAll(CriterionCollection criterionCollection, Order ... orders)
    {
    	return super.getAll(criterionCollection,orders);
    }
	
	
	public List<T> query(final String hql,final Object...values){
		return super.query(hql,values);
	}
    
	public List<T> queryByProperty(String propertyName,Object value){
		return super.queryByProperty(propertyName,value);
	}
	
	public List<T> queryByProperty(String propertyName,Object value,Order... orders){
		return super.queryByProperty(propertyName,value,orders);
	}

	public List<T> pagedQuery(String hql,Object...values){
		return super.pagedQuery(hql,values);
	}
	
	public Page pagedQuery(String hql,int pageNo,int pageSize,Object...values){
		return super.pagedQuery(hql,pageNo,pageSize,values);
	}
	
	public Page pagedQuery(Criteria criteria,int pageNo,int pageSize){
		return super.pagedQuery(criteria,pageNo,pageSize);
	}
	
	public Page pagedQuery(int pageNo,int pageSize,Order... orders){
		return super.pagedQuery(pageNo,pageSize,orders);
	}
	
    public Page pagedQuery(int pageNo, int pageSize, CriterionCollection criterionCollection, Order... orders)
    {
    	return super.pagedQuery(pageNo,pageSize,criterionCollection,orders);
    }

    public long queryTotalCount(CriterionCollection criterionCollection)
    {
    	return super.queryTotalCount(criterionCollection);
    }
    
    /*
     * 用于sql参数包含数组的情况,使用setParameterList给参数赋值
     */
    protected Query createQuery(String hql)
    {
    	return super.createQuery(hql);
    }
    
//    /*
//     * 必须放到Spring事务中才可以执行，否则session为Close
//     */
//	public SqlExecute getSqlExecute()
//	{
//		return super.getSqlExecute();
//	}
//	
//	public String getDbType()
//	{
//		if(Constant.dbType==null){
//			BasicDataSource dataSource = (BasicDataSource)springContextUtil.getBean("dataSource");
//			Constant.dbType = dataSource.getUrl().split("://")[0].split(":")[1].toLowerCase();
//		}
//		return Constant.dbType;
//	}
}
