<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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

        /* Styles specific to orderComplete to integrate with mypage theme */
        .order-complete-container { /* New wrapper for order complete content */
            max-width: 800px; /* Keep original max-width for content */
            margin: 0 auto; /* Center it within mypage-content-area */
            padding: 30px; /* Add some padding */
            background-color: #fff; /* Match mypage-content-area background */
            border-radius: 6px; /* Match mypage-content-area border-radius */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05); /* Match mypage-content-area shadow */
            border: 1px solid #e0e0e0; /* Match mypage-content-area border */
            text-align: center;
        }
        .icon-success {
            font-size: 60px;
            color: #28a745; /* Green for success */
            margin-bottom: 20px;
        }
        .order-complete-container h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 15px;
            color: #2c2c2c; /* Match mypage heading color */
        }
        .order-complete-container p {
            font-size: 16px;
            color: #555; /* Slightly darker than default #666 */
            margin-bottom: 30px;
        }
        .order-summary {
            text-align: left;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
            padding: 20px 0;
            margin-bottom: 40px;
            background-color: #f9f9f9; /* Light background for summary */
            border-radius: 5px;
            padding: 15px 20px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            font-size: 15px;
            color: #333;
        }
        .summary-item span:first-child { font-weight: 600; }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }
        .btn {
            display: inline-block;
            padding: 12px 30px;
            border: none; /* Remove default border */
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600; /* Match mypage buttons */
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .btn-primary {
            background-color: #b08d57; /* Theme color */
            color: #2c2c2c; /* Dark text for theme button */
        }
        .btn-primary:hover {
            background-color: #a07d47; /* Darker theme color on hover */
        }
        .btn-secondary {
            background-color: #2c2c2c; /* Dark background for secondary */
            color: white;
        }
        .btn-secondary:hover {
            background-color: #4a4a4a; /* Lighter dark on hover */
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
        <!-- No sidebar for order complete, but keep the flex structure for mypage-content-area to work -->
        <div style="width: 200px; flex-shrink: 0;"></div> <!-- Placeholder for sidebar width -->
        <section class="mypage-content-area">
            <h2 id="content-title">주문 완료</h2>

            <div class="order-complete-container">
                <div class="icon-success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h1>주문이 성공적으로 완료되었습니다.</h1>
                <p>저희 플랫폼을 이용해주셔서 감사합니다.</p>

                <div class="order-summary">
                    <div class="summary-item">
                        <span>주문 번호</span>
                        <span>${order.ordId}</span>
                    </div>
                    <div class="summary-item">
                        <span>주문 일자</span>
                        <span><fmt:formatDate value="${order.ordDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                    </div>
                    <div class="summary-item">
                        <span>총 결제 금액</span>
                        <span><fmt:formatNumber value="${order.ordAmount + order.ordDfee - order.ordDiscount}" pattern="#,###" />원</span>
                    </div>
                </div>

                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">쇼핑 계속하기</a>
                    <a href="${pageContext.request.contextPath}/mypage#order-history" class="btn btn-primary">주문 내역 확인</a>
                </div>
            </div>
        </section>
    </main>
</body>
</html>