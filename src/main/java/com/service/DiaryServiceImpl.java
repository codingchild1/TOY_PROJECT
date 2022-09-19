package com.service;

import com.dao.DiaryDAO;
import com.dto.DiaryAcc;
import com.vo.DiaryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiaryServiceImpl implements DiaryService {

    @Autowired
    DiaryDAO diaryDAO;

    @Override
    public List<DiaryAcc> diaryList(DiaryAcc diaryAcc) throws Exception {
        return diaryDAO.getDiaryList(diaryAcc);
    }

    @Override
    public void insertDiary(DiaryVO diaryVO) throws Exception {

        diaryDAO.insertDiary(diaryVO);
    }
}
