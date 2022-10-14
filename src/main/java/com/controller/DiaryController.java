package com.controller;

import com.service.DiaryService;
import com.vo.MberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/sw")
public class DiaryController {

    @Autowired
    DiaryService diaryService;

    @RequestMapping("/diaymainform.do")
    public String diarymain(MberVO mberVO, Model model) throws Exception {
        try {
            List<MberVO> userList = diaryService.mberIdList(mberVO);
            model.addAttribute("mberVO", userList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "jsp/diary/diary_main";
    }
}
