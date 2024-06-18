package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dto.*;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.service.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.lang3.tuple.Triple;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping("/client")
public class ClienteController {

    protected InformacionejercicioService informacionejercicioService;

    protected InformacionsesionService informacionsesionService;

    protected RutinaclienteService rutinaclienteService;

    protected EjerciciosesionService ejerciciosesionService;

    protected SesionEntrenamientoService sesionEntrenamientoService;


    @GetMapping("")
    public String doClient(HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        UsuarioDTO user = (UsuarioDTO) sesion.getAttribute("user");
        List<RutinaclienteDTO> rutinas = rutinaclienteService.findByUsuario(user.getId());
        modelo.addAttribute("usuario", user);
        modelo.addAttribute("rutinas", rutinas);
        return "client/clientePersonalSpace";


    }

    @GetMapping("/rutina")
    public String doVerRutina(@RequestParam("rutinaElegida") RutinaDTO rutina, HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";


        List<Triple<SesionentrenamientoDTO, Integer, Integer>> sesionesEjercicios = new ArrayList<>();
        List<SesionentrenamientoDTO> sesionesEntrenamiento = sesionEntrenamientoService.findByRutina(rutina.getId());


        for (SesionentrenamientoDTO sesion : sesionesEntrenamiento) {
            List<EjerciciosesionDTO> ejercicos = ejerciciosesionService.findBySesion(sesion.getId());
            List<InformacionejercicioDTO> informacionEjercicios = informacionejercicioService.findBySesionentrenamiento(sesion.getId());
            int numEjercicios = ejercicos.size();
            int numEjerciciosCompletados = informacionEjercicios.size();
            sesionesEjercicios.add(Triple.of(sesion, numEjercicios, numEjerciciosCompletados));
        }
        modelo.addAttribute("rutina", rutina);
        modelo.addAttribute("sesionesEjercicios", sesionesEjercicios);


        return "client/verRutina";


    }

    @GetMapping("rutina/sesion/ejercicio")
    public String doVerEjercicio(@RequestParam("sesionEntrenamiento") SesionentrenamientoDTO sesionEntrenamiento,
                                 @RequestParam(value = "ejercicioIndex", required = false, defaultValue = "0") Integer ejercicioIndex,
                                 HttpSession session, Model modelo) {

        if (!AuthUtils.isClient(session))
            return "redirect:/";

        ejercicioIndex = (ejercicioIndex < 0) ? 0 : ejercicioIndex;

        List<EjerciciosesionDTO> ejercicios = ejerciciosesionService.findBySesion(sesionEntrenamiento.getId());

        if (ejercicioIndex >= ejercicios.size()) //Ya ha acabado los ejercicos por lo que hay que valorarlos
            return "redirect:/client/rutina/sesion/valorarEntrenamiento?sesionEntrenamiento=" + sesionEntrenamiento.getId();

        if (ejercicioIndex == 0) { //Comprobar si ya ha hecho algun ejercicio
            List<InformacionejercicioDTO> informacionEjercicios = informacionejercicioService.findBySesionentrenamiento(sesionEntrenamiento.getId());
            if (informacionEjercicios != null && !informacionEjercicios.isEmpty()) {
                int lastExer = informacionEjercicios.indexOf(informacionEjercicios.getFirst());
                ejercicioIndex = lastExer + 1;
            }
        }
        Gson gson = new Gson();
        EjerciciosesionDTO ejercicioSesion = ejercicios.get(ejercicioIndex);
        HashMap<String, String> especificaciones = gson.fromJson(ejercicioSesion.getEspecificaciones(), HashMap.class);


        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        modelo.addAttribute("ejercicioSesion", ejercicios.get(ejercicioIndex));
        modelo.addAttribute("ejercicioIndex", ejercicioIndex);

        return "client/verEjercicio";
    }

