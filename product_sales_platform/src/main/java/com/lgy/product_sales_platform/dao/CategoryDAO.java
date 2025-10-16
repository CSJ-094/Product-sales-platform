package com.lgy.product_sales_platform.dao;

import java.util.List;
import com.lgy.product_sales_platform.dto.CategoryDTO;

public interface CategoryDAO {
	List<CategoryDTO> selectTreeFlat();
}