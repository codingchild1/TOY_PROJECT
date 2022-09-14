package com.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionHandlerController {

    @ExceptionHandler(LoginErrorException.class)
    public String handleLoginErrorException(LoginErrorException e, Model model){
        e.printStackTrace();
        model.addAttribute("error", e.getMessage());
        return "/jsp/login/login";
    }

    @ExceptionHandler(AllException.class)

    public String handleCustomException(AllException e) {
        e.printStackTrace();
        return "error/customError.jsp";
    }
}
