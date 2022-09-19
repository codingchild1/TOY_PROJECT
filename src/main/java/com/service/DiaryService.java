package com.service;

import com.dto.DiaryAcc;
import com.vo.DiaryVO;

import java.util.List;

public interface DiaryService {

    List<DiaryAcc> diaryList(DiaryAcc diaryAcc) throws Exception;
    void insertDiary(DiaryVO diaryVO) throws Exception;
}
