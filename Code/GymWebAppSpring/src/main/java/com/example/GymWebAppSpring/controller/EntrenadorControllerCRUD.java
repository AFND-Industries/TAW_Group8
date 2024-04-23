package com.example.GymWebAppSpring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EntrenadorControllerCRUD {

    @GetMapping("/entrenador")
    public String doInicio() {
        return "/entrenador/inicio";
    }

    @GetMapping("/entrenador/rutinas")
    public String doRutinas() {
        return "/entrenador/crud/rutinas";
    }

    @GetMapping("/entrenador/rutinas/crear")
    public String doCrearRutina() {
        return "/entrenador/crud/crear_rutina";
    }

    @GetMapping("/entrenador/rutinas/crear/sesion")
    public String doCrearSesion() {
        return "/entrenador/crud/crear_sesion";
    }

    @GetMapping("/entrenador/rutinas/crear/ejercicio")
    public String doCrearEjercicio() {
        return "/entrenador/crud/crear_ejercicio";
    }

    @GetMapping("/entrenador/rutinas/crear/ejercicio/seleccionar")
    public String doSeleccionarEjercicio() {
        return "/entrenador/crud/seleccionar_ejercicio";
    }
}
