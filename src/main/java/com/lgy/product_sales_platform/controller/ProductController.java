package com.lgy.product_sales_platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.product_sales_platform.dto.ProdDTO;
import com.lgy.product_sales_platform.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    // 상품 상세 페이지 조회
    @GetMapping("/detail")
    public String getProductDetail(@RequestParam("prodId") int prodId, Model model) {
        ProdDTO product = productService.getProductById(prodId);
        model.addAttribute("product", product);
        // 임시 memberId (실제로는 로그인 세션에서 가져와야 함)
        model.addAttribute("memberId", "user01"); 
        return "product/productDetail"; // product/productDetail.jsp 뷰를 반환
    }
}
