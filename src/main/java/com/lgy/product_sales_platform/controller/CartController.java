package com.lgy.product_sales_platform.controller;

import com.lgy.product_sales_platform.dto.CartDTO;
import com.lgy.product_sales_platform.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession; // HttpSession 임포트 추가
import java.util.List;

@Controller
public class CartController {

    @Autowired
    private CartService cartService;
    
    // ⭐️ 공통: 세션에서 memberId를 가져오고 로그인 여부를 확인하는 유틸리티 메서드
    private String getMemberIdOrRedirect(HttpSession session, RedirectAttributes redirectAttributes) {
        String memberId = (String) session.getAttribute("memberId"); // pscontroller에서 설정한 세션 키 사용
        
        if (memberId == null) {
            // 로그인되어 있지 않다면 메시지를 담아 로그인 페이지로 리다이렉트 준비
            redirectAttributes.addFlashAttribute("loginError", "로그인이 필요합니다.");
        }
        return memberId;
    }

    // 장바구니에 상품 추가 (POST /mypage/cart/add)
    @PostMapping("/mypage/cart/add")
    public String addCart(HttpSession session, 
                          @RequestParam("prodId") int prodId,
                          @RequestParam(value = "cartQty", defaultValue = "1") int cartQty,
                          RedirectAttributes redirectAttributes) {
                          
        // 1. 세션에서 memberId를 가져오고 로그인 여부 확인
        String memberId = getMemberIdOrRedirect(session, redirectAttributes);
        
        if (memberId == null) {
            return "redirect:/login";
        }
        
        // 2. 장바구니 추가 로직
        try {
            cartService.addCart(memberId, prodId, cartQty); // 세션에서 가져온 ID 사용
            redirectAttributes.addFlashAttribute("message", "상품이 장바구니에 추가되었습니다.");
            System.out.println("addCart: Successfully added item to cart, redirecting to /mypage#cart");
        } catch (Exception e) {
            // 예외 처리 (예: 재고 부족 등)
            redirectAttributes.addFlashAttribute("errorMessage", "장바구니 추가 중 오류가 발생했습니다: " + e.getMessage());
            System.err.println("addCart: Error adding item to cart: " + e.getMessage());
            e.printStackTrace();
        }
        
        // 3. 장바구니 목록 페이지로 리다이렉트
        return "redirect:/mypage#cart"; 
    }

    // 장바구니 상품 수량 변경 (POST /mypage/cart/update)
    @PostMapping("/mypage/cart/update")
    public String updateCart(@RequestParam("cartId") int cartId,
                             HttpSession session, // 세션 추가
                             @RequestParam("cartQty") int cartQty,
                             RedirectAttributes redirectAttributes) {
        
        // 1. 세션에서 memberId를 가져오고 로그인 여부 확인
        String memberId = getMemberIdOrRedirect(session, redirectAttributes);
        
        if (memberId == null) {
            return "redirect:/login";
        }

        // 2. 수량 변경 로직
        try {
             // 보안: 세션 ID와 cartId를 함께 사용하여 해당 장바구니 항목이 현재 사용자의 것인지 확인하도록 서비스에 전달
            cartService.updateCartQuantity(cartId, memberId, cartQty); 
            redirectAttributes.addFlashAttribute("message", "장바구니 수량이 변경되었습니다.");
            System.out.println("updateCart: Successfully updated cart quantity, redirecting to /mypage#cart");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "수량 변경 중 오류가 발생했습니다: " + e.getMessage());
            System.err.println("updateCart: Error updating cart quantity: " + e.getMessage());
            e.printStackTrace();
        }

        return "redirect:/mypage#cart";
    }

    // 장바구니 상품 삭제 (POST /mypage/cart/remove)
    @PostMapping("/mypage/cart/remove")
    public String removeCart(@RequestParam("cartId") int cartId,
                             HttpSession session, // 세션 추가
                             RedirectAttributes redirectAttributes) {
        
        // 1. 세션에서 memberId를 가져오고 로그인 여부 확인
        String memberId = getMemberIdOrRedirect(session, redirectAttributes);
        
        if (memberId == null) {
            return "redirect:/login";
        }

        // 2. 삭제 로직
        try {
            // 보안: 세션 ID와 cartId를 함께 사용하여 해당 항목이 현재 사용자의 것인지 확인
            cartService.deleteCart(cartId, memberId); 
            redirectAttributes.addFlashAttribute("message", "장바구니에서 상품이 삭제되었습니다.");
            System.out.println("removeCart: Successfully removed item from cart, redirecting to /mypage#cart");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "상품 삭제 중 오류가 발생했습니다: " + e.getMessage());
            System.err.println("removeCart: Error removing item from cart: " + e.getMessage());
            e.printStackTrace();
        }
        
        return "redirect:/mypage#cart";
    }

    // 찜목록 상품을 장바구니로 이동 (POST /mypage/cart/moveFromWishlist)
    @PostMapping("/mypage/cart/moveFromWishlist")
    public String moveFromWishlist(HttpSession session, // 세션 추가
                                   @RequestParam("prodId") int prodId,
                                   @RequestParam(value = "cartQty", defaultValue = "1") int cartQty,
                                   RedirectAttributes redirectAttributes) {
        
        System.out.println("moveFromWishlist: Entering method for prodId: " + prodId + ", cartQty: " + cartQty);

        // 1. 세션에서 memberId를 가져오고 로그인 여부 확인
        String memberId = getMemberIdOrRedirect(session, redirectAttributes);
        
        if (memberId == null) {
            System.out.println("moveFromWishlist: memberId is null, redirecting to /login");
            return "redirect:/login";
        }
        
        // 2. 이동 로직
        try {
            cartService.moveWishlistItemToCart(memberId, prodId, cartQty);
            redirectAttributes.addFlashAttribute("message", "찜목록 상품이 장바구니로 이동되었습니다.");
            System.out.println("moveFromWishlist: Successfully moved item to cart, redirecting to /mypage#cart");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "상품 이동 중 오류가 발생했습니다: " + e.getMessage());
            System.err.println("moveFromWishlist: Error moving item to cart: " + e.getMessage());
            e.printStackTrace(); // 스택 트레이스 출력
        }
        
        return "redirect:/mypage#cart";
    }
}