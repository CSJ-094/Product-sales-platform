// src/main/java/com/lgy/product_sales_platform/service/ProductServiceImpl.java

package com.lgy.product_sales_platform.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

// 🚨 경로를 실제 프로젝트 구조에 맞게 수정해주세요.
import com.lgy.product_sales_platform.dao.ProdDAO;
import com.lgy.product_sales_platform.dao.ProductCategoryDAO;
import com.lgy.product_sales_platform.dto.ProdDTO; 
import com.lgy.product_sales_platform.dto.ProductCategoryDTO; 

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j; 

@Service
@RequiredArgsConstructor
@Slf4j 
public class ProductServiceImpl implements ProductService {

    // ⭐️ ProdDAO만 주입하고, DAO 변수명은 prodDAO로 통일합니다.
    private final ProdDAO prodDAO; 
    private final ProductCategoryDAO productCategoryDAO;
    
    // 1. [Read 기능] 상품 상세 조회
    @Override
    public ProdDTO getProductById(Integer prodId) {
        log.info("Fetching product detail for prodId: {}", prodId);
        return prodDAO.getProductById(prodId); 
    }

    // 2. [Admin 기능] 상품 등록
    @Override
    @Transactional
    public void createProductWithCategories(ProdDTO product, List<Long> catIds, Long mainCatId) {
        // ⭐️ ProdDAO를 통해 insertProduct 메서드 호출
        prodDAO.insertProduct(product); 

        if (catIds == null || catIds.isEmpty()) {
            throw new IllegalArgumentException("카테고리를 최소 1개 선택해 주세요.");
        }
        if (mainCatId == null || !catIds.contains(mainCatId)) {
            mainCatId = catIds.get(0);
        }
        
        List<ProductCategoryDTO> list = new ArrayList<ProductCategoryDTO>();
        for (Long cid : catIds) {
            ProductCategoryDTO m = new ProductCategoryDTO();
            m.setProdId(product.getProdId());
            m.setCatId(cid);
            m.setIsMain(cid.equals(mainCatId) ? "Y" : "N");
            list.add(m);
        }
        productCategoryDAO.bulkInsert(list);
    }
    
    @Override
    @Transactional
    public void updateProductWithCategories(ProdDTO form, List<Long> catIds, Long mainCatId) {
        // ⭐️ ProdDAO를 통해 updateProduct 메서드 호출
        prodDAO.updateProduct(form);
        productCategoryDAO.deleteAllByProdId(form.getProdId());

        if (catIds == null || catIds.isEmpty()) {
            throw new IllegalArgumentException("카테고리를 최소 1개 선택해 주세요.");
        }
        if (mainCatId == null || !catIds.contains(mainCatId)) {
            mainCatId = catIds.get(0);
        }

        List<ProductCategoryDTO> list = new ArrayList<ProductCategoryDTO>();
        for (Long cid : catIds) {
            ProductCategoryDTO m = new ProductCategoryDTO();
            m.setProdId(form.getProdId());
            m.setCatId(cid);
            m.setIsMain(cid.equals(mainCatId) ? "Y" : "N");
            list.add(m);
        }
        productCategoryDAO.bulkInsert(list);
    }
}