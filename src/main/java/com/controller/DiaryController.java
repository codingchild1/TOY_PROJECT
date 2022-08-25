package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sw")
public class DiaryController {

    @RequestMapping("/diaymainform.do")
    public String diarymain() {
        return "jsp/diary/diary_main";
    }
}
