package com.dao;

import com.dto.MberDate;
import com.vo.AccountVO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("AccountDAO")
public class AccountDAO extends SqlSessionDaoSupport {

    @Autowired
    public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        super.setSqlSessionFactory(sqlSessionFactory);
    }

    public List<AccountVO> getlist(MberDate mberDate) {
        return getSqlSession().selectList("getlist", mberDate);
    }

    public void insertaccount(AccountVO accountVO) {
        getSqlSession().insert("insertaccount", accountVO);
    }

    public void updateAccount(AccountVO accountVO) {
        getSqlSession().update("updateAccount", accountVO);
    }

    public AccountVO selectAccountByAccNo(String accNo) {
        return getSqlSession().selectOne("selectAccountByAccNo", accNo);
    }

    public void deleteAccList(AccountVO accountVO) {
        getSqlSession().update("deleteAccList", accountVO);
    }
}
