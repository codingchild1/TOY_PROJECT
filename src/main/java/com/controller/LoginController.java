package com.controller;

import com.exception.LoginErrorException;
import com.service.SubPageSerivce;
import com.vo.MberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
    public String loginForm(@RequestParam(value = "error", required = false) String error, Model model) throws Exception {
        try {
            if (error != null && error.equals("loginError")) {
                model.addAttribute("err", error);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "jsp/login/login";
    }

//    @RequestMapping("login.do")
//    public ModelAndView login(HttpSession session, @ModelAttribute MberVO mberVO) throws Exception {
//        ModelAndView mv = new ModelAndView();
//        try {
//            MberVO vo = subPageSerivce.permitMber(mberVO);
//            if (vo == null) {
//                mv.setViewName("redirect:/sw/loginform.do?error=loginError");
//
//                // 파라미터 error에 값 저장하기
//            } else {
//                session.setAttribute("vo", vo);
//                mv.setViewName("redirect:/sw/main");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw e;
//        }
//        return mv;
//    }

    @RequestMapping("login.do")
    public String login(String mberId, String password, Model model, HttpSession session){
        // 아이디와 비밀번호가 비어있거나 공백만 있으면 loginform.jsp로 내부이동
            if (!StringUtils.hasText(mberId) || !StringUtils.hasText(password)) {
                throw new LoginErrorException("아이디와 비밀번호는 필수 입력값입니다.");
            }

            // UserService의 사용자 인증 서비스 호출
            MberVO user = subPageSerivce.login(mberId, password);

		/*
			// 인증된 사용자정보를 Model에 저장
			// @SessionAttributes(name = {"LOGIN_USER"}) 설정은 모델에 "LOGIN_USER"라는 이름으로 저장되는 객체를
			// HttpSession객체에 저장시킨다. 즉, 인증된 사용자 정보가 HttpSession객체에 저장된 것이다.
			//model.addAttribute("LOGIN_USER", user);
		*/

            /*
             * 인증된 사용자정보를 HttpSession에 저장함
             */
            session.setAttribute("vo", user);


        return "redirect:/sw/main";
    }

    @RequestMapping("logout.do")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("vo");
        return "jsp/login/login";
    }

    @RequestMapping("naverlogin.do")
    public String naverLogin(HttpSession session, MberVO mberVO) throws Exception {
        try {
            System.out.println("네이버로그인");
            System.out.println("네이버로그인");

            MberVO vo = subPageSerivce.naverMber(mberVO);
            session.setAttribute("vo", vo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "jsp/account/main";
    }

}
