package com.example.GymWebAppSpring.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

@ControllerAdvice
public class ErrorHandlerController {

    @ExceptionHandler(value = {Exception.class, RuntimeException.class})
    protected String exception(RuntimeException ex, WebRequest webRequest, Model model){
        model.addAttribute("error", ex.getMessage());
        model.addAttribute("code", 500);
        return "error";
    }

}
