package com.controller;

import com.dto.DiaryAcc;
import com.service.DiaryService;
import com.vo.DiaryVO;
import com.vo.MberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
    public List<DiaryAcc> diaryListdo(HttpSession session, Model model, @ModelAttribute("mberId") DiaryAcc diaryAcc, String diaryNo, DiaryVO diaryVO) throws Exception{
        List<DiaryAcc> diaryList = new ArrayList<>();
//        DiaryVO diaryVO = new DiaryVO();
        MberVO mberVO = new MberVO();
        try {
            mberVO = (MberVO) session.getAttribute("vo");    // 세션에 저장 되어있는 vo 정보 받아서 객체에 삽입
            if (diaryAcc.getMberId() == null) {
                diaryAcc.setMberId(mberVO.getMberId()); // dto 에 필요한 값 (아이디) 넣어주기
            }
            diaryAcc.setMberVO(mberVO);
            diaryAcc.setDiaryVO(diaryVO);
            diaryList = diaryService.diaryList(diaryAcc);
//            diaryVO = diaryService.selectDiaryByDiaryNo(diaryNo);
            model.addAttribute("acc", diaryVO);

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

    @RequestMapping("diarynodata.do")
    public DiaryVO diaryDiaryNoData(String diaryNo, Model model) throws Exception {
        DiaryVO diaryVO = new DiaryVO();
        try {
            diaryVO = diaryService.selectDiaryByDiaryNo(diaryNo);
            model.addAttribute("diaryNo", diaryNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return diaryVO;
    }

}
