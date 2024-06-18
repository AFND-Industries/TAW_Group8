package com.example.GymWebAppSpring.controller.rest;

import com.example.GymWebAppSpring.dto.EjercicioDTO;
import com.example.GymWebAppSpring.service.EjercicioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/ejercicios")
public class EjercicioControllerRest {

    @Autowired
    protected EjercicioService ejercicioService;

    @GetMapping("/")
    public List<EjercicioDTO> listarEjercicios() {
        return ejercicioService.findAll();
    }

    @GetMapping("/buscar/sesion/{sesionId}")
    public List<EjercicioDTO> listarEjerciciosPorSesion(@PathVariable("sesionId") Integer sesionId) {
        return ejercicioService.findEjercicioBySesion(sesionId);
    }

    @GetMapping("/buscar/ids")
    public List<EjercicioDTO> listarEjerciciosPorIds(@RequestBody List<Integer> ids) {
        return ejercicioService.findEjercicioByIds(ids);
    }

    @GetMapping("/fuerza")
    public List<EjercicioDTO> listarEjerciciosFuerza() {
        return ejercicioService.findAllEjerciciosFuerza();
    }

    @GetMapping("/categoria/{categoriaId}")
    public List<EjercicioDTO> listarEjerciciosPorCategoria(@PathVariable("categoriaId") Integer categoriaId) {
        return ejercicioService.findAllByCategoria(categoriaId);
    }

    @GetMapping("/musculo/{musculoId}")
    public List<EjercicioDTO> listarEjerciciosPorMusculo(@PathVariable("musculoId") Integer musculoId) {
        return ejercicioService.findAllByMusculo(musculoId);
    }

    @GetMapping("/nombre/{nombre}")
    public List<EjercicioDTO> listarEjerciciosPorNombre(@PathVariable("nombre") String nombre) {
        return ejercicioService.findAllByNombre(nombre);
    }

    @GetMapping("/{id}")
    public EjercicioDTO buscarEjercicio(@PathVariable("id") Integer id) {
        return ejercicioService.findById(id);
    }

    @PostMapping("/")
    public void guardarEjercicio(@RequestBody EjercicioDTO ejercicioDTO) {
        ejercicioService.save(ejercicioDTO);
    }

    @DeleteMapping("/{id}")
    public void borrarEjercicio(@PathVariable("id") Integer id) {
        ejercicioService.delete(id);
    }
}
