package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BoardVO {
	private int no;
	private String title;
	private String writer;
	private String content;
	private int viewCnt;
	private String regDate;

}
