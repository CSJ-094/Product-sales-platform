package com.lgy.product_sales_platform.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lgy.product_sales_platform.dto.ProdDTO;

@Mapper
public interface ProdDAO {
	List<ProdDTO> getProductList();         // 전체 목록
    ProdDTO getProduct(Long prodId);        // 상세
    int insertProduct(ProdDTO product);     // 등록
    int updateProduct(ProdDTO product);     // 수정
    int deleteProduct(@Param("prodId") long prodId); // 삭제
	ProdDTO getProductById(int prodId);
}
