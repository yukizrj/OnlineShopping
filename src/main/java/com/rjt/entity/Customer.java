package com.rjt.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class Customer {
    private String name;
    private String address;
    private String email;
    private String phone;

    public Customer(){
    }
    public Customer(String name, String address, String email, String phone){
        this.name = name;
        this.address = address;
        this.email = email;
        this.phone = phone;
    }

    @Column(name = "Customer_Name", length = 255, nullable = false)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "Customer_Address", length = 255, nullable = false)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Column(name = "Customer_Email", length = 128, nullable = false)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "Customer_Phone", length = 128, nullable = false)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