    @PostMapping("rutina/sesion/ejercicio/guardar")
    public String doGuardarEjercicio(@RequestParam("sesionEntrenamiento") SesionentrenamientoDTO sesionEntrenamiento,
                                     @RequestParam("resultados") String resultados,
                                     @RequestParam("ejercicioIndex") Integer ejercicioIndex,
                                     HttpSession session) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");

        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());
        if (informacionSesion == null) {
            informacionSesion = new InformacionsesionDTO();
            informacionSesion.setComentario("NaN");
            informacionSesion.setValoracion(0);
            informacionSesion.setSesionentrenamiento(sesionEntrenamiento);
            informacionSesion.setUsuario(user);
            informacionsesionService.save(informacionSesion);
        }
        List<InformacionejercicioDTO> informacionEjercicioLista = informacionejercicioService.findBySesionentrenamiento(sesionEntrenamiento.getId());
        InformacionejercicioDTO informacionEjercicio;
        if (informacionEjercicioLista.size() <= ejercicioIndex) {
            informacionEjercicio = new InformacionejercicioDTO();
            informacionEjercicio.setEjerciciosesion(ejerciciosesionService.findBySesion(sesionEntrenamiento.getId()).get(ejercicioIndex));
            informacionEjercicio.setInformacionsesion(informacionSesion);
        } else {
            informacionEjercicio = informacionEjercicioLista.get(ejercicioIndex);
        }
        informacionEjercicio.setEvaluacion(resultados);
        informacionejercicioService.save(informacionEjercicio);


        return "redirect:/client/rutina/sesion/ejercicio?sesionEntrenamiento=" + sesionEntrenamiento.getId() + "&ejercicioIndex=" + (ejercicioIndex + 1);


    }

    @PostMapping("rutina/sesion/ejercicio/modificar")
    public String doModificarEjercicio(@RequestParam("sesionEntrenamiento") SesionentrenamientoDTO sesionEntrenamiento,
                                       @RequestParam("resultados") String resultados,
                                       @RequestParam(value = "ejercicioSesion") EjerciciosesionDTO ejerciciosesion,
                                       HttpSession session) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");

        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());
        InformacionejercicioDTO informacionEjercicio = informacionejercicioService.findByEjerciciosesionAndInformacionsesion(ejerciciosesion.getId(), informacionSesion.getId());
        informacionEjercicio.setEvaluacion(resultados);
        informacionejercicioService.save(informacionEjercicio);
        return "redirect:/client/rutina/sesion/desempenyo?sesionEntrenamiento=" + sesionEntrenamiento.getId();


    }


    @GetMapping("rutina/sesion/valorarEntrenamiento")
    public String doValorarEntrenamiento(@RequestParam("sesionEntrenamiento") SesionentrenamientoDTO sesionEntrenamiento,
                                         @RequestParam(value = "informacionSesion", required = false) InformacionsesionDTO informacionSesionModif,
                                         HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        InformacionsesionDTO informacionSesion;
        if (informacionSesionModif == null) {
            informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());
        } else {
            informacionSesion = informacionSesionModif;
        }

        if (informacionSesion == null)
            return "redirect:/client";


        modelo.addAttribute("informacionSesion", informacionSesion);
        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);


        return "client/verValorarSesion";
    }

    @PostMapping("rutina/sesion/valorarEntrenamiento/guardar")
    public String doGuardarValoracionSesion(@RequestParam("sesionEntrenamiento") SesionentrenamientoDTO sesionEntrenamiento,
                                            @RequestParam("comentario") String comentario,
                                            @RequestParam("rating") String rating,
                                            HttpSession session) {


        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());
        if (informacionSesion == null)
            return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();

        informacionSesion.setComentario(comentario);
        informacionSesion.setValoracion(Integer.parseInt(rating));
        informacionSesion.setFechaFin(LocalDate.now());
        informacionsesionService.save(informacionSesion);


        return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();
    }

    @GetMapping("/rutina/sesion/desempenyo")
    public String doDesempenyo(@RequestParam("sesionEntrenamiento") SesionentrenamientoDTO sesionEntrenamiento,
                               HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("user");
        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(usuario.getId(), sesionEntrenamiento.getId());
        if (informacionSesion == null)
            return "redirect:/client";

        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        modelo.addAttribute("informacionSesion", informacionSesion);
        HashMap<EjerciciosesionDTO, InformacionejercicioDTO> ejercicios = new HashMap<>();
        List<EjerciciosesionDTO> ejerciciosSesion = ejerciciosesionService.findBySesion(sesionEntrenamiento.getId());
        for (EjerciciosesionDTO e : ejerciciosSesion) {
            InformacionejercicioDTO informacionEjercicio = informacionejercicioService.findByEjerciciosesionAndInformacionsesion(e.getId(), informacionSesion.getId());
            ejercicios.put(e, informacionEjercicio);
        }
        modelo.addAttribute("ejercicios", ejercicios);
        return "client/verDesempenyo";
    }

    @PostMapping("/rutina/sesion/desempenyo/borrar")
    public String doBorrarDesempenyo(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento, HttpSession session) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("user");
        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(usuario.getId(), sesionEntrenamiento.getId());
        List<InformacionejercicioDTO> informacionEjercicios = informacionejercicioService.findBySesionentrenamiento(sesionEntrenamiento.getId());
        if (informacionSesion == null)
            return "redirect:/client";
        informacionejercicioService.deleteAll(informacionEjercicios);
        informacionsesionService.delete(informacionSesion);


        return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();
    }

}
