package com.lgy.product_sales_platform.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam; // RequestParam 추가 (복사본 기능)
import org.springframework.web.servlet.mvc.support.RedirectAttributes; // RedirectAttributes 추가 (복사본 기능)

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
    
    // ⭐️ 의존성 주입: WishlistService, OrderService (원본), MemDAO (복사본 추가)
    @Autowired
    private WishlistService wishlistService;
    
    @Autowired
    private OrderService orderService;

    @Autowired // MemDAO 주입 (복사본에서 추가된 로그인 기능을 위해 필요)
    private MemDAO memDAO; 

	// ⭐️ 새 기능: 로그인 페이지 뷰 (복사본에서 가져옴)
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login_view() {
	    log.info("@# login_view() - 로그인 페이지 요청");
	    return "login";
	}

    // ⭐️ 새 기능: 로그인 처리 (복사본에서 가져옴)
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login_process(@RequestParam("username") String username,
	                            @RequestParam("password") String password,
	                            @RequestParam("userType") String userType,
	                            HttpSession session,
	                            RedirectAttributes redirectAttributes) {
	    log.info("@# login_process() - 로그인 시도: ID={}, UserType={}", username, userType);

	    MemDTO member = memDAO.getUserById(username);

	    if (member != null && member.getMemberPw().equals(password)) {
	        // ⭐️ 수정: 세션 키를 'sessionID'에서 'memberId'로 통일 (혹은 'sessionID' 유지)
	        // 여기서는 'memberId'로 통일하는 것이 일반적입니다.
	        session.setAttribute("memberId", member.getMemberId()); 
	        session.setAttribute("sessionName", member.getMemberName());
	        session.setAttribute("sessionUserType", userType);
	        log.info("@# 로그인 성공: ID={}, UserType={}", username, userType);
	        return "redirect:/mypage";
	    } else {
	        // ... (로그인 실패 처리 생략)
	        redirectAttributes.addFlashAttribute("loginError", "아이디 또는 비밀번호가 일치하지 않습니다.");
	        log.warn("@# 로그인 실패: ID={}", username);
	        return "redirect:/login";
	    }
	}

	// 마이페이지 뷰 (회원 정보, 찜목록, 주문 내역 조회)
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage_view(HttpSession session, Model model) {
	    log.info("@# mypage_view() - 정보 조회 및 리스트 로드");

	    // ⭐️ 수정: 로그인 성공 시 저장한 'memberId' 키를 사용하거나, 'sessionID'를 사용하도록 변경
	    // 여기서는 'memberId'로 통일된 키를 사용한다고 가정합니다.
	    String memberId = (String) session.getAttribute("memberId"); 

	    // 로그인 체크
	    if (memberId == null) {
	        log.warn("@# mypage_view() - 세션 ID 없음. 로그인 페이지로 리다이렉트.");
	        return "redirect:/login";
	    }
	    
	    // 1. 회원 정보 조회
	    MemDAO memDao = sqlSession.getMapper(MemDAO.class);
	    MemDTO memberInfo = memDao.getMemberInfo(memberId);
	        
	    
	    if (memberInfo != null) {
	        model.addAttribute("memberInfo", memberInfo);
	    } else {
	        log.error("@# 회원 정보 조회 실패: ID={}", memberId);
	    }
	    
	    // 찜목록 조회 및 Model에 추가 (원본/복사본 동일)
        List<ProdDTO> wishlist = wishlistService.getWishlistByMemberId(memberId);
        model.addAttribute("wishlist", wishlist);
        
	    // 주문 내역 조회 및 Model에 추가 (원본/복사본 동일)
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
	    member.setMemberZipcode(request.getParameter("MEMBER_ZIPCODE"));
	    member.setMemberAddr1(request.getParameter("MEMBER_ADDR1"));
	    member.setMemberAddr2(request.getParameter("MEMBER_ADDR2"));

	    MemDAO dao = sqlSession.getMapper(MemDAO.class);
	    
	    dao.modify(member);
	    
	    return "redirect:mypage";
	}
}
