package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("sw")
public class AccountController {

    @RequestMapping("account")
    public String AccountPage() throws Exception {
        return "jsp/account/account";
    }

}
