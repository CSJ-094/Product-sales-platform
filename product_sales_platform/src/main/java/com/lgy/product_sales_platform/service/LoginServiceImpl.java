package com.lgy.product_sales_platform.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.product_sales_platform.dao.LoginDAO;
import com.lgy.product_sales_platform.dto.LoginDTO;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginDAO loginDAO;

	@Override
	public LoginDTO loginYn(LoginDTO loginDTO) {
		log.info("@# loginYn(LoginDTO)");
		return loginDAO.loginYn(loginDTO);
	}

	@Override
	public void write(LoginDTO loginDTO) {
		log.info("@# write(LoginDTO)");
		// DAO 호출 시 LoginDTO를 그대로 전달
		loginDAO.write(loginDTO);
	}

	@Override
	public ArrayList<LoginDTO> idCheck(LoginDTO loginDTO) {
		log.info("@# idCheck(LoginDTO)");
		return loginDAO.idCheck(loginDTO);
	}

	@Override
	public ArrayList<LoginDTO> emailCheck(LoginDTO loginDTO) {
		log.info("@# emailCheck(LoginDTO)");
		return loginDAO.emailCheck(loginDTO);
	}
}
