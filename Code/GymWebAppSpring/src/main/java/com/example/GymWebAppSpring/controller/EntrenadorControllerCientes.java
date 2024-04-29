package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.*;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class EntrenadorControllerCientes {

    @Autowired
    private RutinaUsuarioRepository rutinaUsuarioRepository;
    @Autowired
    private UsuarioRepository usuarioRepository;
    @Autowired
    private SesionRutinaRepository sesioRutinaRepository;
    @Autowired
    private RutinaClienteReporsitory rutinaClienteReporsitory;

    @GetMapping("/entrenador/clientes")
    public String entrenadorClientes(Model model, HttpSession session) {
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";
        List<Usuario> clientesAsignados = entrenadorAsignadoRepository.findClientsByEntrenadorID(4);
        model.addAttribute("clientes", clientesAsignados);
        return "/entrenador/clientes/clientes_entrenador";
    }

    @GetMapping("/entrenador/clientes/rutinas")
    public String doListarRutinas(@RequestParam("id") Usuario usuario, Model model, HttpSession session){
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";
        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaById(usuario.getId());
        int[] numSesiones = new int[rutinas.size()];
        for(Rutina rutina : rutinas){
            numSesiones[rutinas.indexOf(rutina)] = sesioRutinaRepository.findSesionsByRutina(rutina).size();
        }
        model.addAttribute("numSesiones", numSesiones);
        model.addAttribute("rutinas", rutinas);
        model.addAttribute("usuario", usuario);
        return "/entrenador/clientes/rutinas_clientes_entrenador";
    }

    @GetMapping("/entrenador/clientes/rutinas/anyadirRutina")
    public String doAnyadirRutina(@RequestParam("id") int id, HttpSession session, Model model){
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";
        List<Rutina> rutinasCliente = rutinaUsuarioRepository.findRutinaById(id);
        List<Rutina> rutinasEntrenador = rutinaUsuarioRepository.findRutinaByEntrenadorId(AuthUtils.getUser(session).getId());

        model.addAttribute("rutinasCliente", rutinasCliente);
        model.addAttribute("rutinasEntrenador", rutinasEntrenador);
        model.addAttribute("id", id);

        return "/entrenador/clientes/anyadir_rutina_cliente";
    }

    @PostMapping("/entrenador/clientes/rutinas/guardar")
    public String doGuardarRutina(@RequestParam("idCliente") Usuario usuario,
                                  @RequestParam("rutinas") List<Rutina> rutinas,
                                  HttpSession session){
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";
        List<Rutina> rutinasCliente = rutinaUsuarioRepository.findRutinaById(usuario.getId());

        for(Rutina rutina : rutinas){
            if(!rutinasCliente.contains(rutina)) {
                Rutinacliente rutinaCliente = new Rutinacliente();
                rutinaCliente.setRutina(rutina);
                rutinaCliente.setUsuario(usuario);
                rutinaCliente.setFechaInicio(rutina.getFechaCreacion());
                RutinaclienteId rutinaclienteId = new RutinaclienteId();
                rutinaclienteId.setRutinaId(rutina.getId());
                rutinaclienteId.setUsuarioId(usuario.getId());
                rutinaCliente.setId(rutinaclienteId);
                rutinaClienteReporsitory.save(rutinaCliente);
            }
        }


        return "redirect:/entrenador/clientes/rutinas?id=" + usuario.getId();

    }

    @GetMapping("/entrenador/clientes/rutinas/eliminarRutina")
    public String doEliminarRutina(@RequestParam("idRutina") int idRutina,
                                   @RequestParam("idCliente") int idCliente,
                                   HttpSession session){
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";
        RutinaclienteId rutinaclienteId = new RutinaclienteId();
        rutinaclienteId.setRutinaId(idRutina);
        rutinaclienteId.setUsuarioId(idCliente);
        Rutinacliente rutinaCliente = rutinaClienteReporsitory.findById(rutinaclienteId).orElse(null);
        rutinaClienteReporsitory.delete(rutinaCliente);
        return "redirect:/entrenador/clientes/rutinas?id=" + idCliente;
    }

    @GetMapping("/entrenador/clientes/rutinas/verRutina")
    public String doVerRutina(@RequestParam("id") Rutina rutina, Model model, HttpSession session){
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";

        List<Sesionentrenamiento> sesiones = sesioRutinaRepository.findSesionsByRutina(rutina);

        model.addAttribute("rutina", rutina);
        model.addAttribute("sesiones", sesiones);

        return "/entrenador/clientes/ver_rutina_cliente";
    }
}
