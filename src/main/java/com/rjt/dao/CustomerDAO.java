package com.rjt.dao;

import com.rjt.entity.CustomerTable;

public interface CustomerDAO {
	public CustomerTable findCustomer(String username);
}
