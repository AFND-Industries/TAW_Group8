package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.TipoUsuarioRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.entity.Usuario;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.example.GymWebAppSpring.util.HashUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

import static com.example.GymWebAppSpring.util.AuthUtils.*;

@Controller
public class Controlador {

    @Autowired
    protected UsuarioRepository usuarioRepository;

    @Autowired
    protected TipoUsuarioRepository tipoUsuarioRepository;

    @GetMapping("/")
    public String example(Model model, HttpSession session) {
        List<Usuario> usuario = this.usuarioRepository.findAll();

        if (session.getAttribute("user") == null)
            session.setAttribute("user", usuario.get(2));

        model.addAttribute("usuarios", usuario);

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
