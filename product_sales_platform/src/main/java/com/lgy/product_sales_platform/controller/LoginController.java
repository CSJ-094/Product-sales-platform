package com.lgy.product_sales_platform.controller;

import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lgy.product_sales_platform.dto.LoginDTO;
import com.lgy.product_sales_platform.service.LoginService;

import lombok.extern.slf4j.Slf4j;
import javax.servlet.http.HttpSession;

@Controller
@Slf4j
public class LoginController {
	
//	servlet-context 에 있는 sqlSession 객체 연결
//	@Autowired
//	private SqlSession sqlSession;
	@Autowired
	private LoginService service;

//	로그인 화면 이동
	@RequestMapping("/login")
	public String login() {
		log.info("@# login()");

		return "login";
	}

//	로그인화면->로그인 여부 판단
	@RequestMapping(value = "/login_yn", method = RequestMethod.POST)
	public String login_yn(LoginDTO loginDTO, HttpSession session, Model model) {
	    log.info("@# login_yn()");
	    
	    LoginDTO resultDTO = service.loginYn(loginDTO);

	    if (resultDTO != null) { // ID가 DB에 존재하는지 확인 (null 체크)
	        
	        // ID가 존재하면 비밀번호 비교
	        if (resultDTO.getMemberPw().equals(loginDTO.getMemberPw())) {
	            
	            // 비밀번호 일치: 로그인 성공
	            session.setAttribute("memberId", resultDTO.getMemberId());
	            session.setAttribute("memberName", resultDTO.getMemberName()); 
	            log.info("@# 로그인 성공");
	            log.info("@# MemberName: " + resultDTO.getMemberName());
	            
	            return "redirect:/"; // 성공 시 메인 페이지로 리다이렉트
	        } else {
	            // 비밀번호 불일치
	            model.addAttribute("loginResult", "비밀번호가 일치하지 않습니다.");
	            log.info("@# 비밀번호 불일치");
	            return "login"; 
	        }
	    } else {
	        // ID 없음 (resultDTO == null)
	        model.addAttribute("loginResult", "아이디가 존재하지 않습니다.");
	        log.info("@# 아이디 없음");
	        return "login";
	    }
	}

//	등록 화면 이동
	@RequestMapping("/register")
	public String register() {
		log.info("@# register()");

		return "register";
	}

	@RequestMapping("/registerOk")
	public String registerOk(LoginDTO loginDTO) {
		log.info("@# registerOk()");

		service.write(loginDTO);

		return "login";
	}

	@RequestMapping("/idCheck")
	@ResponseBody
	public Boolean idCheck(LoginDTO loginDTO) {
		System.out.println("아이디 인증 요청이 들어옴!");
		System.out.println("아이디 : " + loginDTO.getMemberId());
		Boolean result = false;

		ArrayList<LoginDTO> dtos = service.idCheck(loginDTO);
		if (!dtos.isEmpty()) {
			if (loginDTO.getMemberId().equals(dtos.get(0).getMemberId())) {
				result = false;
				return result;
			} else {
				result = true;
				return result;
			}
		}else {
			result = true;
			return result;
		}
	}

	@RequestMapping("/emailCheck")
	@ResponseBody
	public Boolean emailCheck(LoginDTO loginDTO) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 : " + loginDTO.getMemberEmail());
		Boolean result = false;

		ArrayList<LoginDTO> dtos = service.emailCheck(loginDTO);

		if (!dtos.isEmpty()) {
			if (loginDTO.getMemberEmail().equals(dtos.get(0).getMemberEmail())) {
				result = false;
				return result;
			} else {
				result = true;
				return result;
			}
		} else {
			result = true;
			return result;
		}
	}
}
