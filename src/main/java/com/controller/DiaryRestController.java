package com.controller;

import com.dto.DiaryAcc;
import com.service.DiaryService;
import com.vo.DiaryVO;
import com.vo.MberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/rest")
public class DiaryRestController {

    @Autowired
    DiaryService diaryService;

    @RequestMapping("diarylist.do")
    public List<DiaryAcc> diaryListdo(HttpSession session, DiaryAcc diaryAcc) throws Exception{
        List<DiaryAcc> diaryList = new ArrayList<>();

        try {
            MberVO mberVO = (MberVO) session.getAttribute("vo");    // 세션에 저장 되어있는 vo 정보 받아서 객체에 삽입
            diaryAcc.setMberId(mberVO.getMberId()); // dto 에 필요한 값 (아이디) 넣어주기
            diaryList = diaryService.diaryList(diaryAcc);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return diaryList;
    }

    @RequestMapping("insertDiary.do")
    public String insertDiary(HttpSession session, DiaryVO diaryVO) throws Exception {
        try {
            diaryService.insertDiary(diaryVO);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "";
    }

}
