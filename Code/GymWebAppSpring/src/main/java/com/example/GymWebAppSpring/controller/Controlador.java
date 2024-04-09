package com.example.GymWebAppSpring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class Controlador {
    @GetMapping("/example")
    public String example(@RequestParam(value = "name", required = false) String name, Model model) {
        model.addAttribute("name", name);
        return "index";
    }
}
