package com.lgy.product_sales_platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lgy.product_sales_platform.dto.CartDTO;
import com.lgy.product_sales_platform.service.CartService;

import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    // 장바구니 목록 조회
    @GetMapping
    public String getCartList(@RequestParam("memberId") String memberId, Model model) {
        List<CartDTO> cartList = cartService.getCartListByMemberId(memberId);
        model.addAttribute("cartList", cartList);
        model.addAttribute("memberId", memberId);
        return "cart/cartList"; // cart/cartList.jsp 뷰를 반환
    }

    // 장바구니에 상품 추가
    @PostMapping("/add")
    public String addCart(@RequestParam("memberId") String memberId,
                          @RequestParam("prodId") int prodId,
                          @RequestParam(value = "cartQty", defaultValue = "1") int cartQty,
                          RedirectAttributes redirectAttributes) {
        cartService.addCart(memberId, prodId, cartQty);
        redirectAttributes.addFlashAttribute("message", "상품이 장바구니에 추가되었습니다.");
        return "redirect:/cart?memberId=" + memberId;
    }

    // 장바구니 상품 수량 변경
    @PostMapping("/updateQty")
    public String updateCartQuantity(@RequestParam("cartId") int cartId,
                                     @RequestParam("memberId") String memberId,
                                     @RequestParam("cartQty") int cartQty,
                                     RedirectAttributes redirectAttributes) {
        cartService.updateCartQuantity(cartId, memberId, cartQty);
        redirectAttributes.addFlashAttribute("message", "장바구니 수량이 변경되었습니다.");
        return "redirect:/cart?memberId=" + memberId;
    }

    // 장바구니 상품 삭제
    @PostMapping("/remove")
    public String removeCart(@RequestParam("cartId") int cartId,
                             @RequestParam("memberId") String memberId,
                             RedirectAttributes redirectAttributes) {
        cartService.deleteCart(cartId, memberId);
        redirectAttributes.addFlashAttribute("message", "장바구니에서 상품이 삭제되었습니다.");
        return "redirect:/cart?memberId=" + memberId;
    }

    // 찜목록 상품을 장바구니로 이동
    @PostMapping("/moveFromWishlist")
    public String moveFromWishlist(@RequestParam("memberId") String memberId,
                                   @RequestParam("prodId") int prodId,
                                   @RequestParam(value = "cartQty", defaultValue = "1") int cartQty,
                                   RedirectAttributes redirectAttributes) {
        cartService.moveWishlistItemToCart(memberId, prodId, cartQty);
        redirectAttributes.addFlashAttribute("message", "찜목록 상품이 장바구니로 이동되었습니다.");
        return "redirect:/cart?memberId=" + memberId;
    }
}
