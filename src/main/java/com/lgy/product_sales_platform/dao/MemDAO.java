package com.lgy.product_sales_platform.dao;

import org.apache.ibatis.annotations.Mapper;

import com.lgy.product_sales_platform.dto.MemDTO;

@Mapper
public interface MemDAO {
	public MemDTO getMemberInfo(String memberId);
	void modify(MemDTO member);
	MemDTO getUserById(String memberId);
}
