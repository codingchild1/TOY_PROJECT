package com.service;

import com.vo.DiaryVO;

import java.util.List;

public interface DiaryService {

    List<DiaryVO> diaryList(DiaryVO diaryVO) throws Exception;
}
