package com.service;

import com.dao.SubPageDAO;
import com.exception.LoginErrorException;
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

    @Override
    public MberVO permitMber(MberVO mberVO) throws Exception {
        return subPageDAO.permitMber(mberVO);
    }

    @Override
    public MberVO naverMber(MberVO mberVO) throws Exception {
        return subPageDAO.naverMber(mberVO);
    }

    @Override
    public MberVO login(String mberId, String password) {
        MberVO user = subPageDAO.getUserById(mberId);
        if (user == null) {
            throw new LoginErrorException("아이디가 존재하지 않습니다.");
        }
        if (!password.equals(user.getPassword())) {
            throw new LoginErrorException("비밀번호가 일치하지 않습니다.");
        }
        if (Boolean.TRUE.equals(user.getMberStat())) {
            throw new LoginErrorException("탈퇴한 아이디 입니다.");
        }

        return user;
    }
}
