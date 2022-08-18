package com.service;

import com.vo.AccountVO;
import com.vo.DateVO;

import java.util.List;

public interface AccountService {
    List<AccountVO> selectAccountList(DateVO dateVO) throws Exception;
    void insertaccount(AccountVO accountVO) throws Exception;
    void updateAccount(AccountVO accountVO) throws Exception;
    AccountVO selectAccountByAccNo(String accNo) throws Exception;
    void deleteAccList(AccountVO accountVO) throws Exception;
}
