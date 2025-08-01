package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class OrderVO {

		private int deliveryId;
		private String userId;
		private String deliveryStatus;
		private String orderDate;
		private String recipientName;
		private String recipientPhone;
		private String address;
		private String addressDetail;
		private String postCode;
		private int totalPrice;
		private String paymentMethod;
		private int invoiceNumber;
		private String updatedAt;
		private int usedMileage;
		private String paymentKey;
}
