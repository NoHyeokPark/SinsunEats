package kr.ac.kopo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PopupVO {
    private int id;
    private String title;
    private String content;
    private String isPopup;    
    private String startDate;
    private String endDate;
    private String regDate;
    private int processed;
}
