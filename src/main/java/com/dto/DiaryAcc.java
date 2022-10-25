package com.dto;

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

    public String getDiaryNo() {
        return diaryNo;
    }

    public void setDiaryNo(String diaryNo) {
        this.diaryNo = diaryNo;
    }

    public String getMberId() {
        return mberId;
    }

    public void setMberId(String mberId) {
        this.mberId = mberId;
    }

    public String getDiaryDate() {
        return diaryDate;
    }

    public void setDiaryDate(String diaryDate) {
        this.diaryDate = diaryDate;
    }

    public String getDiaryTitle() {
        return diaryTitle;
    }

    public void setDiaryTitle(String diaryTitle) {
        this.diaryTitle = diaryTitle;
    }

    public String getDiaryContents() {
        return diaryContents;
    }

    public void setDiaryContents(String diaryContents) {
        this.diaryContents = diaryContents;
    }

    public String getPicturePath() {
        return picturePath;
    }

    public void setPicturePath(String picturePath) {
        this.picturePath = picturePath;
    }

    public String getDiaryDelete() {
        return diaryDelete;
    }

    public void setDiaryDelete(String diaryDelete) {
        this.diaryDelete = diaryDelete;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
}
