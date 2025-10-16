<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록 - 관리자</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        /* Basic Styles */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Noto Sans KR', 'Montserrat', sans-serif; background-color: #f9f9f9; color: #333; line-height: 1.6; min-height: 100vh; }
        a { text-decoration: none; color: inherit; transition: color 0.3s ease; }
        a:hover { color: #b08d57; }
        ul { list-style: none; }

        /* Header Styles */
        .main-header { background-color: #2c2c2c; padding: 15px 0; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2); }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; flex-direction: column; align-items: flex-start; padding: 0 20px; }
        .header-top { width: 100%; display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .logo a { font-family: 'Montserrat', sans-serif; font-size: 20px; font-weight: 800; color: #ffffff; letter-spacing: 1px; }
        .categories { width: 100%; border-top: 1px solid #555; padding: 8px 0; margin-bottom: 0; }
        .categories ul { display: flex; gap: 30px; }
        .categories a { font-size: 14px; font-weight: 500; padding: 5px 0; color: #ccc; }
        .categories a:hover { color: #b08d57; border-bottom: 2px solid #b08d57; }

        /* Form Container Styles */
        .form-container { max-width: 800px; margin: 50px auto; background-color: #ffffff; padding: 40px; border-radius: 6px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05); border: 1px solid #e0e0e0; }
        h2 { font-size: 26px; border-bottom: 3px solid #b08d57; padding-bottom: 10px; margin-bottom: 30px; color: #2c2c2c; }
        
        /* Form Styles */
        .info-form { margin-top: 20px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: 600; color: #333; margin-bottom: 8px; }
        .form-group input[type="text"], .form-group input[type="number"], .form-group textarea, .form-group input[type="file"] {
            width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 15px; transition: border-color 0.3s; font-family: inherit;
        }
        .form-group input:focus, .form-group textarea:focus { border-color: #b08d57; outline: none; }
        .form-group textarea { resize: vertical; min-height: 120px; }
        .button-group { text-align: center; margin-top: 40px; }
        .submit-btn { padding: 12px 30px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; font-weight: 600; background-color: #2c2c2c; color: white; transition: background-color 0.3s; }
        .submit-btn:hover { background-color: #b08d57; color: #2c2c2c; }
        
        /* Message Styles */
        .message { padding: 15px; margin-bottom: 25px; border-radius: 4px; font-size: 1.1em; text-align: center; }
        .message.success { border: 1px solid #c3e6cb; background-color: #e6f7e9; color: #1a7c36; }
        .message.error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        /* Image Preview Styles */
        .image-preview-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 4px;
            min-height: 120px;
            background-color: #f8f8f8;
        }
        .image-preview {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #ccc;
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

    <main class="form-container">
        <h2>신규 상품 등록</h2>

        <c:if test="${not empty message}">
            <p class="message success">${message}</p>
        </c:if>
        <c:if test="${not empty error}">
            <p class="message error">${error}</p>
        </c:if>

        <form action="<c:url value='/product/admin/add'/>" method="post" enctype="multipart/form-data" class="info-form">
            <div class="form-group">
                <label for="prodName">상품명</label>
                <input type="text" id="prodName" name="prodName" required>
            </div>
            <div class="form-group">
                <label for="prodPrice">가격</label>
                <input type="number" id="prodPrice" name="prodPrice" required min="0">
            </div>
            <div class="form-group">
                <label for="prodStock">재고</label>
                <input type="number" id="prodStock" name="prodStock" required min="0">
            </div>
            <div class="form-group">
                <label for="prodCode">상품 코드</label>
                <input type="text" id="prodCode" name="prodCode" required>
            </div>
            <div class="form-group">
                <label for="prodDesc">상품 설명</label>
                <textarea id="prodDesc" name="prodDesc" rows="4"></textarea>
            </div>
            <div class="form-group">
                <label for="prodImageFiles">상품 이미지 (여러 개 선택 가능)</label>
                <input type="file" id="prodImageFiles" name="prodImageFiles" accept="image/*" multiple>
                <div id="image-preview-container" class="image-preview-container"></div>
            </div>
            <div class="button-group">
                <button type="submit" class="submit-btn">상품 등록</button>
            </div>
        </form>
    </main>

    <script>
        document.getElementById('prodImageFiles').addEventListener('change', function(event) {
            const previewContainer = document.getElementById('image-preview-container');
            previewContainer.innerHTML = ''; // 이전 미리보기 지우기

            const files = event.target.files;
            if (files) {
                Array.from(files).forEach(file => {
                    if (file.type.startsWith('image/')) {
                        const reader = new FileReader();
                        
                        reader.onload = function(e) {
                            const img = document.createElement('img');
                            img.src = e.target.result;
                            img.classList.add('image-preview');
                            previewContainer.appendChild(img);
                        };
                        
                        reader.readAsDataURL(file);
                    }
                });
            }
        });
    </script>
</body>
</html>