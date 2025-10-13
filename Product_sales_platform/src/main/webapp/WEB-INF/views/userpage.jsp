<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="styles.css"> 
</head>
<body>

    <%
        // URL 파라미터에서 현재 페이지를 읽어옵니다.
        // page 파라미터가 없으면 기본값으로 "order" (주문 내역)을 설정합니다.
        String currentPage = request.getParameter("page");
        if (currentPage == null || currentPage.isEmpty()) {
            currentPage = "order";
        }
    %>

    <header class="main-header">
        <div class="header-content">
            <div class="logo">
                <a href="/main" title="mainpage">로고</a>
            </div>

            <nav class="categories">
                <ul>
                    <li><a href="/category/men">남성</a></li>
                    <li><a href="/category/women">여성</a></li>
                    <li><a href="/category/sportswear">스포츠웨어</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="mypage-body">
        
        <aside class="mypage-sidebar">
            <nav>
                <ul>
                    <li class="sidebar-title">마이페이지</li>
                    
                    <li><a href="mypage.jsp?page=info" class="<%= "info".equals(currentPage) ? "active" : "" %>">회원 정보</a></li>
                    <li><a href="mypage.jsp?page=wishlist" class="<%= "wishlist".equals(currentPage) ? "active" : "" %>">찜목록</a></li>
                    <li><a href="mypage.jsp?page=order" class="<%= "order".equals(currentPage) ? "active" : "" %>">주문 내역</a></li>
                </ul>
            </nav>
        </aside>

        <section class="mypage-content-area">
            
            <%
                // JSP include 액션을 사용하여 현재 페이지에 맞는 파일을 동적으로 포함합니다.
                // 이 파일들은 별도로 생성해야 합니다. (예: order.jsp, info.jsp, wishlist.jsp)

                String contentPage = "";
                String title = "";

                if ("info".equals(currentPage)) {
                    contentPage = "mypage_info.jsp";
                    title = "회원 정보";
                } else if ("wishlist".equals(currentPage)) {
                    contentPage = "mypage_wishlist.jsp";
                    title = "찜목록";
                } else { // 기본값: 주문 내역
                    contentPage = "mypage_order.jsp";
                    title = "주문 내역";
                }
            %>
            
            <h2><%= title %></h2> 
            
            <jsp:include page="<%= contentPage %>" flush="true" />

        </section>
    </main>

</body>
</html>