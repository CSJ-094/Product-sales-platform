package Product_sales_platform.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrdDTO {
	private String ORD_ID;
	private String ORD_MEMID;
	private Timestamp ORD_DATE;
	private int ORD_AMOUNT;
	private int ORD_DFEE;
	private int ORD_DISCOUNT;
	private String ORD_STATUS;
}
