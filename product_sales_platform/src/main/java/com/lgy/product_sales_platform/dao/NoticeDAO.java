package com.lgy.product_sales_platform.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lgy.product_sales_platform.dto.NoticeDTO;


public interface NoticeDAO {
	List<NoticeDTO> list(); 
	void write(NoticeDTO dto); 
	NoticeDTO contentView(@Param("notNo") int notNo);
	void modify(NoticeDTO dto);
	void delete(@Param("notNo") int notNo);
}
