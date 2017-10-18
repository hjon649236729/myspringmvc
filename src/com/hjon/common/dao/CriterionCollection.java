package com.hjon.common.dao;

import java.util.ArrayList;
import org.hibernate.criterion.Criterion;

public class CriterionCollection{
    public CriterionCollection(Criterion... criterions)
    {
        if (criterions != null)
        {
            _criterions =new ArrayList<Criterion>();
            for (int i = 0; i < criterions.length; i++)
            {
                _criterions.add(criterions[i]);
            }
        }
    }

    ArrayList<Criterion> _criterions;

    public CriterionCollection Add(Criterion criterion)
    {
        if (_criterions != null)
        {
        	_criterions.add(criterion);
        }
        else
        {
            _criterions = new ArrayList<Criterion>();
            _criterions.add(criterion);
        }
        return this;
    }
    
    public  ArrayList<Criterion> getItems()
    {
    	return _criterions;
    }
}
