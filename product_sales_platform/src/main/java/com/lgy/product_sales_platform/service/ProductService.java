package com.lgy.product_sales_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.product_sales_platform.dao.ProdDAO;
import com.lgy.product_sales_platform.dto.ProdDTO;

@Service
public class ProductService {

    @Autowired
    private ProdDAO productMapper;

    public ProdDTO getProductById(int prodId) {
        return productMapper.getProductById(prodId);
    }
}
