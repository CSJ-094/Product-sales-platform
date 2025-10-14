package com.lgy.product_sales_platform.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lgy.product_sales_platform.dto.OrdDTO;

@Mapper
public interface OrdDAO {
    /**
     * 회원 ID를 기반으로 주문 내역 목록을 조회합니다.
     * @param memberId 주문 내역을 조회할 회원의 ID
     * @return 해당 회원의 주문 내역 목록
     */
    List<OrdDTO> getOrdersByMemberId(String memberId);
}
