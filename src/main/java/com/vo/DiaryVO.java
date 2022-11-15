package com.vo;

import lombok.Data;

@Data
public class DiaryVO {
    private String diaryNo;
    private String mberId;
    private String diaryDate;
    private String diaryTitle;
    private String diaryContents;
    private String picturePath;
    private String diaryDelete;
    private String images;
    private String secretBtn;
}
