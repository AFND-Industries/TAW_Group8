package com.example.GymWebAppSpring.controller.rest;

import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/users")
public class UsuarioControllerRest {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/")
    public List<UsuarioDTO> listarUsuarios(){
        return usuarioService.findAll();
    }

    @GetMapping("/{id}")
    public UsuarioDTO findById(@PathVariable("id") int id){
        return usuarioService.findById(id);
    }

    @GetMapping("/dni/{dni}")
    public List<UsuarioDTO> findById(@PathVariable("dni") String id){
        return usuarioService.findUsuarioByDNI(id);
    }

}
