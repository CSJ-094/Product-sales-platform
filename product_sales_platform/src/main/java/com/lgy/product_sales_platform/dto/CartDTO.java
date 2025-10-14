package com.lgy.product_sales_platform.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartDTO {
    private int cartId;
    
    private String memberId;
    private int prodId;
    
    private int cartQty;
    private Timestamp regDate;

}