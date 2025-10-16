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
import com.lgy.product_sales_platform.service.CartService; // CartService 임포트 추가
import com.lgy.product_sales_platform.service.ProductService; // ProductService 임포트 추가
import com.lgy.product_sales_platform.dto.CartDTO; // CartDTO 임포트 추가

import lombok.extern.slf4j.Slf4j;
import java.util.List; // List 임포트

@Controller
@Slf4j
public class pscontroller {

	@Autowired
	private SqlSession sqlSession;
    
    @Autowired
    private WishlistService wishlistService;
    
    @Autowired
    private OrderService orderService;

    @Autowired
    private MemDAO memDAO; 

    @Autowired
    private CartService cartService;

    @Autowired // ProductService 주입
    private ProductService productService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login_view() {
	    log.info("@# login_view() - 로그인 페이지 요청");
	    return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login_process(@RequestParam("username") String username,
	                            @RequestParam("password") String password,
	                            @RequestParam("userType") String userType,
	                            HttpSession session,
	                            RedirectAttributes redirectAttributes) {
	    log.info("@# login_process() - 로그인 시도: ID={}, UserType={}", username, userType);

	    MemDTO member = memDAO.getUserById(username);

	    if (member != null && member.getMemberPw().equals(password)) {
	        session.setAttribute("memberId", member.getMemberId()); 
	        session.setAttribute("sessionName", member.getMemberName());
	        session.setAttribute("sessionUserType", userType);
	        log.info("@# 로그인 성공: ID={}, UserType={}", username, userType);
	        return "redirect:/mainpage";
	    } else {
	        redirectAttributes.addFlashAttribute("loginError", "아이디 또는 비밀번호가 일치하지 않습니다.");
	        log.warn("@# 로그인 실패: ID={}", username);
	        return "redirect:/login";
	    }
	}

	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage_view(HttpSession session, Model model) {
	    log.info("@# mypage_view() - 정보 조회 및 리스트 로드");

	    String memberId = (String) session.getAttribute("memberId"); 

	    if (memberId == null) {
	        log.warn("@# mypage_view() - 세션 ID 없음. 로그인 페이지로 리다이렉트.");
	        return "redirect:/login";
	    }
	    
	    // 관리자일 경우 상품 목록 조회
	    if ("admin".equals(memberId)) {
	        List<ProdDTO> productList = productService.getAllProducts();
	        model.addAttribute("productList", productList);
	        log.info("@# mypage_view() - Admin user, loading {} products.", productList.size());
	    } else {
	        // 일반 사용자 정보 조회
	        MemDAO memDao = sqlSession.getMapper(MemDAO.class);
	        MemDTO memberInfo = memDao.getMemberInfo(memberId);
	        if (memberInfo != null) {
	            model.addAttribute("memberInfo", memberInfo);
	        } else {
	            log.error("@# 회원 정보 조회 실패: ID={}", memberId);
	        }
	        
	        List<ProdDTO> wishlist = wishlistService.getWishlistByMemberId(memberId);
	        model.addAttribute("wishlist", wishlist);
	        
	        List<OrdDTO> orderList = orderService.getOrdersByMemberId(memberId);
	        model.addAttribute("orderList", orderList);

	        List<CartDTO> cartList = cartService.getCartListByMemberId(memberId);
	        model.addAttribute("cartList", cartList);
	        model.addAttribute("totalCartPrice", cartService.getTotalCartPrice(memberId));
	        log.info("@# mypage_view() - CartList size: {}", cartList != null ? cartList.size() : 0);
	    }

	    return "mypage";
	}
	
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
