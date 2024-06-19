package com.example.GymWebAppSpring.controller.rest;

import com.example.GymWebAppSpring.dto.EjerciciosesionDTO;
import com.example.GymWebAppSpring.service.EjerciciosesionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/ejercicios-sesion")
public class EjerciciosesionControllerRest {

    @Autowired
    protected EjerciciosesionService ejerciciosesionService;

    @GetMapping("/")
    public List<EjerciciosesionDTO> listarEjerciciosSesion() {
        return ejerciciosesionService.findAll();
    }

    @GetMapping("/buscar/sesion/{sesionId}")
    public List<EjerciciosesionDTO> listarEjerciciosPorSesion(@PathVariable("sesionId") Integer sesionId) {
        return ejerciciosesionService.findBySesion(sesionId);
    }

    @GetMapping("/{id}")
    public EjerciciosesionDTO buscarEjercicioSesion(@PathVariable("id") Integer id) {
        return ejerciciosesionService.findById(id);
    }

    @PostMapping("/")
    public void guardarEjercicioSesion(@RequestBody EjerciciosesionDTO ejerciciosesionDTO) {
        ejerciciosesionService.save(ejerciciosesionDTO);
    }

    @DeleteMapping("/{id}")
    public void borrarEjercicioSesion(@PathVariable("id") Integer id) {
        ejerciciosesionService.delete(id);
    }

    @DeleteMapping("/borrar-todos")
    public void borrarTodosEjerciciosSesion(@RequestBody List<Integer> ejerciciosSesionIds) {
        ejerciciosesionService.deleteAllById(ejerciciosSesionIds);
    }
}
