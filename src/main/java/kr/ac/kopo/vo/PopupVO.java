package kr.ac.kopo.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PopupVO {
    private Integer id;
    private String title;
    private String isPopup;    
    private String startDate;
    private String endDate;
    private String regDate;
    private int processed;
    private String imgSrc;
    private MultipartFile popupImageFile;
}
