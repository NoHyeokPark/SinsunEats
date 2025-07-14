package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class goodsAdminVO {
	
	private String foodCode;
	private String brand;
	private int price;
	private int discountPercent;
	private String foodName;
	private String foodDiv;
	private String imgSrc;
	private int stock;
	private String detailDescription;
	private String createdAt;
	private String contentSrc;
	private int discountPrice;
	private String status;
	private String isBest;
	private String isNew;
	
}
