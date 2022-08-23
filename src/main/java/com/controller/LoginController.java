package com.controller;

import com.service.SubPageSerivce;
import com.vo.MberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("sw")
public class LoginController {

    @Autowired
    SubPageSerivce subPageSerivce;

    @RequestMapping("joinform.do")
    public String joinForm() {
        return "jsp/login/join";
    }

    @RequestMapping("join.do")
    public ModelAndView join(@ModelAttribute MberVO mberVO) {
        ModelAndView mv = new ModelAndView("redirect:/sw/loginform.do");
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

    @RequestMapping("login.do")
    public ModelAndView login(HttpSession session, @ModelAttribute MberVO mberVO) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            MberVO vo = subPageSerivce.permitMber(mberVO);
            session.setAttribute("vo", vo);
            mv.setViewName("redirect:/sw/main");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mv;
    }

    @RequestMapping("logout.do")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("vo");
        return "jsp/login/login";
    }

}
