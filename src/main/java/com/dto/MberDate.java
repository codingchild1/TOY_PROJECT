package com.dto;

import com.vo.DateVO;
import com.vo.MberVO;

/* 두개의 객체를 하나의 파라미터로 사용하기 위한 dto */
public class MberDate {
    private MberVO mberVO;
    private DateVO dateVO;

    public MberVO getMberVO() {
        return mberVO;
    }

    public void setMberVO(MberVO mberVO) {
        this.mberVO = mberVO;
    }

    public DateVO getDateVO() {
        return dateVO;
    }

    public void setDateVO(DateVO dateVO) {
        this.dateVO = dateVO;
    }
}
