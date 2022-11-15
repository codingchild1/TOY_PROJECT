package com.vo;

import lombok.Data;

@Data
public class MberVO {
    private String mberId;
    private String password;
    private String mberNm;
    private String email;
    private String phoneNum;
    private String address;
    private String addressDetail;
    private String mberType;
    private String mberState;
    private String esntlId;
    private Boolean mberStat;
}
