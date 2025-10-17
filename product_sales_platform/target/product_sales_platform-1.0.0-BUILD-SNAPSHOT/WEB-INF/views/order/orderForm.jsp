<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문서 작성</title>
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
        /* ... existing styles from mypage.jsp ... */
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

        /* Styles specific to orderForm to integrate with mypage theme */
        .order-form-container { /* New wrapper for order form content */
            max-width: 900px; /* Keep original max-width for content */
            margin: 0 auto; /* Center it within mypage-content-area */
            padding: 20px; /* Add some padding */
            background-color: #fff; /* Match mypage-content-area background */
            border-radius: 6px; /* Match mypage-content-area border-radius */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05); /* Match mypage-content-area shadow */
            border: 1px solid #e0e0e0; /* Match mypage-content-area border */
        }
        .order-section h3 { /* Use h3 for sub-sections to match mypage styling */
            font-size: 20px;
            border-bottom: 2px solid #b08d57;
            padding-bottom: 8px;
            margin-bottom: 20px;
            color: #2c2c2c;
            margin-top: 30px;
        }
        .order-section h3:first-of-type {
            margin-top: 0; /* No top margin for the first section */
        }
        .product-table th, .product-table td {
            border-bottom: 1px solid #eee; /* Lighter border */
            padding: 12px 15px; /* Match mypage table padding */
            text-align: center; /* Center align by default */
        }
        .product-table th {
            background-color: #4a4a4a; /* Match mypage table header */
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
        }
        .product-table td.product-info {
            text-align: left; /* Keep product info left aligned */
        }
        .product-table img {
            max-width: 60px; /* Match mypage product image size */
            max-height: 60px;
            border-radius: 4px;
            margin-right: 10px;
        }
        .summary {
            background-color: #f9f9f9; /* Lighter background */
            padding: 20px;
            border-radius: 5px;
            text-align: right;
            border: 1px solid #eee;
        }
        .summary-row {
            font-size: 16px;
            margin-bottom: 8px;
        }
        .summary-row.total {
            font-size: 22px;
            font-weight: 700;
            color: #b08d57; /* Theme color */
            border-top: 2px solid #b08d57; /* Theme color border */
            padding-top: 12px;
            margin-top: 12px;
        }
        .btn-primary {
            background-color: #2c2c2c; /* Match mypage submit button */
            color: white;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #b08d57; /* Match mypage submit button hover */
            color: #2c2c2c;
        }
        .text-center {
            margin-top: 40px; /* Add margin to separate from summary */
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
        <!-- No sidebar for order form, but keep the flex structure for mypage-content-area to work -->
        <div style="width: 200px; flex-shrink: 0;"></div> <!-- Placeholder for sidebar width -->
        <section class="mypage-content-area">
            <h2 id="content-title">주문서 작성</h2>

            <c:if test="${not empty error}">
                <p class="message error">${error}</p>
            </c:if>

            <div class="order-form-container">
                <div class="order-section">
                    <h3>주문 상품</h3>
                    <table class="product-table">
                        <thead>
                            <tr>
                                <th>상품 정보</th>
                                <th>수량</th>
                                <th>상품 금액</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td class="product-info">
                                        <img src="${pageContext.request.contextPath}/resources/images/${item.prodImage}" alt="${item.prodName}">
                                        <div>${item.prodName}</div>
                                    </td>
                                    <td>${item.cartQty}개</td>
                                    <td><fmt:formatNumber value="${item.prodPrice * item.cartQty}" pattern="#,###" />원</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="order-section">
                    <h3>최종 결제 금액</h3>
                    <div class="summary">
                        <div class="summary-row">
                            <span>총 상품 금액</span>
                            <span><fmt:formatNumber value="${totalAmount}" pattern="#,###" />원</span>
                        </div>
                        <div class="summary-row">
                            <span>배송비</span>
                            <span><fmt:formatNumber value="${shippingFee}" pattern="#,###" />원</span>
                        </div>
                        <div class="summary-row total">
                            <span>총 결제 금액</span>
                            <span><fmt:formatNumber value="${totalAmount + shippingFee}" pattern="#,###" />원</span>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <form action="${pageContext.request.contextPath}/order/create" method="post">
                        <button type="submit" class="btn btn-primary">결제하기</button>
                    </form>
                </div>
            </div>
        </section>
    </main>
</body>
</html>