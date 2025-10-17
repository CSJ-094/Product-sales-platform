<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>신규 상품 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sellerstyle.css" />
    <style>
        /* 이미지 미리보기 스타일 */
        .image-preview-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
            border: 1px solid #e0e0e0;
            padding: 10px;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .image-preview-item {
            position: relative;
            width: 100px;
            height: 100px;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #fff;
        }
        .image-preview-item img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        .image-preview-item .remove-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: rgba(0, 0, 0, 0.6);
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            opacity: 0.8;
            transition: opacity 0.2s;
        }
        .image-preview-item .remove-btn:hover {
            opacity: 1;
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
                    <input type="file" id="prod_file" name="uploadFiles" accept="image/*" multiple required />
                    <small style="color:#777;">* JPEG, PNG 등 이미지 파일만 허용됩니다. 여러 개 선택 가능합니다.</small>
                    <div id="image-preview-container" class="image-preview-container"></div>
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
                        <c:choose>
                            <c:when test="${empty categories}">
                                <p style="color: #d9534f; font-weight: bold;">카테고리 정보가 없습니다. 관리자에게 문의하세요.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="top" items="${categories}">
                                    <c:if test="${top.depth == 2}">
                                        <details class="cat-group" open> <!-- 'open' 속성 추가 -->
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
                            </c:otherwise>
                        </c:choose>
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
            // 카테고리 유효성 검사 (주석 처리)
            // const selectedChecks = [...checks].filter(c=>c.checked).length;
            // if(selectedChecks === 0){
            //     e.preventDefault(); alert('카테고리를 최소 1개 선택해 주세요.');
            //     return;
            // }

            // const selectedMain = [...mains].some(r=>r.checked);
            // if(!selectedMain){
            //     e.preventDefault(); alert('대표 카테고리를 1개 지정해 주세요.');
            //     return;
            // }

            // 이미지 파일 유효성 검사 및 설정
            if (filesToUpload.length === 0 && prodFileInput.required) {
                e.preventDefault();
                alert('상품 이미지를 최소 1개 등록해 주세요.');
                return;
            }
            const dataTransfer = new DataTransfer();
            filesToUpload.forEach(file => dataTransfer.items.add(file));
            prodFileInput.files = dataTransfer.files;
        });
    }

    // 이미지 미리보기 스크립트
    const prodFileInput = document.getElementById('prod_file');
    const imagePreviewContainer = document.getElementById('image-preview-container');
    let filesToUpload = []; // 실제 업로드할 파일들을 관리할 배열

    prodFileInput.addEventListener('change', function(event) {
        const newFiles = Array.from(event.target.files);
        filesToUpload = filesToUpload.concat(newFiles);
        renderPreviews();
    });

    function renderPreviews() {
        imagePreviewContainer.innerHTML = ''; // 기존 미리보기 초기화

        if (filesToUpload.length === 0) {
            imagePreviewContainer.style.display = 'none';
            return;
        } else {
            imagePreviewContainer.style.display = 'flex';
        }

        filesToUpload.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = function(e) {
                const previewItem = document.createElement('div');
                previewItem.className = 'image-preview-item';
                previewItem.dataset.index = index; // 파일 배열의 인덱스 저장

                const img = document.createElement('img');
                img.src = e.target.result;
                img.alt = file.name;

                const removeBtn = document.createElement('button');
                removeBtn.className = 'remove-btn';
                removeBtn.type = 'button'; // 폼 제출 방지
                removeBtn.textContent = 'x';
                removeBtn.addEventListener('click', function() {
                    removeFile(index);
                });

                previewItem.appendChild(img);
                previewItem.appendChild(removeBtn);
                imagePreviewContainer.appendChild(previewItem);
            };
            reader.readAsDataURL(file);
        });
    }

    function removeFile(indexToRemove) {
        filesToUpload.splice(indexToRemove, 1); // 배열에서 파일 제거
        renderPreviews(); // 미리보기 다시 렌더링

        // 파일 input의 files 속성은 직접 수정할 수 없으므로, 새로운 DataTransfer 객체를 생성하여 대체
        const dataTransfer = new DataTransfer();
        filesToUpload.forEach(file => dataTransfer.items.add(file));
        prodFileInput.files = dataTransfer.files;

        // 만약 모든 파일이 제거되면 required 속성을 다시 활성화
        if (filesToUpload.length === 0) {
            prodFileInput.required = true;
        }
    }

    // 폼 제출 시 filesToUpload 배열의 파일들을 실제 input에 설정
    form.addEventListener('submit', function(e) {
        // 카테고리 유효성 검사 (추가된 부분) - 주석 처리됨
        // const selectedChecks = [...checks].filter(c=>c.checked).length;
        // if(selectedChecks === 0){
        //     e.preventDefault();
        //     alert('카테고리를 최소 1개 선택해 주세요.');
        //     return;
        // }
        // const selectedMain = [...mains].some(r=>r.checked);
        // if(!selectedMain){
        //     e.preventDefault();
        //     alert('대표 카테고리를 1개 지정해 주세요.');
        //     return;
        // }

        // 이미지 파일 유효성 검사 및 설정
        if (filesToUpload.length === 0 && prodFileInput.required) {
            e.preventDefault();
            alert('상품 이미지를 최소 1개 등록해 주세요.');
            return;
        }
        const dataTransfer = new DataTransfer();
        filesToUpload.forEach(file => dataTransfer.items.add(file));
        prodFileInput.files = dataTransfer.files;
    });

    // 페이지 로드 시 초기 미리보기 렌더링 (수정 모드일 경우 기존 이미지)
    // 현재는 신규 등록 페이지이므로, 이 부분은 나중에 상품 수정 페이지에서 구현할 수 있습니다.
    // 만약 prod_file에 이미 파일이 있다면 (예: 브라우저 캐시), 미리보기를 렌더링
    if (prodFileInput.files.length > 0) {
        filesToUpload = Array.from(prodFileInput.files);
        renderPreviews();
    }

})();
    </script>
</body>
</html>