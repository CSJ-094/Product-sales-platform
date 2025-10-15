package com.lgy.product_sales_platform.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class OrderController {
	
	@Autowired
	private SqlSession sqlSession;
	
	
}
