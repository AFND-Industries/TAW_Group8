package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.entity.Entrenadorasignado;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Rutinacliente;
import com.example.GymWebAppSpring.entity.Usuario;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.example.GymWebAppSpring.dao.EntrenadorAsignadoRepository;
import com.example.GymWebAppSpring.dao.RutinaUsuarioRepository;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class EntrenadorControllerCientes {

    @Autowired
    private EntrenadorAsignadoRepository entrenadorAsignadoRepository;
    @Autowired
    private RutinaUsuarioRepository rutinaUsuarioRepository;

    @GetMapping("/entrenador/clientes")
    public String entrenadorClientes(Model model) {
        List<Usuario> clientesAsignados = entrenadorAsignadoRepository.findClientsByEntrenadorID(4);
        model.addAttribute("clientes", clientesAsignados);
        return "/entrenador/clientes/clientes";
    }

    @PostMapping("/entrenador/clientes/rutinas")
    public String doListarRutinas(@RequestParam("id") int id, Model model){
        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaById(id);
        model.addAttribute("rutinas", rutinas);
        return "rutinas";
    }
}
