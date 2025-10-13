package Product_sales_platform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemDTO {
	private String MEMBER_ID;
	private String MEMBER_PW;
	private String MEMBER_NAME;
	private String MEMBER_EMAIL;
	private String MEMBER_PHONE;
	private String MEMBER_ADDR;
}
