package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CartVO {
	private int cartId;
	private int quantity;
	private String userId;
	private String foodCode;
	private String addedAt;
	private String isSelected;
	private int priceAtAdd;
	private String foodName;
	private int price;
	private int discountPrice;
	private int discountPercent;
}
