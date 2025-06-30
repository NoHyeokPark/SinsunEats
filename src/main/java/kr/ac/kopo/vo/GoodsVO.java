package kr.ac.kopo.vo;

public class GoodsVO {
	private String foodCode;
	private String brand;
	private int price;
	private int discountPercent;
	private int discountPrice;
	private String foodName;
	private String foodDiv;
	private String imgSrc;
	private double averageRating;
	private int reviewCount; 

	public GoodsVO() {
		// TODO Auto-generated constructor stub
	}

	public GoodsVO(String foodCode, String brand, int price, int discountPercent, String foodName) {
		super();
		this.foodCode = foodCode;
		this.brand = brand;

		this.price = price;
		this.discountPercent = discountPercent;

		this.foodName = foodName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getDiscountPercent() {
		return discountPercent;
	}

	public void setDiscountPercent(int discountPercent) {
		this.discountPercent = discountPercent;
	}

	public String getFoodCode() {
		return foodCode;
	}

	public String getBrand() {
		return brand;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public void setFoodCode(String foodCode) {
		this.foodCode = foodCode;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public int getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(int discountPrice) {
		this.discountPrice = discountPrice;
	}

	public String getFoodDiv() {
		return foodDiv;
	}

	public void setFoodDiv(String foodDiv) {
		this.foodDiv = foodDiv;
	}

	public String getImgSrc() {
		return imgSrc;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}

	public double getAverageRating() {
		return averageRating;
	}

	public void setAverageRating(double averageRating) {
		this.averageRating = averageRating;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	
	
	

}
