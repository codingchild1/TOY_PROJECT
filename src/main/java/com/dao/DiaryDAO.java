package com.dao;

import com.dto.DiaryAcc;
import com.vo.DiaryVO;
import com.vo.MberVO;
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

    public List<DiaryAcc> getDiaryList(DiaryAcc diaryAcc) throws Exception {
        return getSqlSession().selectList("getDiaryList", diaryAcc);
    }

    public void insertDiary(DiaryVO diaryVO) {
        getSqlSession().insert("insertDiary", diaryVO);
    }

    public DiaryVO selectDiaryByDiaryNo(String diaryNo) throws Exception {
        return getSqlSession().selectOne("selectDiaryByDiaryNo", diaryNo);
    }

    public List<MberVO> mberIdList(MberVO mberVO) throws Exception {
        return getSqlSession().selectList("mberIdList", mberVO);
    }
}
