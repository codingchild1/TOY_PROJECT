package com.dao;

import com.vo.DiaryVO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("DiaryDAO")
public class DiaryDAO extends SqlSessionDaoSupport {

    @Autowired
    public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        super.setSqlSessionFactory(sqlSessionFactory);
    }

    public List<DiaryVO> getDiaryList(DiaryVO diaryVO) throws Exception {
        return getSqlSession().selectList("getDiaryList", diaryVO);
    }
}
