package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class GoodsDetailVO {
	private String foodCode;
	private int stock;
	private String detailDescription;
	private String storageMethod;
	private int shippingFee;
	private String productNotice;
	private String createdAt;
	private String updatedAt;
	private String brand;
	private int price;
	private int discountPercent;
	private int discountPrice;
	private String foodName;
}
