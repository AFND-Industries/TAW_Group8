package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.RutinaRepository;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Usuario;
import com.example.GymWebAppSpring.util.AuthUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/entrenador/rutinas")
public class EntrenadorControllerCRUD {

    @Autowired
    protected RutinaRepository rutinaRepository;

    @GetMapping("")
    public String doRutinas(HttpSession session, Model model) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        Usuario entrenador = AuthUtils.getUser(session);
        List<Rutina> rutinas = rutinaRepository.findRutinaByEntrenadorId(entrenador);
        model.addAttribute("rutinas", rutinas);

        return "/entrenador/crud/rutinas";
    }

    @GetMapping("/crear")
    public String doCrearRutina() {
        return "/entrenador/crud/crear_rutina";
    }

    @GetMapping("/editar")
    public String doEditarRutina() {
        return "redirect:/entrenador/rutinas/crear";
    }

    @GetMapping("/ver")
    public String doVerRutina() {
        return "redirect:/entrenador/rutinas/crear";
    }

    @GetMapping("/crear/sesion")
    public String doCrearSesion() {
        return "/entrenador/crud/crear_sesion";
    }

    @GetMapping("/crear/ejercicio")
    public String doCrearEjercicio() {
        return "/entrenador/crud/crear_ejercicio_sesion";
    }

    @GetMapping("/crear/ejercicio/seleccionar")
    public String doSeleccionarEjercicio() {
        return "/entrenador/crud/seleccionar_ejercicio";
    }

    @GetMapping("/crear/ejercicio/ver")
    public String doEjercicioBase() {
        return "/entrenador/crud/ejercicio_base";
    }
}
