package com.lgy.product_sales_platform.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lgy.product_sales_platform.dto.ProdDTO;
import com.lgy.product_sales_platform.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/category")
@Slf4j
public class CategoryController {

    @Autowired
    private ProductService productService; 

    // MANS 카테고리 페이지 처리
    @GetMapping("/mans")
    public String mansCategoryPage(Model model) {
        
        final int MANS_CAT_ID = 5;
        
        try {
            List<ProdDTO> mansList = productService.getAllProdsByCatId(MANS_CAT_ID); 
            
            model.addAttribute("mansList", mansList); 
            log.info("@# MANS 카테고리 전체 상품 {}개 조회 완료.", mansList.size());
            
        } catch (Exception e) {
            log.error("MANS 카테고리 상품 조회 중 오류 발생: {}", e.getMessage());
            model.addAttribute("mansList", List.of());
        }
        
        return "category/mans"; 
    }
}
