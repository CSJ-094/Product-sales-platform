<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    function daumZipCode() {
        new daum.Postcode(
            {
                oncomplete: function(data) {
                    var addr = '';
                    var extraAddr = '';

                    if (data.userSelectedType === 'R') {
                        addr = data.roadAddress;
                    } else {
                        addr = data.jibunAddress;
                    }

                    if (data.userSelectedType === 'R') {
                        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                            extraAddr += data.bname;
                        }
                        if (data.buildingName !== '' && data.apartment === 'Y') {
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        if (extraAddr !== '') {
                            extraAddr = ' (' + extraAddr + ')';
                        }
                    }

                    document.getElementById('zipcode').value = data.zonecode;
                    document.getElementById("MEMBER_ADDR_PRIMARY").value = addr + extraAddr;
                    document.getElementById("MEMBER_ADDR_DETAIL").focus();
                }
            }
        ).open();
    }
    </script>
    
    <style>
        /* ... existing styles ... */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Noto Sans KR', 'Montserrat', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            min-height: 100vh;
        }

        a {
            text-decoration: none;
            color: inherit;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #b08d57;
        }

        ul {
            list-style: none;
        }

        .main-header {
            background-color: #2c2c2c;
            border-bottom: none;
            padding: 15px 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding: 0 20px;
        }
        
        .header-top {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .logo a {
            font-family: 'Montserrat', sans-serif;
            font-size: 20px;
            font-weight: 800;
            color: #ffffff;
            letter-spacing: 1px;
        }

        .categories {
            width: 100%;
            border-top: 1px solid #555;
            padding: 8px 0;
            margin-bottom: 0;
        }

        .categories ul {
            display: flex;
            gap: 30px;
        }

        .categories a {
            font-size: 14px;
            font-weight: 500;
            padding: 5px 0;
            color: #ccc;
        }

        .categories a:hover {
            color: #b08d57;
            border-bottom: 2px solid #b08d57;
        }

        .mypage-body {
            max-width: 1200px;
            margin: 50px auto;
            display: flex;
            gap: 30px;
            padding: 0 20px;
        }

        .mypage-sidebar {
            flex-shrink: 0;
            width: 200px;
            background-color: #ffffff;
            padding: 10px 0;
            border-radius: 6px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            border: 1px solid #e0e0e0;
        }

        .sidebar-title {
            font-size: 18px;
            font-weight: 700;
            padding: 15px 20px;
            margin-bottom: 10px;
            color: #2c2c2c;
            border-bottom: 1px solid #eee;
        }

        .mypage-sidebar a {
            display: block;
            padding: 12px 20px;
            font-size: 15px;
            color: #555;
            transition: background-color 0.2s, color 0.2s;
        }

        .mypage-sidebar a:hover {
            background-color: #f0f0f0;
            color: #333;
        }

        .mypage-sidebar a.active {
            background-color: #f0f0f0;
            color: #b08d57;
            font-weight: 700;
            border-left: 4px solid #b08d57;
            padding-left: 16px;
        }

        .mypage-content-area {
            flex-grow: 1;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 6px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            border: 1px solid #e0e0e0;
        }

        .mypage-content-area h2, .mypage-content-area h3 {
            font-size: 26px;
            border-bottom: 3px solid #b08d57;
            padding-bottom: 10px;
            margin-bottom: 30px;
            color: #2c2c2c;
        }
        .mypage-content-area h3 {
            font-size: 20px;
            border-bottom-width: 2px;
            margin-top: 40px;
        }

        .content-panel {
            display: none;
        }

        .content-panel.active {
            display: block;
        }

        .info-form {
            max-width: 700px;
            margin-top: 20px;
            padding: 30px;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            background-color: #fcfcfc;
        }

        .form-group {
            margin-bottom: 20px;
        }
        
        .form-row {
            display: flex;
            align-items: center;
        }

        .form-group label {
            flex-shrink: 0;
            width: 120px;
            font-weight: 600;
            color: #333;
            margin-bottom: 0;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="tel"],
        .form-group input[type="password"],
        .form-group input[type="number"],
        .form-group textarea {
            flex-grow: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
            transition: border-color 0.3s;
            margin-top: 0;
            font-family: inherit;
        }
        
        .form-group input:focus,
        .form-group textarea:focus {
             border-color: #b08d57;
             outline: none;
        }

        #MEMBER_ID_VIEW {
            background-color: #f0f0f0;
            color: #777;
        }

        .address-group {
            margin-top: 20px;
        }
        .address-group .form-group {
            margin-bottom: 10px;
        }
        .address-zip-row {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-grow: 1;
        }
        
        .address-zip-row #zipcode {
            width: 100px;
            flex-grow: 0;
            background-color: #f0f0f0;
        }

        .address-search-btn {
            padding: 10px 15px;
            border: none;
            background-color: #6c757d;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            flex-shrink: 0;
            font-size: 15px;
            transition: background-color 0.3s;
        }

        .address-search-btn:hover {
            background-color: #5a6268;
        }

        #MEMBER_ADDR_PRIMARY {
            background-color: #f0f0f0;
            color: #777;
        }
        #MEMBER_ADDR_DETAIL {
            background-color: #ffffff;
            color: #333;
        }

        .button-group {
            text-align: center;
            margin-top: 40px;
        }

        .submit-btn, .reset-btn {
            padding: 10px 25px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            margin: 0 10px;
            transition: background-color 0.3s;
        }

        .submit-btn {
            background-color: #2c2c2c;
            color: white;
        }

        .submit-btn:hover {
            background-color: #b08d57;
            color: #2c2c2c;
        }

        .reset-btn {
            background-color: #ccc;
            color: #333;
            border: 1px solid #bbb;
        }

        .reset-btn:hover {
            background-color: #bbb;
        }
        
        .message {
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 1em;
            text-align: center;
        }
        .message.success {
            background-color: #e6f7e9;
            color: #1a7c36;
            border: 1px solid #a9d4b6;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background-color: #4a4a4a;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .no-items {
            color: #888;
            margin-top: 30px;
            text-align: center;
            font-size: 1.1em;
            padding: 20px;
            border: 1px dashed #ccc;
            border-radius: 8px;
            background-color: #fff;
        }
        .action-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 0.9em;
            transition: background-color 0.3s ease;
            margin-right: 5px; 
        }
        .action-btn:hover {
            background-color: #b08d57;
            color: #2c2c2c;
        }
        .remove-btn {
            background-color: #dc3545;
        }
        .remove-btn:hover {
            background-color: #c82333;
        }

        #order-history-content table td:last-child {
            white-space: nowrap;
        }

        #cart-content .no-items {
            text-align: center;
            padding: 30px;
            margin-top: 20px;
            font-size: 1.2em;
            color: #777;
            border: 1px dashed #ccc;
            border-radius: 4px;
            background-color: #fcfcfc;
        }

        #cart-content table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            font-size: 15px;
        }
        
        #cart-content th, #cart-content td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        
        #cart-content th {
            background-color: #4a4a4a;
            color: white;
            font-weight: 600;
            font-size: 0.95em;
        }
        
        #cart-content .quantity-input {
            width: 60px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            text-align: center;
            margin-right: 5px;
            font-size: 14px;
        }
        
        #cart-content .cart-action-btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        #cart-content .update-btn {
            background-color: #6c757d;
            color: white;
        }
        #cart-content .update-btn:hover {
            background-color: #5a6268;
        }

        #cart-content .remove-btn {
            background-color: #dc3545;
            color: white;
        }
        #cart-content .remove-btn:hover {
            background-color: #c82333;
        }

        #cart-content .total-price {
            text-align: right;
            margin-top: 30px;
            padding: 15px 20px;
            font-size: 1.5em;
            font-weight: 700;
            color: #2c2c2c;
            border-top: 2px solid #b08d57;
        }

        #cart-content .action-buttons {
            text-align: center;
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        #cart-content .action-buttons a {
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 4px;
            border: 1px solid #ccc;
            transition: background-color 0.3s;
        }
        
        #cart-content .order-btn {
            background-color: #b08d57 !important;
            color: #2c2c2c !important;
            border: 1px solid #b08d57 !important;
        }
        
        #cart-content .order-btn:hover {
            background-color: #a07d47 !important;
        }
        
        #cart-content .action-buttons a:not(.order-btn) {
            background-color: #f5f5f5;
            color: #444;
        }
        #cart-content .action-buttons a:not(.order-btn):hover {
            background-color: #e0e0e0;
        }

        /* Product Management Styles */
        #product-management-content .product-list-table img {
            max-width: 60px;
            max-height: 60px;
            border-radius: 4px;
        }
        #product-management-content .product-list-table td,
        #product-management-content .product-list-table th {
            vertical-align: middle;
            text-align: center;
        }
        #product-management-content .product-list-table th:nth-child(2),
        #product-management-content .product-list-table td:nth-child(2) {
            text-align: left;
        }

    </style>
