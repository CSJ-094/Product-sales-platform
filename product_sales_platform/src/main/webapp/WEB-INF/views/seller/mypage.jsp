<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>판매자/관리 대시보드</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sellerstyle.css" />

<style>
/* CSS Reset 및 기본 스타일은 sellerstyle.css에 있다고 가정합니다. */
/* 필수적인 레이아웃 및 탭 전환 스타일만 여기에 포함합니다. */

body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* 2단 레이아웃을 위한 메인 컨테이너 */
.mypage-body {
    display: flex;
    max-width: 1200px;
    width: 100%;
    margin: 20px auto; /* 헤더 아래 여백 */
    padding: 0 20px;
    flex-grow: 1;
}

/* 사이드바 스타일 */
.mypage-sidebar {
    width: 200px;
    flex-shrink: 0;
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    height: fit-content; /* 내용물만큼만 높이 지정 */
}

.mypage-sidebar nav ul {
    list-style: none;
    padding: 0;
}

.sidebar-title {
    font-size: 1.1em;
    font-weight: 700;
    color: #343a40;
    padding: 15px 20px 10px;
    border-bottom: 1px solid #eee;
    margin-bottom: 5px;
}

.mypage-sidebar nav ul li a {
    display: block;
    padding: 10px 20px;
    color: #495057;
    text-decoration: none;
    transition: background-color 0.2s, color 0.2s;
    font-size: 0.95em;
}

.mypage-sidebar nav ul li a:hover {
    background-color: #e9ecef;
    color: #17a2b8;
}

.mypage-sidebar nav ul li a.active {
    background-color: #17a2b8; /* 관리자 강조색 */
    color: #ffffff;
    font-weight: 500;
}

/* 콘텐츠 영역 */
.mypage-content-area {
    flex-grow: 1;
    margin-left: 20px;
}

.content-panel {
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    border: 1px solid #e0e0e0;
    margin-bottom: 20px;
    display: none; /* 기본 숨김 */
}

.content-panel.active {
    display: block; /* 활성화된 패널만 보임 */
}

.mypage-content-area h2 {
    font-size: 1.8em;
    color: #343a40;
    border-bottom: 2px solid #17a2b8;
    padding-bottom: 10px;
    margin-bottom: 25px;
}
.mypage-content-area h3 {
    font-size: 1.3em;
    color: #495057;
    margin-top: 20px;
    margin-bottom: 15px;
    padding-left: 5px;
    border-left: 3px solid #17a2b8;
}

/* Form Styles */
.product-form div, .notice-form div {
    margin-bottom: 15px;
}
.product-form label, .notice-form label {
    display: block;
    font-weight: 500;
    margin-bottom: 5px;
    color: #495057;
}
.product-form input[type="text"], 
.product-form input[type="number"], 
.product-form textarea,
.notice-form input[type="text"], 
.notice-form textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

.product-form textarea, .notice-form textarea {
    resize: vertical;
}

.product-form button, .notice-form button {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.3s;
}

.product-form button[type="submit"], .notice-form button[type="submit"] {
    background-color: #28a745; /* Success Green */
    color: white;
}
.product-form button[type="submit"]:hover, .notice-form button[type="submit"]:hover {
    background-color: #1e7e34;
}
.product-form button[type="reset"], .notice-form button[type="reset"] {
    background-color: #6c757d; /* Secondary Gray */
    color: white;
}
.product-form button[type="reset"]:hover, .notice-form button[type="reset"]:hover {
    background-color: #5a6268;
}

/* Table Styles */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    font-size: 0.95em;
}
table th, table td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: left;
}
table th {
    background-color: #f1f1f1;
    font-weight: 600;
    color: #333;
}
table tbody tr:nth-child(even) {
    background-color: #f9f9f9;
}
table button {
    padding: 5px 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-right: 5px;
}
table button:first-of-type {
    background-color: #ffc107; /* Warning Yellow (수정) */
}
table button:last-of-type {
    background-color: #dc3545; /* Danger Red (삭제) */
    color: white;
}

