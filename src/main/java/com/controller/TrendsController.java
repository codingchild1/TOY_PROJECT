package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sw")
public class TrendsController {

    @RequestMapping("/trends")
    public String trendMain() throws Exception {
        return "jsp/trends/trends";
    }

}
