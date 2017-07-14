package com.rjt.dao;

import com.rjt.entity.Account;

public interface AccountDAO {

    public Account findAccount(String userName);
    public String saveAccount(String username, boolean active, String password, String user_role);
    public String saveCustomer(String username, String name, String address, String email, String phone);
	
}
