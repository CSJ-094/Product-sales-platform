package com.lgy.product_sales_platform.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.lgy.product_sales_platform.dao.ProdDAO;
import com.lgy.product_sales_platform.dto.ProdDTO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProductService {

    @Autowired
    private ProdDAO productMapper;

    @Autowired
    private ServletContext servletContext; // 파일 업로드 경로를 위해 주입

    public ProdDTO getProductById(int prodId) {
        return productMapper.getProductById(prodId);
    }

    public List<ProdDTO> getAllProducts() {
        return productMapper.getAllProducts();
    }

    @Transactional
    public void registerProduct(ProdDTO prodDTO, List<MultipartFile> prodImageFiles) throws IOException {
        String uploadPath = servletContext.getRealPath("/resources/uploads/");
        log.info("Real upload path: {}", uploadPath);

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        List<String> imagePaths = new ArrayList<>();
        
        if (prodImageFiles != null && !prodImageFiles.isEmpty()) {
            for (MultipartFile file : prodImageFiles) {
                if (!file.isEmpty()) {
                    String originalFilename = file.getOriginalFilename();
                    String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                    String savedFilename = UUID.randomUUID().toString() + extension;

                    File destFile = new File(uploadDir, savedFilename);
                    file.transferTo(destFile);

                    imagePaths.add("/resources/uploads/" + savedFilename);
                }
            }
        }

        if (!imagePaths.isEmpty()) {
            prodDTO.setProdImage(String.join(",", imagePaths));
        } else {
            prodDTO.setProdImage("/resources/img/default-product.png");
        }

        log.info("Attempting to register product with data: {}", prodDTO);
        productMapper.registerProduct(prodDTO);
        log.info("Product registration query executed.");
    }
}
