package com.example.GymWebAppSpring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EntrenadorControllerCientes {

    @GetMapping("/entrenador/clientes")
    public String entrenadorClientes() {
        return "header";
    }
}
