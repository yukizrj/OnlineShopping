package com.rjt.dao.impl;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.rjt.dao.AccountDAO;
import com.rjt.entity.Account;
import com.rjt.entity.Customer;
import com.rjt.entity.CustomerTable;

// Transactional for Hibernate
@Transactional
public class AccountDAOImpl implements AccountDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Account findAccount(String userName) {
        Session session = sessionFactory.getCurrentSession();
        Criteria crit = session.createCriteria(Account.class);
        crit.add(Restrictions.eq("userName", userName));
        return (Account) crit.uniqueResult();
    }

	@Override
	public String saveAccount(String username, boolean active, String password, String user_role) {
		Session session= sessionFactory.getCurrentSession();
		Account account=new Account();
		account.setUserName(username);
		account.setActive(active);
		account.setPassword(password);
		account.setUserRole(user_role);
		Account ac1=(Account) session.get(Account.class,username);
		if(ac1==null){
			try{
				session.save(account);	
			}catch(Exception e){
				return e.getMessage();
			}
		}
		else{
			return "username already existed";
		}
		return "create account successfully";
		
	}

	@Override
	public String saveCustomer(String username, String name, String address, String email, String phone) {
		Session session= sessionFactory.getCurrentSession();
		CustomerTable customer=new CustomerTable(username, name, address, email, phone);
		CustomerTable cus=(CustomerTable) session.get(CustomerTable.class, username);
		if(cus==null){
			try{
				session.saveOrUpdate(customer);
			}catch(Exception e){
				return e.getMessage();
			}
		}
		else{
			return "username already existed";
		}
		return "customer information saved";
	}


}
