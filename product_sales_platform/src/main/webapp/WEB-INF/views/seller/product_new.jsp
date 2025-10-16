<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>신규 상품 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sellerstyle.css" />
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragments/header.jsp" />

    <main class="mypage-body">
        <aside class="mypage-sidebar">
            <nav>
                <ul>
                    <li class="sidebar-title">판매자 마이페이지</li>
                    <li><a href="${pageContext.request.contextPath}/seller/products" class="active">상품 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/members">회원 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/notices">공지사항</a></li>
                </ul>
            </nav>
        </aside>

        <section class="mypage-content-area">
            <h2>신규 상품 등록</h2>

            <form action="${pageContext.request.contextPath}/seller/products" method="post" accept-charset="UTF-8" class="product-form" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="prod_name">상품명</label>
                    <input type="text" id="prod_name" name="prodName" required />
                </div>
                <div class="form-group">
                    <label for="prod_file">상품 이미지</label><br />
                    <input type="file" id="prod_file" name="uploadFile" accept="image/*" required />
                    <small style="color:#777;">* JPEG, PNG 등 이미지 파일만 허용됩니다.</small>
                </div>
                <div class="form-group">
                    <label for="prod_price">가격 (원)</label>
                    <input type="number" id="prod_price" name="prodPrice" required min="0" step="1" />
                </div>
                <div class="form-group">
                    <label for="prod_stock">재고</label>
                    <input type="number" id="prod_stock" name="prodStock" required min="0" step="1" />
                </div>
                <div class="form-group">
                    <label for="prod_code">상품 코드</label>
                    <p class="hint">상품 코드는 등록 시 자동 부여됩니다.</p>
                </div>
                <div class="form-group">
                    <label for="prod_desc">상품 설명</label>
                    <textarea id="prod_desc" name="prodDesc" rows="4" maxlength="4000"></textarea>
                </div>
                
                <section class="product-categories">
                    <h3>카테고리</h3>
                    <p class="help">여러 개 선택 가능 · 대표 1개 지정</p>
                    <div class="cat-accordion">
                        <c:forEach var="top" items="${categories}">
                            <c:if test="${top.depth == 2}">
                                <details class="cat-group">
                                    <summary class="cat-summary">
                                        <label class="cat-label">
                                            <input type="checkbox" name="catIds" value="${top.catId}" class="cat-check" <c:if test="${checkedMap[top.catId]}">checked</c:if> />
                                            <span>${top.catName}</span>
                                        </label>
                                        <label class="main-radio">
                                            <input type="radio" name="mainCatId" value="${top.catId}" class="cat-main" <c:if test="${mainCatIdStr == top.catId}">checked</c:if> />
                                            대표
                                        </label>
                                    </summary>

                                    <ul class="cat-sublist">
                                        <c:forEach var="sub" items="${categories}">
                                            <c:if test="${sub.depth == 3 && sub.catParent == top.catId}">
                                                <li class="cat-subitem">
                                                    <label class="cat-label">
                                                        <input type="checkbox" name="catIds" value="${sub.catId}" class="cat-check" <c:if test="${checkedMap[sub.catId]}">checked</c:if> />
                                                        <span>${sub.catName}</span>
                                                    </label>
                                                    <label class="main-radio">
                                                        <input type="radio" name="mainCatId" value="${sub.catId}" class="cat-main" <c:if test="${mainCatIdStr == sub.catId}">checked</c:if> />
                                                        대표
                                                    </label>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </details>
                            </c:if>
                        </c:forEach>
                    </div>
                </section>

                <c:if test="${not empty sessionScope.seller.selId}">
                    <input type="hidden" name="prodSeller" value="${sessionScope.seller.selId}">
                </c:if>

                <div class="button-group">
                    <button type="submit" class="submit-btn">등록</button>
                    <a href="${pageContext.request.contextPath}/seller/products" class="reset-btn">목록으로</a>
                </div>
            </form>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/fragments/footer.jsp" />
    
    <script>
(function(){
    const checks = document.querySelectorAll('.cat-check');
    const mains  = document.querySelectorAll('.cat-main');
    
    function syncRadios(){
        checks.forEach((chk,i)=>{
            const r=mains[i];
            r.disabled=!chk.checked;
            if(!chk.checked && r.checked) r.checked=false;
        });
        const anyChecked=[...checks].some(c=>c.checked);
        const anyMain=[...mains].some(r=>r.checked);
        if(anyChecked && !anyMain){
            const i=[...checks].findIndex(c=>c.checked);
            if(i>=0) mains[i].checked=true;
        }
    }
    syncRadios();
    checks.forEach(chk=>chk.addEventListener('change', syncRadios));
    
    const form=document.querySelector('form.product-form');
    if(form){
        form.addEventListener('submit', e=>{
            const selected=[...checks].filter(c=>c.checked).length;
            if(selected===0){
                e.preventDefault(); alert('카테고리를 최소 1개 선택해 주세요.');
            }
        });
    }
})();
    </script>
</body>
</html>