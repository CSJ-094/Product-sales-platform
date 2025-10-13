package Product_sales_platform.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProdDTO {
	private int PROD_ID;
	private String PROD_SELLER;
	private String PROD_NAME;
	private int PROD_PRICE;
	private int PROD_STOCK;
	private String PROD_DESC;
	private String PROD_CODE;
	private Timestamp PROD_REG;
	private Timestamp PROD_UPD;
}
