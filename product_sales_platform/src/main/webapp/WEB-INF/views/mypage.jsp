<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    
    <style>
        /* 기본 스타일 초기화 및 설정 */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Malgun Gothic', sans-serif;
            background-color: #f4f5f7;
            color: #333;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        ul {
            list-style: none;
        }

        /* 1. 헤더 스타일 */
        .main-header {
            background-color: #ffffff;
            border-bottom: 1px solid #e0e0e0;
            padding: 15px 0 0;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding: 0 20px;
        }

        .logo {
            margin-bottom: 15px;
            padding-bottom: 5px;
        }

        .logo a {
            font-size: 26px;
            font-weight: 700;
            color: #007bff;
        }

        .categories {
            width: 100%;
            border-top: 1px solid #eee;
            padding: 10px 0;
            margin-bottom: 10px;
        }

        .categories ul {
            display: flex;
            gap: 30px;
        }

        .categories a {
            font-size: 15px;
            font-weight: 500;
            padding: 5px 0;
        }

        .categories a:hover {
            color: #007bff;
            border-bottom: 2px solid #007bff;
        }

        /* 2. 바디 (마이페이지 메인 영역) 스타일 */
        .mypage-body {
            max-width: 1200px;
            margin: 30px auto;
            display: flex;
            gap: 20px;
            padding: 0 20px;
        }

        /* 왼쪽 사이드바 스타일 */
        .mypage-sidebar {
            flex-shrink: 0;
            width: 180px;
            background-color: #ffffff;
            padding: 20px 0;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .sidebar-title {
            font-size: 18px;
            font-weight: 700;
            padding: 10px 20px;
            margin-bottom: 15px;
            color: #333;
        }

        .mypage-sidebar a {
            display: block;
            padding: 12px 20px;
            font-size: 15px;
            transition: background-color 0.2s, color 0.2s;
        }

        .mypage-sidebar a:hover {
            background-color: #f0f0f0;
        }

        /* 현재 선택된 메뉴 강조 */
        .mypage-sidebar a.active {
            background-color: #007bff;
            color: white;
            font-weight: 600;
        }

        /* 오른쪽 콘텐츠 영역 스타일 */
        .mypage-content-area {
            flex-grow: 1;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .mypage-content-area h2 {
            font-size: 24px;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 30px;
            color: #333;
        }

        /* **숨김 처리** (다른 콘텐츠를 숨기기 위해 사용) */
        .content-panel {
            display: none;
        }

        /* **활성화된 콘텐츠** */
        .content-panel.active {
            display: block;
        }


        /* --- 회원 정보 폼 전용 스타일 --- */
        .info-form {
            max-width: 600px;
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .form-group {
            margin-bottom: 20px;
            padding-bottom: 5px;
            border-bottom: 1px solid #eeeeee;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #555;
        }

        /* 기본 입력 필드 스타일 */
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="tel"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s;
            margin-top: 5px;
        }

        /* 수정 불가능한 아이디 필드 스타일 */
        #MEMBER_ID_VIEW {
            background-color: #eee;
            color: #777;
        }

        /* --- 주소 그룹 전용 스타일 (추가됨) --- */
        .address-group input {
            margin-bottom: 10px;
        }

        .address-zip-row {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
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
            transition: background-color 0.3s;
        }

        .address-search-btn:hover {
            background-color: #5a6268;
        }

        #zipcode, #MEMBER_ADDR_PRIMARY {
            background-color: #eee;
            color: #777;
        }


        .button-group {
            text-align: center;
            margin-top: 30px;
        }

        .submit-btn, .reset-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            margin: 0 10px;
            transition: background-color 0.3s;
        }

        .submit-btn {
            background-color: #007bff;
            color: white;
        }

        .submit-btn:hover {
            background-color: #0056b3;
        }

        .reset-btn {
            background-color: #ccc;
            color: #333;
        }

        .reset-btn:hover {
            background-color: #bbb;
        }
        
        
        /* ⭐️ Wishlist Table & Button Styles ⭐️ */
        .message {
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 1em;
            text-align: center;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
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
            background-color: #6c757d; /* 회색 */
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
            margin-right: 5px; /* 버튼 간 간격 */
        }
        .action-btn:hover {
            background-color: #5a6268;
        }
        .remove-btn {
            background-color: #dc3545; /* 삭제 버튼은 빨간색 유지 */
        }
        .remove-btn:hover {
            background-color: #c82333;
        }
        /* ⭐️ End of Wishlist Styles ⭐️ */
    </style>
