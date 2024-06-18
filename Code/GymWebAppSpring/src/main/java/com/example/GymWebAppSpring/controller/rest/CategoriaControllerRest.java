package com.example.GymWebAppSpring.controller.rest;

import com.example.GymWebAppSpring.dto.CategoriaDTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.service.CategoriaService;
import com.example.GymWebAppSpring.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/category")
public class CategoriaControllerRest {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/")
    public List<CategoriaDTO> listarUsuarios(){
        return categoriaService.findAll();
    }

    @GetMapping("/{id}")
    public CategoriaDTO findById(@PathVariable("id") int id){
        return categoriaService.findById(id);
    }

}
