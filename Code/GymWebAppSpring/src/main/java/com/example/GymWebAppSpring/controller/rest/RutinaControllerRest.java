package com.example.GymWebAppSpring.controller.rest;

import com.example.GymWebAppSpring.dto.RutinaDTO;
import com.example.GymWebAppSpring.service.RutinaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rest/rutinas")
public class RutinaControllerRest {

    @Autowired
    protected RutinaService rutinaService;

    @GetMapping("/")
    public List<RutinaDTO> listarRutinas () {
        return rutinaService.findAll();
    }

    @GetMapping("/buscar/{entrenadorId}")
    public List<RutinaDTO> listarRutinas (@PathVariable("entrenadorId") Integer entrenadorId) {
        return rutinaService.findRutinaByEntrenadorId(entrenadorId);
    }

    @GetMapping("/buscar/{entrenadorId}/{nombre}/{limiteBajo}/{limiteAlto}/{dificultadId}")
    public List<RutinaDTO> listarRutinas (@PathVariable("entrenadorId") Integer entrenadorId,
                                          @PathVariable("nombre") String nombre,
                                          @PathVariable("limiteBajo") Integer limiteBajo,
                                          @PathVariable("limiteAlto") Integer limiteAlto,
                                          @PathVariable("dificultadId") Integer dificultadId) {
        return rutinaService.findRutinaByEntrenadorWithFilter(
                entrenadorId, nombre, limiteBajo, limiteAlto, dificultadId);
    }

    @GetMapping("/{id}")
    public RutinaDTO buscarRutina (@PathVariable("id") Integer id) {
        return rutinaService.findById(id);
    }

    @PostMapping("/")
    public void guardarRutina (@RequestBody RutinaDTO rutina) {
        this.rutinaService.save(rutina);
    }

    @DeleteMapping("/{id}")
    public void borrarRutina (@PathVariable("id") Integer id) {
        this.rutinaService.delete(id);
    }
}
