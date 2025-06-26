package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class OrderDetailVO {
	private int id;
	private int deliveryId;
	private String foodCode;
	private int quantity;
	private int price;
	private String foodName;
}
