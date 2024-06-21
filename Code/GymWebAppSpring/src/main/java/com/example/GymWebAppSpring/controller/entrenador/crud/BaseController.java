package com.example.GymWebAppSpring.controller.entrenador.crud;

import com.example.GymWebAppSpring.dto.EjerciciosesionDTO;
import com.example.GymWebAppSpring.dto.RutinaDTO;
import com.example.GymWebAppSpring.dto.SesionentrenamientoDTO;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.iu.RutinaArgument;
import com.example.GymWebAppSpring.iu.SesionArgument;
import com.example.GymWebAppSpring.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

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

    public void flushSesionEntrenamiento(HttpSession session) {
        session.removeAttribute("sesionPos");
        session.removeAttribute("oldSesion");
    }

    public void flushContext(HttpSession session) {
        session.removeAttribute("cache");
        flushSesionEntrenamiento(session);
    }

    public RutinaArgument createRutinaArgument(Integer rutinaId) {
        RutinaDTO rutinaDTO = rutinaService.findById(rutinaId);
        List<SesionentrenamientoDTO> sesionesDTO = sesionEntrenamientoService.findByRutina(rutinaDTO.getId());;

        List<SesionArgument> sesionesArgument = new ArrayList<>();
        for (SesionentrenamientoDTO sesionDTO : sesionesDTO) {
            List<EjerciciosesionDTO> ejerciciosDTO = ejercicioSesionService.findBySesion(sesionDTO.getId());
            SesionArgument sesionArgument = new SesionArgument(sesionDTO, ejerciciosDTO);
            sesionesArgument.add(sesionArgument);
        }

        return new RutinaArgument(rutinaDTO, sesionesArgument);
    }
}
