package com.service;

import com.dto.MberDate;
import com.vo.AccountVO;

import java.util.List;

public interface AccountService {
    List<AccountVO> selectAccountList(MberDate mberDate) throws Exception;
    void insertaccount(AccountVO accountVO) throws Exception;
    void updateAccount(AccountVO accountVO) throws Exception;
    AccountVO selectAccountByAccNo(String accNo) throws Exception;
    void deleteAccList(AccountVO accountVO) throws Exception;
}
