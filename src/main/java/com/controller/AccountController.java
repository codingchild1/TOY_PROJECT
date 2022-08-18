package com.controller;

import com.service.AccountService;
import com.vo.AccountVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("sw")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @RequestMapping("main")
    public String AccountPage() throws Exception {
        return "main";
    }

}
