package com.example.GymWebAppSpring.controller.admin;

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

@Controller
public class SessionController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    /* ------------------------- Auth Functions */
    @GetMapping("/login")
    public String loginPage(){
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("dni") String dni, @RequestParam("clave") String password, Model model, HttpSession session) {
        String passDigest = HashUtils.hashString(password);
        Usuario usuario = usuarioRepository.findUsuarioByDniAndClave(dni,passDigest);
        if (usuario != null){
            session.setAttribute("user",usuario);
            if (AuthUtils.isTrainer(session))
                return "redirect:/entrenador";
            else if (AuthUtils.isAdmin(session))
                return "redirect:/admin/dashboard";
            else
                return "redirect:/client";
        }

        model.addAttribute("error", "El usuario o la contraseña no son válidos");
        return "auth/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }
    /* ------------------------- End Auth Functions */
}
