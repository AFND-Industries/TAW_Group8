package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.entity.Usuario;
import com.example.GymWebAppSpring.util.AuthUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ClienteCotroller {


    @GetMapping("/client")
    public String doClient(HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";

        modelo.addAttribute("usuario", sesion.getAttribute("user"));
        return "client/clientePersonalSpace";


    }
}
