package com.lgy.product_sales_platform.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.lgy.product_sales_platform.dao.ProdDAO;
import com.lgy.product_sales_platform.dao.ProductCategoryDAO;
import com.lgy.product_sales_platform.dao.ImageDAO; // ImageDAO 추가
import com.lgy.product_sales_platform.dto.ProdDTO;
import com.lgy.product_sales_platform.dto.ProductCategoryDTO;
import com.lgy.product_sales_platform.dto.ImageDTO; // ImageDTO 추가

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductServiceImpl implements ProductService {

    // ⭐️ 파일 저장 경로: 실제 서버 경로로 변경해야 합니다.
    // 상품 ID별로 하위 디렉토리를 생성할 것이므로, 여기는 기본 경로만 지정합니다.
    private static final String UPLOAD_BASE_DIR = "C:/temp/product_upload/images"; 

    private final ProdDAO prodDAO;
    private final ProductCategoryDAO productCategoryDAO;
    private final ImageDAO imageDAO; // @RequiredArgsConstructor를 통해 주입됨

    // 1. [Read 기능] 상품 상세 조회
    @Override
    public ProdDTO getProductById(Integer prodId) {
        log.info("Fetching product detail for prodId: {}", prodId);
        ProdDTO product = prodDAO.getProductById(prodId);
        
        if (product != null) {
            // 대표 이미지 경로를 가져와 ProdDTO에 설정
            String mainImagePath = imageDAO.getMainImagePathByProdId(prodId);
            product.setProdImage(mainImagePath);
        }
        log.info("Product prodImage path: {}", product.getProdImage());
        return product;
    }

    // 2. [Read 기능] 이미지 포함된 상품 목록 조회
    @Override
    public List<ProdDTO> getProductListWithImages() {
        List<ProdDTO> products = prodDAO.getProductList();
        for (ProdDTO product : products) {
            String mainImagePath = imageDAO.getMainImagePathByProdId(product.getProdId().intValue());
            product.setProdImage(mainImagePath);
        }
        return products;
    }

    // 3. [Admin 기능] 상품 등록
    @Override
    @Transactional
    // ⭐️ MultipartFile[] files 매개변수로 변경
    public void createProductWithCategories(ProdDTO product, List<Long> catIds, Long mainCatId, MultipartFile[] files) {
        
        // PROD_CODE 자동 생성 (UUID 사용 후 10자로 줄임 - 고유성 충돌 위험 있음)
        String uuid = UUID.randomUUID().toString().replace("-", ""); // 하이픈 제거
        product.setProdCode(uuid.substring(0, Math.min(uuid.length(), 10))); // 10자로 자르기

        // 1. 상품 등록: MyBatis <selectKey>를 통해 product.getProdId()에 ID가 채워집니다.
        prodDAO.insertProduct(product);
        Long prodId = product.getProdId();

        // 2. 이미지 파일 처리 및 DB 삽입
        if (files != null && files.length > 0) {
            // 상품 ID별 이미지 저장 디렉토리 생성
            File productUploadDir = new File(UPLOAD_BASE_DIR, String.valueOf(prodId));
            if (!productUploadDir.exists()) {
                productUploadDir.mkdirs(); // 저장 디렉터리가 없으면 생성
            }

            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                if (file != null && !file.isEmpty()) {
                    try {
                        String originalFileName = file.getOriginalFilename();
                        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                        
                        // 파일명 중복 방지 (UUID 사용)
                        String savedFileName = UUID.randomUUID().toString() + fileExtension; 
                        
                        // DB에 저장할 웹 접근 경로 (Spring Resource Handler 설정과 일치해야 함)
                        // 예: /upload/images/123/uuid.jpg
                        String savedFilePath = "/upload/images/" + prodId + "/" + savedFileName; 
                        
                        File targetFile = new File(productUploadDir, savedFileName);
                        
                        // 파일 저장 실행
                        file.transferTo(targetFile); 
                        
                        // 이미지 DTO 생성 및 IMAGE_DB에 삽입
                        ImageDTO imageDTO = new ImageDTO();
                        imageDTO.setImgProdId(prodId);
                        imageDTO.setImgPath(savedFilePath);
                        imageDTO.setIsMain(i == 0 ? "Y" : "N"); // 첫 번째 파일은 대표 이미지
                        imageDTO.setImgOrder(i); 

                        imageDAO.insertImage(imageDTO);
                        
                    } catch (IOException e) {
                        log.error("파일 저장 중 오류 발생: {}", e.getMessage());
                        // 파일 저장 오류 발생 시 트랜잭션 롤백 유도
                        throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.", e);
                    }
                }
            }
        } else {
            log.warn("상품 등록 시 이미지 파일이 누락되었습니다. 상품 ID: {}", prodId);
        }
        
        // 4. 카테고리 매핑 로직
        if (catIds == null || catIds.isEmpty()) {
            // throw new IllegalArgumentException("카테고리를 최소 1개 선택해 주세요."); // 임시 주석 처리
        }
        // mainCatId가 null이거나 선택된 catIds에 포함되지 않으면 첫 번째 catId를 mainCatId로 설정
        if (mainCatId == null && catIds != null && !catIds.isEmpty()) { // catIds가 null이 아닐 때만 접근
            mainCatId = catIds.get(0);
        } else if (mainCatId != null && catIds != null && !catIds.contains(mainCatId)) { // mainCatId가 있고 catIds에 포함되지 않을 때
            mainCatId = catIds.get(0);
        }
        
        List<ProductCategoryDTO> list = new ArrayList<ProductCategoryDTO>();
        if (catIds != null) { // catIds가 null이 아닐 때만 반복
            for (Long cid : catIds) {
                ProductCategoryDTO m = new ProductCategoryDTO();
                m.setProdId(prodId); // 새로 생성된 prodId 사용
                m.setCatId(cid);
                m.setIsMain(cid.equals(mainCatId) ? "Y" : "N");
                list.add(m);
            }
            productCategoryDAO.bulkInsert(list);
        }
    }
    
    @Override
    @Transactional
    public void updateProductWithCategories(ProdDTO form, List<Long> catIds, Long mainCatId) {
        // 상품 정보 업데이트
        prodDAO.updateProduct(form);
        
        // 기존 카테고리 매핑 삭제 및 새로 삽입
        productCategoryDAO.deleteAllByProdId(form.getProdId());

        if (catIds == null || catIds.isEmpty()) {
            // throw new IllegalArgumentException("카테고리를 최소 1개 선택해 주세요."); // 임시 주석 처리
        }
        if (mainCatId == null && catIds != null && !catIds.isEmpty()) { // catIds가 null이 아닐 때만 접근
            mainCatId = catIds.get(0);
        } else if (mainCatId != null && catIds != null && !catIds.contains(mainCatId)) { // mainCatId가 있고 catIds에 포함되지 않을 때
            mainCatId = catIds.get(0);
        }

        List<ProductCategoryDTO> list = new ArrayList<ProductCategoryDTO>();
        if (catIds != null) { // catIds가 null이 아닐 때만 반복
            for (Long cid : catIds) {
                ProductCategoryDTO m = new ProductCategoryDTO();
                m.setProdId(form.getProdId());
                m.setCatId(cid);
                m.setIsMain(cid.equals(mainCatId) ? "Y" : "N");
                list.add(m);
            }
            productCategoryDAO.bulkInsert(list);
        }
    }
}