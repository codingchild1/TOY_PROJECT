package com.controller;

import com.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("sw")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @RequestMapping("main")
    public String AccountPage() throws Exception {
        return "jsp/account/main";
    }

}
