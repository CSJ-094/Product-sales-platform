package com.lgy.product_sales_platform.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProdDTO {
	private int prodId;
	private String prodSeller;
	private String prodName;
	private int prodPrice;
	private int prodStock;
	private String prodDesc;
	private String prodCode;
	private Timestamp prodReg;
	private Timestamp prodUpd;
}
