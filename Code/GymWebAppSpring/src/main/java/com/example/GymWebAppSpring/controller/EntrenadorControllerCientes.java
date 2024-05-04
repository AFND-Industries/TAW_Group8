package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.*;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class EntrenadorControllerCientes {


    @Autowired
    private RutinaUsuarioRepository rutinaUsuarioRepository;

    @Autowired
    private EntrenadorAsignadoRepository entrenadorAsignadoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    //@Autowired
    //private SesionRutinaRepository sesioRutinaRepository;

    @Autowired
    private RutinaClienteReporsitory rutinaClienteReporsitory;

    @Autowired
    private RutinaRepository rutinaRepository;

    @Autowired
    private EjercicioSesionRepository ejercicioSesionRepository;

    //@Autowired
    //private SesionRutinaRepository sesionRutinaRepository;

    @Autowired
    private InformacionSesionRepository informacionSesionRepository;

    @Autowired
    private InformacionEjercicioRepository informacionEjercicioRepository;

    @GetMapping("/entrenador/clientes")
    public String entrenadorClientes(Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        List<Usuario> clientesAsignados = entrenadorAsignadoRepository.findClientsByEntrenadorID(AuthUtils.getUser(session));
        model.addAttribute("clientes", clientesAsignados);
        return "/entrenador/clientes/clientes_entrenador";
    }

    @GetMapping("/entrenador/clientes/rutinas")
    public String doListarRutinas(@RequestParam("id") Usuario usuario, Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaById(usuario.getId());
        int[] numSesiones = new int[rutinas.size()];
        for (Rutina rutina : rutinas) {
            //numSesiones[rutinas.indexOf(rutina)] = sesioRutinaRepository.findSesionsByRutina(rutina).size();
        }
        model.addAttribute("numSesiones", numSesiones);
        model.addAttribute("rutinas", rutinas);
        model.addAttribute("usuario", usuario);
        return "/entrenador/clientes/rutinas_clientes_entrenador";
    }

    @GetMapping("/entrenador/clientes/rutinas/anyadirRutina")
    public String doAnyadirRutina(@RequestParam("id") int id, HttpSession session, Model model) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        List<Rutina> rutinasCliente = rutinaUsuarioRepository.findRutinaById(id);
        List<Rutina> rutinasEntrenador = rutinaRepository.findRutinaByEntrenadorId(AuthUtils.getUser(session));

        model.addAttribute("rutinasCliente", rutinasCliente);
        model.addAttribute("rutinasEntrenador", rutinasEntrenador);
        model.addAttribute("id", id);

        return "/entrenador/clientes/anyadir_rutina_cliente";
    }

    @PostMapping("/entrenador/clientes/rutinas/guardar")
    public String doGuardarRutina(@RequestParam("idCliente") Usuario usuario,
                                  @RequestParam("rutinas") List<Rutina> rutinas,
                                  HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        List<Rutina> rutinasCliente = rutinaUsuarioRepository.findRutinaById(usuario.getId());

        for (Rutina rutina : rutinas) {
            if (!rutinasCliente.contains(rutina)) {
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
    public String doEliminarRutina(@RequestParam("idRutina") Rutina rutina,
                                   @RequestParam("idCliente") Usuario cliente,
                                   HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        RutinaclienteId rutinaclienteId = new RutinaclienteId();
        rutinaclienteId.setRutinaId(rutina.getId());
        rutinaclienteId.setUsuarioId(cliente.getId());
        Rutinacliente rutinaCliente = rutinaClienteReporsitory.findById(rutinaclienteId).orElse(null);
        rutinaClienteReporsitory.delete(rutinaCliente);
        return "redirect:/entrenador/clientes/rutinas?id=" + cliente.getId();
    }

    @GetMapping("/entrenador/clientes/rutinas/verRutina")
    public String doVerRutina(@RequestParam("idRutina") Rutina rutina,
                              @RequestParam("idCliente") Usuario cliente,
                              Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        //List<Sesionentrenamiento> sesiones = sesioRutinaRepository.findSesionsByRutina(rutina);
        List<Ejerciciosesion> ejercicios = new ArrayList<>();
        Informacionsesion informacionSesion = new Informacionsesion();
        Gson gson = new Gson();
        List<Integer> porcentaje = new ArrayList<>();
        int i = 0;
        int total = 0;
        /*for (Sesionentrenamiento sesion : sesiones) {
            ejercicios = ejercicioSesionRepository.findEjerciciosBySesion(sesion);
            for (Ejerciciosesion ejercicio : ejercicios) {
                ;
                total += Integer.parseInt(gson.fromJson(ejercicio.getEspecificaciones(), JsonObject.class).get("series").getAsString());
            }
            informacionSesion = informacionSesionRepository.findByUsuarioAndSesion(cliente, sesion);
            for (Ejerciciosesion ejercicio : ejercicios) {
                Informacionejercicio info = informacionEjercicioRepository.findByEjercicioAndInfo(informacionSesion, ejercicio);
                i += (gson.fromJson(info.getEvaluacion(), JsonArray.class).size());
            }
            porcentaje.add((i * 100) / total);
            i = 0;
            total = 0;
        }*/

        model.addAttribute("rutina", rutina);
        //model.addAttribute("sesiones", sesiones);
        model.addAttribute("cliente", cliente);
        model.addAttribute("porcentaje", porcentaje);

        return "/entrenador/clientes/ver_rutina_cliente";
    }

    @GetMapping("/entrenador/clientes/rutinas/verSesion")
    public String doVerSesion(@RequestParam("idSesion") Sesionentrenamiento sesion,
                              @RequestParam("idCliente") Usuario cliente,
                              Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        List<Ejerciciosesion> ejercicios = ejercicioSesionRepository.findEjerciciosBySesion(sesion);
        Informacionsesion informacionSesion = informacionSesionRepository.findByUsuarioAndSesion(cliente, sesion);
        Gson gson = new Gson();
        List<Integer> sesionesEjercicios = new ArrayList<>();
        for (Ejerciciosesion ejercicio : ejercicios) {
            Informacionejercicio info = informacionEjercicioRepository.findByEjercicioAndInfo(informacionSesion, ejercicio);
            sesionesEjercicios.add(gson.fromJson(info.getEvaluacion(), JsonArray.class).size());
        }

        model.addAttribute("sesion", sesion);
        model.addAttribute("ejercicios", ejercicios);
        model.addAttribute("informacionSesion", informacionSesion);
        model.addAttribute("cliente", cliente);
        model.addAttribute("sesionesEjercicios", sesionesEjercicios);

        return "/entrenador/clientes/ver_sesion_cliente";
    }

    @GetMapping("/entrenador/clientes/rutinas/verSesion/verDesempeno")
    public String doVerDesempeno(@RequestParam("idEjercicio") Ejerciciosesion ejercicio,
                                 @RequestParam("idInfo") Informacionsesion informacionSesion,
                                 @RequestParam("idSesion") Sesionentrenamiento sesion,
                                 Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        Informacionejercicio informacionEjercicio = informacionEjercicioRepository.findByEjercicioAndInfo(informacionSesion, ejercicio);

        model.addAttribute("ejercicio", ejercicio.getEjercicio());
        model.addAttribute("informacionEjercicio", informacionEjercicio);
        model.addAttribute("sesion", sesion);

        Gson gson = new Gson();
        String repeticiones = gson.fromJson(ejercicio.getEspecificaciones(), JsonObject.class).get("repeticiones").getAsString();
        model.addAttribute("repeticionesTotales", repeticiones);

        return "/entrenador/clientes/ver_desempeno";
    }
}
