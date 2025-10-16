package com.lgy.product_sales_platform.dao;

import com.lgy.product_sales_platform.dto.SellerDTO;
import org.apache.ibatis.annotations.Mapper; // @Mapper를 사용하지 않으면 생략 가능

public interface SellerDAO {
    // 로그인 정보를 받아 일치하는 SellerDTO를 반환하는 메서드
    public SellerDTO loginCheck(SellerDTO dto);
}