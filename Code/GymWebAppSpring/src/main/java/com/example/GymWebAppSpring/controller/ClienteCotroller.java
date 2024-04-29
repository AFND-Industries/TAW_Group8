package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.EjercicioSesionRepository;
import com.example.GymWebAppSpring.dao.RutinaUsuarioRepository;
import com.example.GymWebAppSpring.dao.SesionRutinaRepository;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/client")
public class ClienteCotroller {

    @Autowired
    private RutinaUsuarioRepository rutinaUsuarioRepository;

    @Autowired
    private SesionRutinaRepository sesionRutinaRepository;

    @Autowired
    private EjercicioSesionRepository ejerciciosesionRepository;
    @GetMapping("")
    public String doClient(HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        Usuario user = (Usuario) sesion.getAttribute("user");
        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaByUsuario(user);
        modelo.addAttribute("usuario", user);
        modelo.addAttribute( "rutinas", rutinas);
        return "client/clientePersonalSpace";


    }

    @PostMapping("/verrutina")
    public String doVerRutina(@RequestParam("rutinaElegida") Rutina rutina,HttpSession sesion, Model modelo  ) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        Map<Sesionrutina, List<Ejerciciosesion>> sesionesEjercicios = new HashMap<>();


        Usuario user = (Usuario) sesion.getAttribute("user");
        modelo.addAttribute("usuario", user);
        List<Sesionrutina> sesiones = sesionRutinaRepository.findSesionRutinaByRutina(rutina);
        for(Sesionrutina s : sesiones){
            List<Ejerciciosesion> ejercicos = ejerciciosesionRepository.findEjerciciosBySesion(s.getSesionentrenamiento());
            sesionesEjercicios.put(s, ejercicos);
        }

        modelo.addAttribute("sesionesEjercicios", sesionesEjercicios);


        return "client/verrutina";


    }
}
