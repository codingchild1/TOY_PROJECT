package com.service;

import com.dao.SubPageDAO;
import com.vo.MberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SubPageServiceImpl implements SubPageSerivce {

    @Autowired
    SubPageDAO subPageDAO;

    @Override
    public void mberjoin(MberVO mberVO) throws Exception {
        subPageDAO.mberjoin(mberVO);
    }

    @Override
    public boolean memoverlap(String mberId) throws Exception {
        MberVO mem = subPageDAO.memoverlap(mberId);
        if(mem == null) return false;
        return true;
    }
}
