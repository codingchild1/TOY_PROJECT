package com.dto;

import com.vo.DiaryVO;
import com.vo.MberVO;
import lombok.Data;

@Data
public class DiaryAcc {
    private String diaryNo;
    private String mberId;
    private String diaryDate;
    private String diaryTitle;
    private String diaryContents;
    private String picturePath;
    private String diaryDelete;
    private String images;
    private int amount;
    private String secretBtn;
    private MberVO mberVO;
    private DiaryVO diaryVO;
}