</head>
<body>

    <header class="main-header">
        <div class="header-content">
            <div class="header-top">
                <div class="logo">
                    <a href='<c:url value="/mainpage"/>' title="메인 페이지로 이동">MY MODERN SHOP</a>
                </div>
            </div>

            <nav class="categories">
                <ul>
                    <li><a href="/category/mans">MANS</a></li>
                    <li><a href="/category/women">WOMEN</a></li>
                    <li><a href="/category/kids">KIDS</a></li>
                    <li><a href="/category/shoes">SHOES</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="mypage-body">
        
        <aside class="mypage-sidebar">
            <nav>
                <ul>
                    <li class="sidebar-title">MY PAGE</li>
                    <c:choose>
                        <c:when test="${sessionScope.memberId eq 'admin'}">
                            <li><a href="#member-management">회원 관리</a></li>
                            <li><a href="#product-management">상품 관리</a></li>
                            <li><a href="#notice-management">공지 관리</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="#member-info" class="active">회원 정보 수정</a></li>
                            <li><a href="#cart">장바구니</a></li>
                            <li><a href="#wishlist">찜목록 (Wishlist)</a></li>
                            <li><a href="#order-history">주문 내역</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </nav>
        </aside>

        <section class="mypage-content-area">
      
            <h2 id="content-title">회원 정보 수정</h2>
            
            <c:if test="${not empty message}">
                <p class="message success">${message}</p>
            </c:if>
            <c:if test="${not empty error}">
                <p class="message error">${error}</p>
            </c:if>

            <c:choose>
                <c:when test="${sessionScope.memberId eq 'admin'}">
                    <div id="member-management-content" class="content-panel active">
                        <h3>회원 관리 페이지</h3>
                        <p>여기에 회원 관리 기능을 구현합니다.</p>
                    </div>
                    <div id="product-management-content" class="content-panel">
                        <h3>등록된 상품 목록</h3>
                        <c:if test="${empty productList}">
                            <p class="no-items">등록된 상품이 없습니다.</p>
                        </c:if>
                        <c:if test="${not empty productList}">
                            <table class="product-list-table">
                                <thead>
                                    <tr>
                                        <th>이미지</th>
                                        <th>상품명</th>
                                        <th>가격</th>
                                        <th>재고</th>
                                        <th>등록일</th>
                                        <th>관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${productList}">
                                        <tr>
                                            <td><img src="<c:url value='${product.prodImage.split(",")[0]}'/>" alt="${product.prodName}"></td>
                                            <td>${product.prodName}</td>
                                            <td><fmt:formatNumber value="${product.prodPrice}" type="currency" currencySymbol="₩"/></td>
                                            <td>${product.prodStock}</td>
                                            <td><fmt:formatDate value="${product.prodReg}" pattern="yyyy-MM-dd"/></td>
                                            <td>
                                                <a href="#" class="action-btn">수정</a>
                                                <form action="<c:url value='/product/admin/delete'/>" method="post" style="display:inline;" onsubmit="return confirm('정말 이 상품을 삭제하시겠습니까?');">
                                                    <input type="hidden" name="prodId" value="${product.prodId}">
                                                    <button type="submit" class="action-btn remove-btn">삭제</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                    <div id="notice-management-content" class="content-panel">
                        <h3>공지 관리 페이지</h3>
                        <p>여기에 공지 관리 기능을 구현합니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div id="member-info-content" class="content-panel active">
                        <div class="member-info-panel">
                            <form action="user_info" method="post" class="info-form">
                                <div class="form-group">
                                    <div class="form-row">
                                        <label for="MEMBER_ID_VIEW">아이디</label>
                                        <input type="text" id="MEMBER_ID_VIEW" value="${memberInfo.memberId}" disabled>
                                    </div>
                                    <input type="hidden" name="MEMBER_ID" value="${memberInfo.memberId}">
                                </div>
                                <div class="form-group">
                                    <div class="form-row">
                                        <label for="MEMBER_PW">새 비밀번호</label>
                                        <input type="password" id="MEMBER_PW" name="MEMBER_PW" placeholder="새 비밀번호를 입력해주세요 (변경 시에만 입력)" > 
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-row">
                                        <label for="MEMBER_NAME">이름</label>
                                        <input type="text" id="MEMBER_NAME" name="MEMBER_NAME" value="${memberInfo.memberName}" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-row">
                                        <label for="MEMBER_EMAIL">이메일</label>
                                        <input type="email" id="MEMBER_EMAIL" name="MEMBER_EMAIL" value="${memberInfo.memberEmail}" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-row">
                                        <label for="MEMBER_PHONE">전화번호</label>
                                        <input type="tel" id="MEMBER_PHONE" name="MEMBER_PHONE" value="${memberInfo.memberPhone}" placeholder="예: 010-1234-5678">
                                    </div>
                                </div>
                                <div class="address-group">
                                    <div class="form-group">
                                        <div class="form-row">
                                            <label for="zipcode">우편번호</label>
                                            <div class="address-zip-row">
                                                <input type="text" id="zipcode" name="memberZipcode" value="${memberInfo.memberZipcode}" placeholder="우편번호" readonly>
                                                <button type="button" class="address-search-btn" onclick="daumZipCode()">주소 검색</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="form-row">
                                            <label for="MEMBER_ADDR_PRIMARY">기본 주소</label>
                                            <input type="text" id="MEMBER_ADDR_PRIMARY" name="memberAddr1" value="${memberInfo.memberAddr1}" placeholder="도로명 주소 (검색 결과)" readonly>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="form-row">
                                            <label for="MEMBER_ADDR_DETAIL">상세 주소</label>
                                            <input type="text" placeholder="상세 주소" name="memberAddr2" id="MEMBER_ADDR_DETAIL" value="${memberInfo.memberAddr2}">
                                        </div>
                                    </div>
                                </div>
                                <div class="button-group">
                                    <button type="submit" class="submit-btn">정보 수정</button>
                                    <button type="reset" class="reset-btn">취소</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div id="cart-content" class="content-panel">
                        <c:if test="${empty cartList}">
                            <p class="no-items">장바구니에 담긴 상품이 없습니다.</p>
                        </c:if>
                        <c:if test="${not empty cartList}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>상품명</th>
                                        <th>판매가</th>
                                        <th style="width: 150px;">수량</th>
                                        <th style="width: 150px;">총 금액</th>
                                        <th style="width: 80px;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cartItem" items="${cartList}">
                                        <c:set var="itemTotalPrice" value="${cartItem.prodPrice * cartItem.cartQty}" />
                                        <tr>
                                            <td style="text-align: left;">
                                                <a href="${pageContext.request.contextPath}/product/detail?prodId=${cartItem.prodId}">${cartItem.prodName}</a>
                                            </td>
                                            <td><fmt:formatNumber value="${cartItem.prodPrice}" type="currency" currencySymbol="₩"/></td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/mypage/cart/update" method="post" style="display:flex; align-items:center; justify-content:center;">
                                                    <input type="hidden" name="memberId" value="${memberId}">
                                                    <input type="hidden" name="cartId" value="${cartItem.cartId}">
                                                    <input type="number" name="cartQty" value="${cartItem.cartQty}" min="1" class="quantity-input">
                                                    <button type="submit" class="cart-action-btn update-btn">수정</button>
                                                </form>
                                            </td>
                                            <td><fmt:formatNumber value="${itemTotalPrice}" type="currency" currencySymbol="₩"/></td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/mypage/cart/remove" method="post" style="display:inline;">
                                                    <input type="hidden" name="memberId" value="${memberId}">
                                                    <input type="hidden" name="cartId" value="${cartItem.cartId}">
                                                    <button type="submit" class="cart-action-btn remove-btn">삭제</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="total-price">
                                총 장바구니 금액: <fmt:formatNumber value="${totalCartPrice}" type="currency" currencySymbol="₩"/>
                            </div>
                        </c:if>
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/">쇼핑 계속하기</a>
                            <c:if test="${not empty cartList}">
                                <a href="${pageContext.request.contextPath}/order/form" class="order-btn">주문하기</a>
                            </c:if>
                        </div>
                    </div>

                    <div id="wishlist-content" class="content-panel">
                        <c:if test="${empty wishlist}">
                            <p class="no-items">찜목록에 담긴 상품이 없습니다.</p>
                        </c:if>
                        <c:if test="${not empty wishlist}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>상품 ID</th>
                                        <th>상품명</th>
                                        <th>가격</th>
                                        <th>판매자</th>
                                        <th>재고</th>
                                        <th style="width: 100px;">삭제</th>
                                        <th style="width: 150px;">장바구니 이동</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${wishlist}">
                                        <tr>
                                            <td>${product.prodId}</td>
                                            <td>${product.prodName}</td>
                                            <td><fmt:formatNumber value="${product.prodPrice}" type="currency" currencySymbol="₩"/></td>
                                            <td>${product.prodSeller}</td>
                                            <td>${product.prodStock}</td>
                                            <td>
                                                <form action="/mypage/wishlist/remove" method="post" style="display:inline;">
                                                    <input type="hidden" name="memberId" value="${param.memberId}">
                                                    <input type="hidden" name="prodId" value="${product.prodId}">
                                                    <button type="submit" class="action-btn remove-btn">삭제</button>
                                                </form>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/mypage/cart/moveFromWishlist" method="post" style="display:inline;">
                                                    <input type="hidden" name="memberId" value="${param.memberId}">
                                                    <input type="hidden" name="prodId" value="${product.prodId}">
                                                    <input type="hidden" name="cartQty" value="1"> 
                                                    <button type="submit" class="action-btn">장바구니로 이동</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>

                    <div id="order-history-content" class="content-panel">
                        <c:if test="${empty orderList}">
                            <p class="no-items">주문 내역이 없습니다.</p>
                        </c:if>
                        <c:if test="${not empty orderList}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>주문번호</th>
                                        <th>주문일자</th>
                                        <th>총 구매금액</th>
                                        <th>할인 금액</th>
                                        <th>배송비</th>
                                        <th>주문 상태</th>
                                        <th style="width: 100px;">상세 보기</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orderList}">
                                        <tr>
                                            <td>${order.ordId}</td>
                                            <td><fmt:formatDate value="${order.ordDate}" pattern="yyyy-MM-dd"/></td>
                                            <td><fmt:formatNumber value="${order.ordAmount}" type="currency" currencySymbol="₩"/></td>
                                            <td><fmt:formatNumber value="${order.ordDiscount}" type="currency" currencySymbol="₩"/></td>
                                            <td><fmt:formatNumber value="${order.ordDfee}" type="currency" currencySymbol="₩"/></td>
                                            <td>${order.ordStatus}</td>
                                            <td>
                                                <a href="/order/detail?ordId=${order.ordId}" class="action-btn">상세</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
            
        </section>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const sidebarLinks = document.querySelectorAll('.mypage-sidebar a');
            const contentPanels = document.querySelectorAll('.content-panel');
            const mainTitle = document.querySelector('.mypage-content-area h2');

            const isAdmin = "${sessionScope.memberId}" === "admin";
            const defaultHash = isAdmin ? 'member-management' : 'member-info';

            const getHashId = () => window.location.hash.substring(1) || defaultHash;

            function activatePanel(targetId) {
                const panelId = targetId + '-content';
                sidebarLinks.forEach(link => {
                    const linkHash = link.getAttribute('href').substring(1);
                    if (linkHash === targetId) {
                        link.classList.add('active');
                        mainTitle.textContent = link.textContent;
                    } else {
                        link.classList.remove('active');
                    }
                });
                contentPanels.forEach(panel => {
                    if (panel.id === panelId) {
                        panel.classList.add('active');
                    } else {
                        panel.classList.remove('active');
                    }
                });
            }

            activatePanel(getHashId());

            sidebarLinks.forEach(link => {
                link.addEventListener('click', function(event) {
                    event.preventDefault();
                    const targetHash = this.getAttribute('href').substring(1);
                    activatePanel(targetHash);
                    window.history.pushState(null, null, this.href);
                });
            });

            window.addEventListener('popstate', function() {
                activatePanel(getHashId());
            });
        });
    </script>
</body>
</html>