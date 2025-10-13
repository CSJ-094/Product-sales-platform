package Product_sales_platform.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import Product_sales_platform.dao.MemDAO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class pscontroller {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/user_info")
	public String user_info(HttpServletRequest request, Model model) {
		log.info("@# user_info()");
		
		MemDAO dao = sqlSession.getMapper(MemDAO.class);
		dao.modify(request.getParameter("MEMBER_ID")
				, request.getParameter("MEMBER_PW")
				, request.getParameter("MEMBER_NAME")
				, request.getParameter("MEMBER_EMAIL")
				, request.getParameter("MEMBER_PHONE")
				, request.getParameter("MEMBER_ADDR")
				);
		
		return "redirect:userpage";
	}
}
