package com.lgy.product_sales_platform.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lgy.product_sales_platform.dto.ProdDTO;

@Mapper
public interface ProdDAO {
    ProdDTO getProductById(int prodId);

    List<ProdDTO> getAllProducts();

    void registerProduct(ProdDTO prodDTO);
}
