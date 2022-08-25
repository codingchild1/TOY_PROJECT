package com.service;

import com.dao.DiaryDAO;
import com.vo.DiaryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiaryServiceImpl implements DiaryService {

    @Autowired
    DiaryDAO diaryDAO;

    @Override
    public List<DiaryVO> diaryList(DiaryVO diaryVO) throws Exception {
        return diaryDAO.getDiaryList(diaryVO);
    }
}
