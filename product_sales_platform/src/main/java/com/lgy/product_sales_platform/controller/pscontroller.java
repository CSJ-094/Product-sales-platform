package com.lgy.product_sales_platform.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lgy.product_sales_platform.dao.MemDAO;
import com.lgy.product_sales_platform.dto.MemDTO; 
import com.lgy.product_sales_platform.dto.ProdDTO; // Wishlist 조회를 위한 DTO 추가
import com.lgy.product_sales_platform.dto.OrdDTO; // OrderList 조회를 위한 DTO 추가
import com.lgy.product_sales_platform.service.WishlistService; // WishlistService 임포트
import com.lgy.product_sales_platform.service.OrderService; // OrderService 임포트

import lombok.extern.slf4j.Slf4j;
import java.util.List; // List 임포트

@Controller
@Slf4j
public class pscontroller {

	@Autowired
	private SqlSession sqlSession;
    
    // ⭐️ 추가: WishlistService와 OrderService 의존성 주입
    @Autowired
    private WishlistService wishlistService;
    
    @Autowired
    private OrderService orderService;
	
	// 마이페이지 뷰 (회원 정보, 찜목록, 주문 내역 조회)
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage_view(HttpSession session, Model model) {
	    log.info("@# mypage_view() - 정보 조회 및 리스트 로드");
	    
	    String testId = "testuser01";
	    session.setAttribute("sessionID", testId);
	    
	    String memberId = (String) session.getAttribute("sessionID");
	    
	    // 1. 회원 정보 조회
	    MemDAO memDao = sqlSession.getMapper(MemDAO.class);
	    MemDTO memberInfo = memDao.getMemberInfo(memberId);
	    
	    if (memberInfo != null) {
	        model.addAttribute("member", memberInfo);
	    } else {
	        log.error("@# 회원 정보 조회 실패: ID={}", memberId);
	    }
	    
	    // 2. ⭐️ 찜목록 조회 및 Model에 추가 ⭐️
        List<ProdDTO> wishlist = wishlistService.getWishlistByMemberId(memberId);
        model.addAttribute("wishlist", wishlist);
        
	    // 3. ⭐️ 주문 내역 조회 및 Model에 추가 ⭐️
        List<OrdDTO> orderList = orderService.getOrdersByMemberId(memberId);
        model.addAttribute("orderList", orderList);

	    return "mypage";
	}
	
	// ... (mypage_update 메소드는 생략, 기존과 동일)
    
    @RequestMapping(value = "/user_info", method = RequestMethod.POST)
	public String mypage_update(HttpServletRequest request, Model model) {
	    log.info("@# mypage_update() - 정보 수정 요청");
	    
	    MemDTO member = new MemDTO();
	    member.setMemberId(request.getParameter("MEMBER_ID"));
	    member.setMemberPw(request.getParameter("MEMBER_PW"));
	    member.setMemberName(request.getParameter("MEMBER_NAME"));
	    member.setMemberEmail(request.getParameter("MEMBER_EMAIL"));
	    member.setMemberPhone(request.getParameter("MEMBER_PHONE"));
	    member.setMemberAddr(request.getParameter("MEMBER_ADDR"));

	    MemDAO dao = sqlSession.getMapper(MemDAO.class);
	    
	    dao.modify(member);
	    
	    return "redirect:mypage";
	}
}