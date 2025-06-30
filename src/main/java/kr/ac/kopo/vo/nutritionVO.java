package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class nutritionVO {
	private String foodCode;
	private String foodDiv;
	private String groupName;
	private String standard;
	private String ashG;
	private String nntransfattyacidsG;//
	private String weight;//
	private String baseDate;
	private String provider;
	private int divCode;
	private int groupCode;
	private int energyKcal;//
	private int moistureG;
	private int proteinG;//
	private int fatG;//
	private int carbohydrateG;//
	private int nnsugarsG;//
	private int fiberG;
	private int calciumMg;
	private int ironMg;
	private int phosphorusMg;
	private int potassiumMg;
	private int nnsodiumMg;//
	private int vitamina;
	private int retinol;
	private int betaCarotene;
	private int thiaminMg;
	private int riboflavinMg;
	private int niacinMg;
	private int vitamincMg;
	private int vitamind;
	private int nncholesterolMg;//
	private int nnsaturatedfattyacidsG;//
	
}
