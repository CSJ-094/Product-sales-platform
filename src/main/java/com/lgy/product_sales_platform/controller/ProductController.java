package com.lgy.product_sales_platform.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lgy.product_sales_platform.dto.ProdDTO;
import com.lgy.product_sales_platform.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    // 상품 상세 페이지 조회
    @GetMapping("/detail")
    public String getProductDetail(@RequestParam("prodId") int prodId, Model model) {
        ProdDTO product = productService.getProductById(prodId);
        model.addAttribute("product", product);
        return "productDetail"; // productDetail.jsp 뷰를 반환
    }

    // 관리자: 상품 등록 페이지 뷰
    @GetMapping("/admin/register")
    public String showProductRegisterForm(HttpSession session, RedirectAttributes redirectAttributes) {
        String memberId = (String) session.getAttribute("memberId");
        if (memberId == null || !"admin".equals(memberId)) {
            redirectAttributes.addFlashAttribute("error", "접근 권한이 없습니다.");
            return "redirect:/login";
        }
        return "productRegister"; // productRegister.jsp 뷰를 반환
    }

    // 관리자: 상품 등록 처리
    @PostMapping("/admin/add")
    public String addProduct(ProdDTO prodDTO, 
                             @RequestParam("prodImageFiles") List<MultipartFile> prodImageFiles, 
                             HttpSession session, 
                             RedirectAttributes redirectAttributes) {
        String memberId = (String) session.getAttribute("memberId");
        if (memberId == null || !"admin".equals(memberId)) {
            redirectAttributes.addFlashAttribute("error", "접근 권한이 없습니다.");
            return "redirect:/login";
        }

        try {
            prodDTO.setProdSeller(memberId);
            productService.registerProduct(prodDTO, prodImageFiles);
            redirectAttributes.addFlashAttribute("message", "상품이 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            log.error("Product registration failed", e);
            redirectAttributes.addFlashAttribute("error", "상품 등록 중 오류가 발생했습니다.");
        }

        return "redirect:/mypage#product-management";
    }

    // 관리자: 상품 삭제 처리
    @PostMapping("/admin/delete")
    public String deleteProduct(@RequestParam("prodId") int prodId, 
                                HttpSession session, 
                                RedirectAttributes redirectAttributes) {
        log.info("Attempting to delete product with ID: {}", prodId);
        String memberId = (String) session.getAttribute("memberId");
        if (memberId == null || !"admin".equals(memberId)) {
            log.warn("Unauthorized delete attempt for prodId: {} by non-admin user.", prodId);
            redirectAttributes.addFlashAttribute("error", "접근 권한이 없습니다.");
            return "redirect:/login";
        }

        try {
            productService.deleteProduct(prodId);
            log.info("Successfully deleted product with ID: {}", prodId);
            redirectAttributes.addFlashAttribute("message", "상품이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            log.error("Product deletion failed for prodId: {}", prodId, e);
            redirectAttributes.addFlashAttribute("error", "상품 삭제 중 오류가 발생했습니다.");
        }

        log.info("Redirecting to /mypage#product-management after delete attempt.");
        return "redirect:/mypage#product-management";
    }
}
