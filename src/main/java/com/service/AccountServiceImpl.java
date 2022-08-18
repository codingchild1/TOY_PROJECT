package com.service;

import com.dao.AccountDAO;
import com.vo.AccountVO;
import com.vo.DateVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AccountServiceImpl implements AccountService {

    @Resource(name="AccountDAO")
    private AccountDAO accountDAO;

    @Override
    public List<AccountVO> selectAccountList(DateVO dateVO) throws Exception {
        List<AccountVO> list = accountDAO.getlist(dateVO);
        return list;
    }

    @Override
    public void insertaccount(AccountVO accountVO) throws Exception {

        accountDAO.insertaccount(accountVO);
    }

    @Override
    public void updateAccount(AccountVO accountVO) throws Exception {

        accountDAO.updateAccount(accountVO);
    }

    @Override
    public AccountVO selectAccountByAccNo(String accNo) throws Exception {

        return accountDAO.selectAccountByAccNo(accNo);
    }

    @Override
    public void deleteAccList(AccountVO accountVO) throws Exception {

        accountDAO.deleteAccList(accountVO);
    }
}
