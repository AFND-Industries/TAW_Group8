package com.example.GymWebAppSpring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EntrenadorControllerCRUD {

    @GetMapping("/entrenador")
    public String doInicio() {
        return "/entrenador/inicio";
    }

    @GetMapping("/entrenador/rutinas")
    public String doRutinas() {
        return "/entrenador/crud/rutinas";
    }
}
