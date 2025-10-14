package com.lgy.product_sales_platform.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lgy.product_sales_platform.dto.CartDTO;

@Mapper
public interface CartDAO {
	 // 장바구니 목록 조회
    List<CartDTO> getCartListByMemberId(String memberId);

    // 장바구니에 상품 추가
    void insertCart(CartDTO cartDTO);

    // 장바구니 상품 수량 업데이트
    void updateCartQuantity(CartDTO cartDTO);

    // 장바구니 상품 삭제
    void deleteCart(@Param("cartId") int cartId, @Param("memberId") String memberId);

    // 특정 상품이 장바구니에 이미 있는지 확인
    CartDTO getCartItemByMemberIdAndProdId(@Param("memberId") String memberId, @Param("prodId") int prodId);

    // 찜목록에서 장바구니로 이동 시 사용 (찜목록 상품을 장바구니에 추가하고 찜목록에서 삭제)
    // 이 메서드는 Service 계층에서 여러 Mapper 호출을 조합하여 구현될 예정입니다.
}
