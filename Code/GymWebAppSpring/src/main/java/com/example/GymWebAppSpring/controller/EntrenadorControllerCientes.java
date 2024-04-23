package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.SesioRutinaRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
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
    @Autowired
    private UsuarioRepository usuarioRepository;
    @Autowired
    private SesioRutinaRepository sesioRutinaRepository;

    @GetMapping("/entrenador/clientes")
    public String entrenadorClientes(Model model) {
        List<Usuario> clientesAsignados = entrenadorAsignadoRepository.findClientsByEntrenadorID(4);
        model.addAttribute("clientes", clientesAsignados);
        return "/entrenador/clientes/clientes";
    }

    @GetMapping("/entrenador/clientes/rutinas")
    public String doListarRutinas(@RequestParam("id") int id, Model model){
        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaById(id);
        Usuario usuario = usuarioRepository.findUsuarioById(id);
        int[] numSesiones = new int[rutinas.size()];
        for(Rutina rutina : rutinas){
            numSesiones[rutinas.indexOf(rutina)] = sesioRutinaRepository.findNumberSesionsByRutinaId(rutina.getId());
        }
        model.addAttribute("numSesiones", numSesiones);
        model.addAttribute("rutinas", rutinas);
        model.addAttribute("usuario", usuario);
        return "/entrenador/clientes/rutinas";
    }
}
