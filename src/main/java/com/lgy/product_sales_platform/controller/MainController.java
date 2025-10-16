package com.lgy.product_sales_platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.lgy.product_sales_platform.service.ProductService;

@Controller
public class MainController {
	    @Autowired
	    private ProductService productService; // 상품 추천 목록을 가져오기 위한 Service

	    @GetMapping("/mainpage")
	    public String mainPage(Model model) {
//	        // 예시: 상품 서비스에서 추천 목록을 가져와 Model에 담아 JSP로 전달
//	        model.addAttribute("mansRecommendList", productService.getRecommendList("MANS"));
//	        model.addAttribute("womenRecommendList", productService.getRecommendList("WOMEN"));
//
//	        // "main"이라는 이름의 뷰를 반환 (-> main.jsp)
	        return "mainpage"; 
	    }
	}
