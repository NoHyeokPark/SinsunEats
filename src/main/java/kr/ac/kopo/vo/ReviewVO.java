package kr.ac.kopo.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReviewVO {
	private int reviewId;
	private String foodCode;
	private String regDate;
	private String title;
	private String content;
	private String writer;
	private int grade;
	
}
