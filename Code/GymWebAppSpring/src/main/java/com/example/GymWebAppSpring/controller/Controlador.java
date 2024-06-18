package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.TipoUsuarioRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class Controlador {

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/entrenador")
    public String doInicio() {
        return "/entrenador/inicio";
    }

    // TODO: preguntar a profesor como podríamos implementar una pantalla de error
}
