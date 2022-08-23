package com.vo;

public class AccountVO extends MberVO{
    private String accDate;
    private String category;
    private String content;
    private int amount;
    private int allAmount;
    private String accNo;
    private Boolean accDelete;

    public String getAccDate() {
        return accDate;
    }

    public void setAccDate(String accDate) {
        this.accDate = accDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getAllAmount() {
        return allAmount;
    }

    public void setAllAmount(int allAmount) {
        this.allAmount = allAmount;
    }

    public String getAccNo() {
        return accNo;
    }

    public void setAccNo(String accNo) {
        this.accNo = accNo;
    }

    public Boolean getAccDelete() {
        return accDelete;
    }

    public void setAccDelete(Boolean accDelete) {
        this.accDelete = accDelete;
    }

    public AccountVO() {

    }
}
