package com.controller;

import com.service.SubPageSerivce;
import com.vo.MberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("sw")
public class LoginController {

    @Autowired
    HttpSession session;

    @Autowired
    SubPageSerivce subPageSerivce;

    @RequestMapping("joinform.do")
    public String joinForm() {
        return "jsp/login/join";
    }

    @RequestMapping("join.do")
    public ModelAndView join(@ModelAttribute MberVO mberVO) {
        ModelAndView mv = new ModelAndView("redirect:/loginform.do");
        try {
            subPageSerivce.mberjoin(mberVO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mv;
    }

    @RequestMapping("loginform.do")
    public String loginForm() throws Exception {
        return "jsp/login/login";
    }

}
