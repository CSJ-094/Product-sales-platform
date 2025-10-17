package com.lgy.product_sales_platform.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.lgy.product_sales_platform.dto.ImageDTO;

@Mapper
public interface ImageDAO {
    int insertImage(ImageDTO dto);
    String getMainImagePathByProdId(@Param("prodId") Integer prodId); // 대표 이미지 경로 조회 메서드 추가
}