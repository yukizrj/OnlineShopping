package com.rjt.dao.impl;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.rjt.dao.CustomerDAO;
import com.rjt.entity.Account;
import com.rjt.entity.CustomerTable;
@Transactional
public class CustomerDAOImpl implements CustomerDAO{

	 @Autowired
	    private SessionFactory sessionFactory;
	
	@Override
	public CustomerTable findCustomer(String username) {
		Session session= sessionFactory.getCurrentSession();
		Criteria crit = session.createCriteria(CustomerTable.class);
        crit.add(Restrictions.eq("username", username));
        return (CustomerTable) crit.uniqueResult();
	}

}
