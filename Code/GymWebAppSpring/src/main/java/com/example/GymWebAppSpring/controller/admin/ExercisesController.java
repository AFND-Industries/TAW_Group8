package com.example.GymWebAppSpring.controller.admin;

import com.example.GymWebAppSpring.dao.EjercicioRepository;
import com.example.GymWebAppSpring.entity.Ejercicio;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import static com.example.GymWebAppSpring.util.AuthUtils.isAdmin;

import java.util.List;

@Controller
@RequestMapping("/admin/exercises")
public class ExercisesController {

    @Autowired
    private EjercicioRepository ejercicioRepository;

    @GetMapping("/")
    public String ejerciciosPage(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("ejercicios", ejercicioRepository.findAll());

        return "admin/exercises/list-exercises";
    }

    @PostMapping("/")
    public String ejerciciosFilteres(Model model){
        List<Ejercicio> list = ejercicioRepository.findAll();

        model.addAttribute("ejercicios",list);

        return "admin/exercises/list-exercises";
    }
}
