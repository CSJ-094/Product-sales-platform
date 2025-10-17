<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="main-header">
<div class="header-top">
	
	<div class="logo">
		<a href="${pageContext.request.contextPath}/mainpage">MY MODERN SHOP</a>
	</div>
	
	<div class="user-auth">
	 <c:choose>
			<c:when test="${not empty sessionScope.memberId}">
				<span class="auth-welcome">환영합니다, ${sessionScope.memberName}님!</span>
				<a href='<c:url value="/mypage"/>' class="auth-btn">마이페이지</a> 
				<a href='<c:url value="/mypage#cart"/>' class="auth-btn cart-btn">장바구니</a>
				<a href='<c:url value="/logout"/>' class="auth-btn">로그아웃</a>
			</c:when>
			<c:when test="${not empty sessionScope.sellerId}">
				<span class="auth-welcome">환영합니다, ${not empty sessionScope.sellerName ? sessionScope.sellerName : sessionScope.sellerId} 판매자님!</span>
				<a href='<c:url value="/seller/mypage"/>' class="auth-btn">판매자 마이페이지</a>
				<a href='<c:url value="/logout"/>' class="auth-btn">로그아웃</a>
			</c:when>
			<c:otherwise>
				<a href='<c:url value="/login"/>' class="auth-btn">로그인/회원가입</a>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</header>