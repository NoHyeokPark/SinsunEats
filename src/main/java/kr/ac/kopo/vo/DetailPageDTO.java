package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class DetailPageDTO {
	private String brand;
	private int price;
	private int discountPercent;
	private String foodName;
	private String foodCode;
	private String detailDescription;
	private String storageMethod;
	private int shippingFee;
	private String productNotice;

}
