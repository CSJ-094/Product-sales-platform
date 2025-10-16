package com.lgy.product_sales_platform.dao;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import com.lgy.product_sales_platform.dto.MemDTO;

@Mapper
public interface MemDAO {
	public MemDTO getMemberInfo(String memberId);
	void modify(MemDTO member);
	MemDTO getUserById(String memberId);
	List<MemDTO> getUserList();       // 전체 회원 조회
    MemDTO getUser(String memberId);
}
