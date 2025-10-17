package com.lgy.product_sales_platform.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.lgy.product_sales_platform.dto.ProdDTO;

public interface ProductService {
    ProdDTO getProductById(Integer prodId); 
    List<ProdDTO> getProductListWithImages(); // 이미지 포함된 상품 목록 조회 메서드 추가
    void createProductWithCategories(ProdDTO product, List<Long> catIds, Long mainCatId, MultipartFile[] files); // MultipartFile[]로 변경
    void updateProductWithCategories(ProdDTO form, List<Long> catIds, Long mainCatId);
}