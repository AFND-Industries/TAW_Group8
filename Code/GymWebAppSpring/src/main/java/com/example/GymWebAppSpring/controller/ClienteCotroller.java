package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.RutinaUsuarioRepository;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Usuario;
import com.example.GymWebAppSpring.util.AuthUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ClienteCotroller {

    @Autowired
    private RutinaUsuarioRepository rutinaUsuarioRepository;

    @GetMapping("/client")
    public String doClient(HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        Usuario user = (Usuario) sesion.getAttribute("user");
        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaByUsuario(user);
        modelo.addAttribute("usuario", user);
        modelo.addAttribute( "rutinas", rutinas);
        return "client/clientePersonalSpace";


    }
}
