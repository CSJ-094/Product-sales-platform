package com.lgy.product_sales_platform.dto;

import java.sql.Timestamp;
import java.util.List; // 주문 상세 상품 목록을 위해 추가

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrdDTO {
	private String ordId;
	private String ordMemId;
	private Timestamp ordDate;
	private int ordAmount;
	private int ordDfee;
	private int ordDiscount;
	private String ordStatus;
	private String orderMainImage; // 주문 대표 이미지 경로 추가
	
	// 주문 상세 상품 목록 (필요시)
	// private List<OrderItemDTO> orderItems;
}
