package com.service;

import com.dto.DiaryAcc;
import com.vo.DiaryVO;
import com.vo.MberVO;

import java.util.List;

public interface DiaryService {

    List<DiaryAcc> diaryList(DiaryAcc diaryAcc) throws Exception;
    void insertDiary(DiaryVO diaryVO) throws Exception;
    DiaryVO selectDiaryByDiaryNo(String diaryNo) throws Exception;
    List<MberVO> mberIdList(MberVO mberVO) throws Exception;
}
