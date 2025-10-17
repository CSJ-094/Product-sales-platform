package com.lgy.product_sales_platform.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * PRODUCT_DB 테이블과 매핑되는 DTO.
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProdDTO {
	private Long prodId;
	private String prodSeller;
	private String prodName;
	private int prodPrice;
	private int prodStock;
	private String prodDesc;
	private String prodCode;
	private String prodImage; // prodImage 필드 추가
	private Timestamp prodReg;
	private Timestamp prodUpd;
}