</head>
<body>

    <header class="main-header">
        <div class="header-content">
            <div class="logo">
                <a href='<c:url value="/mainpage"/>' title="메인 페이지로 이동">상점 로고</a>
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
                    <li><a href="#member-info" class="active">회원 정보</a></li>
                    <li><a href="#wishlist">찜목록</a></li>
                    <li><a href="#order-history">주문 내역</a></li>
                </ul>
            </nav>
        </aside>

        <section class="mypage-content-area">
            
            <h2 id="content-title">회원 정보</h2>
            
            <div id="member-info-content" class="content-panel active">
                <div class="member-info-panel">
                    <form action="user_info" method="post" class="info-form">
                        
                        <div class="form-group">
                            <label for="MEMBER_ID_VIEW">아이디</label>
                            <input type="text" id="MEMBER_ID_VIEW" value="${memberInfo.memberId}" disabled>
                            <input type="hidden" name="MEMBER_ID" value="${memberInfo.memberId}">
                        </div>

                        <div class="form-group">
                            <label for="MEMBER_PW">새 비밀번호</label>
                            <input type="password" id="MEMBER_PW" name="MEMBER_PW" placeholder="새 비밀번호를 입력해주세요" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="MEMBER_NAME">이름</label>
                            <input type="text" id="MEMBER_NAME" name="MEMBER_NAME" value="${memberInfo.memberName}" required>
                        </div>

                        <div class="form-group">
                            <label for="MEMBER_EMAIL">이메일</label>
                            <input type="email" id="MEMBER_EMAIL" name="MEMBER_EMAIL" value="${memberInfo.memberEmail}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="MEMBER_PHONE">전화번호</label>
                            <input type="tel" id="MEMBER_PHONE" name="MEMBER_PHONE" value="${memberInfo.memberPhone}" placeholder="예: 010-1234-5678">
                        </div>

                        <div class="form-group address-group">
                            <label>주소</label>
                            
                            <div class="address-zip-row">
                                <input type="text" id="zipcode" value="00000" placeholder="우편번호" style="width: 150px;" disabled>
                                <button type="button" class="address-search-btn">주소 검색</button>
                            </div>
                            
                            <input type="text" id="MEMBER_ADDR" name="MEMBER_ADDR" value="${memberInfo.memberAddr}" placeholder="주소 (직접 입력 또는 주소 검색 결과)">
                        </div>
                        
                        <div class="button-group">
                            <button type="submit" class="submit-btn">정보 수정</button>
                            <button type="reset" class="reset-btn">취소</button>
                        </div>
                    </form>
                </div>
            </div>

            <div id="wishlist-content" class="content-panel">
                
                <c:if test="${not empty message}">
                    <p class="message success">${message}</p>
                </c:if>

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
                                        <form action="/cart/moveFromWishlist" method="post" style="display:inline;">
                                            <input type="hidden" name="memberId" value="${param.memberId}">
                                            <input type="hidden" name="prodId" value="${product.prodId}">
                                            <input type="hidden" name="cartQty" value="1"> <button type="submit" class="action-btn">장바구니로 이동</button>
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
                        <%-- 날짜 포맷팅 --%>
                        <td><fmt:formatDate value="${order.ordDate}" pattern="yyyy-MM-dd"/></td>
                        <%-- 금액 포맷팅 (￦) --%>
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
            
        </section>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const sidebarLinks = document.querySelectorAll('.mypage-sidebar a');
            const contentPanels = document.querySelectorAll('.content-panel');
            const mainTitle = document.querySelector('.mypage-content-area h2');

            // URL Hash에서 ID를 추출 (예: #wishlist -> wishlist)
            // 없으면 'member-info'를 기본값으로 설정
            const getHashId = () => window.location.hash.substring(1) || 'member-info';

            function activatePanel(targetId) {
                const panelId = targetId + '-content';

                // 1. 사이드바 링크 활성화
                sidebarLinks.forEach(link => {
                    const linkHash = link.getAttribute('href').substring(1);
                    if (linkHash === targetId) {
                        link.classList.add('active');
                        // 2. 메인 타이틀 업데이트
                        mainTitle.textContent = link.textContent;
                    } else {
                        link.classList.remove('active');
                    }
                });

                // 3. 콘텐츠 패널 표시/숨김
                contentPanels.forEach(panel => {
                    if (panel.id === panelId) {
                        panel.classList.add('active');
                    } else {
                        panel.classList.remove('active');
                    }
                });
            }

            // 초기 로드 시 실행 (URL 해시에 따라 페이지 표시)
            activatePanel(getHashId());

            // 사이드바 링크 클릭 이벤트
            sidebarLinks.forEach(link => {
                link.addEventListener('click', function(event) {
                    event.preventDefault(); // 기본 해시 이동 방지
                    const targetHash = this.getAttribute('href').substring(1);
                    activatePanel(targetHash);
                    
                    // URL 해시 업데이트 (페이지 새로고침 없음)
                    window.history.pushState(null, null, this.href);
                });
            });

            // 브라우저 뒤로/앞으로 버튼 처리
            window.addEventListener('popstate', function() {
                activatePanel(getHashId());
            });
        });
    </script>
</body>
</html>