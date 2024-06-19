package com.example.GymWebAppSpring.controller.entrenador.crud;

import com.example.GymWebAppSpring.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

public class BaseController {

    @Autowired
    protected RutinaService rutinaService;

    @Autowired
    protected DificultadService dificultadService;

    @Autowired
    protected SesionEntrenamientoService sesionEntrenamientoService;

    @Autowired
    protected EjerciciosesionService ejercicioSesionService;

    @Autowired
    protected EjercicioService ejercicioService;

    public void flushContext(HttpSession session) {
        session.removeAttribute("cache");
        session.removeAttribute("sesionPos");
        session.removeAttribute("oldSesion");
    }
}
