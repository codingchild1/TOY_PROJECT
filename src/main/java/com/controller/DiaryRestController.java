package com.controller;

import com.service.DiaryService;
import com.vo.DiaryVO;
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
    public List<DiaryVO> diaryListdo(HttpSession session, DiaryVO diaryVO) throws Exception{
//        MberVO mberVO = (MberVO)session.getAttribute("vo");
        List<DiaryVO> diaryList = new ArrayList<>();
        try {
            diaryList = diaryService.diaryList(diaryVO);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return diaryList;
    }
}
