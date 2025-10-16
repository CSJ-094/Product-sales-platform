package com.lgy.product_sales_platform.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.lgy.product_sales_platform.dto.ProdDTO;

public interface ProductService {
    ProdDTO getProductById(Integer prodId); 
    void createProductWithCategories(ProdDTO product, List<Long> catIds, Long mainCatId, MultipartFile file);
    void updateProductWithCategories(ProdDTO form, List<Long> catIds, Long mainCatId);
}