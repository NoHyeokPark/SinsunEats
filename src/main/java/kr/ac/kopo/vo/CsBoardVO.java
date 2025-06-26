package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CsBoardVO {
	private int no;
	private String status;
	private int fileRef;
	private String category;
	private String title;
	private String writer;
	private String content;
	private String regDate;
	private String tel;
	private String answer;

}
