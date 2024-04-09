package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.entity.UsuarioEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class Controlador {

    @Autowired
    protected UsuarioRepository usuarioRepository;

    @GetMapping("/")
    public String example(Model model) {
        List<UsuarioEntity> usuario = this.usuarioRepository.findAll();

        model.addAttribute("usuarios", usuario);

        return "index";
    }

    @GetMapping("/crear")
    public String doCrear() {
        return "redirect:/";
    }
}
