package com.lgy.product_sales_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgy.product_sales_platform.dao.CartDAO;
import com.lgy.product_sales_platform.dao.WishlistDAO;
import com.lgy.product_sales_platform.dto.CartDTO;
import com.lgy.product_sales_platform.dto.WishlistDTO;

import java.util.List;

@Service
public class CartService {

    @Autowired
    private CartDAO cartMapper;

    @Autowired
    private WishlistDAO wishlistMapper;

    public List<CartDTO> getCartListByMemberId(String memberId) {
        return cartMapper.getCartListByMemberId(memberId);
    }

    public void addCart(String memberId, int prodId, int cartQty) {
        CartDTO existingCartItem = cartMapper.getCartItemByMemberIdAndProdId(memberId, prodId);
        if (existingCartItem != null) {
            // 이미 장바구니에 있는 상품이면 수량만 업데이트
            existingCartItem.setCartQty(existingCartItem.getCartQty() + cartQty);
            cartMapper.updateCartQuantity(existingCartItem);
        } else {
            // 장바구니에 없는 상품이면 새로 추가
            CartDTO newCartItem = new CartDTO();
            newCartItem.setMemberId(memberId);
            newCartItem.setProdId(prodId);
            newCartItem.setCartQty(cartQty);
            cartMapper.insertCart(newCartItem);
        }
    }

    public void updateCartQuantity(int cartId, String memberId, int cartQty) {
        CartDTO cartDTO = new CartDTO();
        cartDTO.setCartId(cartId);
        cartDTO.setMemberId(memberId); // 보안을 위해 memberId도 함께 전달
        cartDTO.setCartQty(cartQty);
        cartMapper.updateCartQuantity(cartDTO);
    }

    public void deleteCart(int cartId, String memberId) {
        cartMapper.deleteCart(cartId, memberId);
    }

    @Transactional // 두 개 이상의 DB 작업이 하나의 논리적인 단위로 처리되도록 트랜잭션 적용
    public void moveWishlistItemToCart(String memberId, int prodId, int cartQty) {
        // 1. 장바구니에 상품 추가 (기존 상품이 있으면 수량 업데이트)
        addCart(memberId, prodId, cartQty);

        // 2. 찜목록에서 해당 상품 삭제
        WishlistDTO wishlistDTO = new WishlistDTO();
        wishlistDTO.setMemberId(memberId);
        wishlistDTO.setProdId(prodId);
        wishlistMapper.removeWishlist(wishlistDTO);
    }
}
