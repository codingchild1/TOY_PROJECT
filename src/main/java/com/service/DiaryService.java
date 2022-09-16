package com.service;

import com.dto.DiaryAcc;

import java.util.List;

public interface DiaryService {

    List<DiaryAcc> diaryList(DiaryAcc diaryAcc) throws Exception;
}
