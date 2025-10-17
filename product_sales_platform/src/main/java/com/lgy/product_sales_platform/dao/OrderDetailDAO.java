package com.lgy.product_sales_platform.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lgy.product_sales_platform.dto.OrderDetailDTO;

/**
 * OrderDetail 관련 데이터베이스 작업을 위한 MyBatis Mapper 인터페이스입니다.
 */
@Mapper
public interface OrderDetailDAO {
    /**
     * 주문 상세 정보를 저장합니다.
     * @param orderDetail 저장할 주문 상세 정보 DTO
     */
    void save(OrderDetailDTO orderDetail);

    /**
     * 특정 주문 ID에 해당하는 첫 번째 상품의 ID를 조회합니다.
     * 주문 내역 목록에 대표 이미지를 표시하기 위해 사용됩니다.
     * @param orderId 주문 ID
     * @return 첫 번째 상품의 ID (없으면 null)
     */
    Long findFirstProductIdByOrderId(@Param("orderId") String orderId);
}
