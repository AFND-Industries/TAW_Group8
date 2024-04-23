package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.TipoUsuarioRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Controlador {

    @Autowired
    protected UsuarioRepository usuarioRepository;

    @Autowired
    protected TipoUsuarioRepository tipoUsuarioRepository;

    @GetMapping("/")
    public String example() {
        return "index";
    }

    @GetMapping("/crear")
    public String doCrear() {
        return "redirect:/";
    }

//    @GetMapping("/error")
//    public String doError(){
//        return "error";
//    }
}
