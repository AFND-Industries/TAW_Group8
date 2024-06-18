package com.example.GymWebAppSpring.controller.rest;

import com.example.GymWebAppSpring.dto.SesionentrenamientoDTO;
import com.example.GymWebAppSpring.service.SesionEntrenamientoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/sesiones-entrenamiento")
public class SesionEntrenamientoControllerRest {

    @Autowired
    protected SesionEntrenamientoService sesionEntrenamientoService;

    @GetMapping("/")
    public List<SesionentrenamientoDTO> listarSesionesEntrenamiento() {
        return sesionEntrenamientoService.findAll();
    }

    @GetMapping("/buscar/{rutinaId}")
    public List<SesionentrenamientoDTO> listarSesionesPorRutina(@PathVariable("rutinaId") Integer rutinaId) {
        return sesionEntrenamientoService.findByRutina(rutinaId);
    }

    @GetMapping("/{id}")
    public SesionentrenamientoDTO buscarSesionEntrenamiento(@PathVariable("id") Integer id) {
        return sesionEntrenamientoService.findById(id);
    }

    @PostMapping("/")
    public void guardarSesionEntrenamiento(@RequestBody SesionentrenamientoDTO sesionentrenamientoDTO) {
        sesionEntrenamientoService.save(sesionentrenamientoDTO);
    }

    @DeleteMapping("/{id}")
    public void borrarSesionEntrenamiento(@PathVariable("id") Integer id) {
        sesionEntrenamientoService.delete(id);
    }

    @DeleteMapping("/borrar-todas")
    public void borrarTodasSesiones(@RequestBody List<Integer> sesionesIds) {
        sesionEntrenamientoService.deleteAll(sesionesIds);
    }
}
