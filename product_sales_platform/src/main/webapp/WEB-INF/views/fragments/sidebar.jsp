<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside class="mypage-sidebar">
  <nav>
    <ul>
      <li class="sidebar-title">판매자 마이페이지</li>
      <li><a href="${pageContext.request.contextPath}/seller/products"
             class="${activeMenu eq 'product' ? 'active' : ''}">상품 관리</a></li>
      <li><a href="${pageContext.request.contextPath}/seller/members"
             class="${activeMenu eq 'member' ? 'active' : ''}">회원 관리</a></li>
      <li><a href="${pageContext.request.contextPath}/seller/notices"
             class="${activeMenu eq 'notice' ? 'active' : ''}">공지사항</a></li>
    </ul>
  </nav>
</aside>
