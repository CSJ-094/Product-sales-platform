package com.lgy.product_sales_platform.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrdDetailDTO {
	private String ordId;
	private int prodId;
}
