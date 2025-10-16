package com.lgy.product_sales_platform.dao;

import org.apache.ibatis.annotations.Mapper;

import com.lgy.product_sales_platform.dto.ProdDTO;

@Mapper
public interface ProdDAO {
    ProdDTO getProductById(int prodId);
}
