package com.example.GymWebAppSpring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EntrenadorController {

    @GetMapping("/entrenador")
    public String doInicio() {
        return "/entrenador/inicio";
    }
}