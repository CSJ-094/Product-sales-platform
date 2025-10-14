package com.lgy.product_sales_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.product_sales_platform.dao.MemDAO;
import com.lgy.product_sales_platform.dto.MemDTO;

@Service
public class UserService {

    @Autowired
    private MemDAO userMapper;

    public MemDTO getUserById(String memberId) {
        return userMapper.getUserById(memberId);
    }
}
