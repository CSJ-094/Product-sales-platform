package com.lgy.product_sales_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.product_sales_platform.dao.OrdDAO;
import com.lgy.product_sales_platform.dto.OrdDTO;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrdDAO orderMapper;

    public List<OrdDTO> getOrdersByMemberId(String memberId) {
        return orderMapper.getOrdersByMemberId(memberId);
    }
}