/* Notice List Style */
#notice-board-content ul {
    list-style: disc;
    padding-left: 20px;
}
#notice-board-content ul li {
    margin-bottom: 10px;
    padding-bottom: 5px;
    border-bottom: 1px dotted #eee;
    display: flex;
    justify-content: space-between;
}
#notice-board-content ul li a {
    color: #007bff;
}
#notice-board-content ul li span {
    font-size: 0.85em;
    color: #999;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/fragments/header.jsp" />

	<main class="mypage-body">
		<aside class="mypage-sidebar">
			<nav>
				<ul>
					<li class="sidebar-title">판매자 마이페이지</li>
					<li><a href="${pageContext.request.contextPath}/seller/products" class="active">상품 관리</a></li>
					<li><a href="${pageContext.request.contextPath}/seller/orders">주문 관리</a></li>
					<li><a href="${pageContext.request.contextPath}/seller/members">회원 관리</a></li>
					<li><a href="#notice-board">공지사항</a></li>
				</ul>
			</nav>
		</aside>

		<section class="mypage-content-area">

			<div id="products-content" class="content-panel active">
				<h2>상품 관리</h2>

				<section class="product-registration">
					<h3>신규 상품 등록</h3>
					<form action="${pageContext.request.contextPath}/seller/products" method="post" accept-charset="UTF-8" class="product-form">
						<div>
							<label for="prod_name">상품명</label><br /> 
							<input type="text" id="prod_name" name="prodName" required />
						</div>
						<div>
							<label for="prod_price">가격 (원)</label><br /> 
							<input type="number" id="prod_price" name="prodPrice" required pattern="[0-9]+"
								title="숫자만 입력하세요" />
						</div>
						<div>
							<label for="prod_stock">재고</label><br /> 
							<input type="number" id="prod_stock" name="prodStock" required pattern="[0-9]+"
								title="숫자만 입력하세요" />
						</div>
						<div>
							<label for="prod_desc">상품 설명</label><br />
							<textarea id="prod_desc" name="prod_desc" rows="4" maxlength="4000"></textarea>
						</div>
						
						<c:if test="${not empty sessionScope.seller.selId}">
							<input type="hidden" name="prodSeller" value="${sessionScope.seller.selId}">
						</c:if>
						
						<div>
							<button type="submit">상품 등록</button>
							<button type="reset">초기화</button>
						</div>
					</form>
				</section>

				<hr style="margin: 30px 0; border: 0; border-top: 1px solid #eee;" />

				<h3>등록된 상품 목록</h3>
				<table>
					<thead>
						<tr>
							<th>상품명</th>
							<th>가격</th>
							<th>재고</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<%-- 💡 컨트롤러에서 상품 목록(prodList)을 받아와 반복한다고 가정 --%>
							<c:when test="${not empty prodList}">
								<c:forEach var="prod" items="${prodList}">
									<tr>
										<td>${prod.prodName}</td>
										<td>${prod.prodPrice}원</td>
										<td>${prod.prodStock}</td>
										<td>${prod.prodRegDate}</td>
										<td>
											<button>수정</button>
											<button>삭제</button>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" style="text-align: center; color: #777;">등록된 상품이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
						<tr>
							<td>여름 반팔 티셔츠</td>
							<td>19,000원</td>
							<td>120</td>
							<td>2025-10-01</td>
							<td>
								<button>수정</button>
								<button>삭제</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div id="members-content" class="content-panel">
				<h2>회원 관리</h2>
				<p>해당 판매자의 상품을 구매한 회원 목록</p>
				<table>
					<thead>
						<tr>
							<th>회원명</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>최근 주문일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>홍길동</td>
							<td>hong@example.com</td>
							<td>010-1111-2222</td>
							<td>2025-10-05</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div id="notice-board-content" class="content-panel">
				<h2>공지사항</h2>
				<ul>
					<li><a href="#">[중요] 추석 연휴 배송 안내</a> <span>2025-09-20</span></li>
					<li><a href="#">[공지] 신규 카테고리 오픈</a> <span>2025-09-10</span></li>
				</ul>
				<hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;" />
				<section class="notice-write">
					<h3>공지사항 글쓰기</h3>
					<form action="#" method="post" class="notice-form">
						<div>
							<label for="notice_title">제목</label><br /> 
							<input type="text" id="notice_title" name="notice_title" required />
						</div>
						<div>
							<label for="notice_content">내용</label><br />
							<textarea id="notice_content" name="notice_content" rows="6" required></textarea>
						</div>
						<div>
							<button type="submit">등록</button>
							<button type="reset">초기화</button>
						</div>
					</form>
				</section>
			</div>
		</section>
	</main>

	<jsp:include page="/WEB-INF/views/fragments/footer.jsp" />

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 탭 전환 로직
    const sidebarLinks = document.querySelectorAll('.mypage-sidebar a');
    const contentPanels = document.querySelectorAll('.content-panel');
    
    sidebarLinks.forEach(tab => {
        tab.addEventListener('click', function(e) {
            const href = this.getAttribute('href') || '';
            
            // 해시(#)로 시작하거나, 현재 페이지의 URL과 같은 경로의 링크만 탭 전환 처리
            // 나머지는 기본 동작(URL 이동)을 수행합니다.
            if (href.startsWith('#') || href.endsWith('/seller/products') || href.endsWith('/seller/members') || href.endsWith('/seller/orders')) {
                e.preventDefault();
                
                let targetId;

                if (href.startsWith('#')) {
                    // #notice-board -> notice-board-content
                    targetId = href.replace('#', '') + '-content';
                } else {
                    // /seller/products -> products-content
                    // URL 경로를 기반으로 ID를 유추합니다.
                    const pathSegment = href.split('/').pop().split('?')[0]; 
                    targetId = pathSegment + '-content';
                }

                // 1. Sidebar Active 클래스 처리
                sidebarLinks.forEach(a => a.classList.remove('active'));
                this.classList.add('active');
                
                // 2. Content Panel Active 클래스 처리
                contentPanels.forEach(panel => panel.classList.remove('active'));
                const target = document.getElementById(targetId);
                if (target) {
                    target.classList.add('active');
                    // 탭 전환 시 URL 해시 변경 (뒤로가기/앞으로가기 지원)
                    history.pushState(null, null, '#'+targetId.replace('-content',''));
                }
            }
        });
    });
    
    // 페이지 로드 시 해시를 기반으로 초기 탭 설정
    function activateTabFromHash() {
        const hash = window.location.hash.replace('#', '');
        let initialTargetId = hash ? hash + '-content' : 'products-content'; 
        
        // 기본 탭은 상품 관리
        if (initialTargetId === '-content' || initialTargetId === 'seller/products-content') {
            initialTargetId = 'products-content';
        }
        
        // 해당 패널 활성화
        const initialPanel = document.getElementById(initialTargetId);
        if (initialPanel) {
            contentPanels.forEach(panel => panel.classList.remove('active'));
            initialPanel.classList.add('active');
            
            // 해당 사이드바 링크 활성화
            sidebarLinks.forEach(a => {
                const linkHref = a.getAttribute('href');
                if ((linkHref.startsWith('#') && linkHref.includes(hash)) || linkHref.endsWith(hash)) {
                    sidebarLinks.forEach(a => a.classList.remove('active'));
                    a.classList.add('active');
                }
            });
        }
    }
    
    activateTabFromHash();
    window.addEventListener('hashchange', activateTabFromHash);
});
</script>
</body>
</html>