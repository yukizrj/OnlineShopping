package com.rjt.entity;

import javax.persistence.*;

@Embeddable
public class Category {
	private String name;
	
	public Category(){}
	public Category(String name){
		this.name=name;
	}
	@Column(name="Category_Name", length = 255, nullable = false)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
