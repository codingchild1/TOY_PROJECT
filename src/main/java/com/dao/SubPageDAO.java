package com.dao;

import com.vo.MberVO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("SubPageDAO")
public class SubPageDAO extends SqlSessionDaoSupport {

    @Autowired
    public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        super.setSqlSessionFactory(sqlSessionFactory);
    }

    public void mberjoin(MberVO mberVO) throws Exception {
        getSqlSession().insert("mberjoin", mberVO);
    }

    public MberVO memoverlap(String mberId) throws Exception {
        return getSqlSession().selectOne("memoverlap", mberId);
    }

}
