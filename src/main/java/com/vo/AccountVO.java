package com.vo;

import lombok.Data;

@Data
public class AccountVO extends MberVO{
    private String accDate;
    private String category;
    private String content;
    private int amount;
    private int allAmount;
    private String accNo;
    private Boolean accDelete;
}
