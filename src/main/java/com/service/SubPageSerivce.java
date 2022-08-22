package com.service;

import com.vo.MberVO;

public interface SubPageSerivce {
    void mberjoin(MberVO mberVO) throws Exception;
    boolean memoverlap(String mberId) throws Exception;
}
