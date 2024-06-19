package com.example.GymWebAppSpring.controller.entrenador.crud;

import com.example.GymWebAppSpring.dto.*;
import com.example.GymWebAppSpring.iu.*;
import com.example.GymWebAppSpring.util.AuthUtils;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/entrenador/rutinas/crear/rutina")
public class RutinaController extends BaseController {

    @GetMapping("/ver")
    public String doVerRutina(@RequestParam("id") Integer id,
                              Model model, HttpSession session) {
        RutinaDTO r = rutinaService.findById(id);
        List<SesionentrenamientoDTO> ss = sesionEntrenamientoService.findByRutina(r.getId());;
        List<SesionArgument> sesiones = new ArrayList<>();
        for (SesionentrenamientoDTO s : ss) {
            int sesionId = s.getId();
            List<EjerciciosesionDTO> ee = ejercicioSesionService.findBySesion(sesionId);
            sesiones.add(new SesionArgument(s, ee));
        }
        RutinaArgument rutina = new RutinaArgument(r, sesiones);

        session.setAttribute("cache", rutina);
        model.addAttribute("readOnly", true);
        model.addAttribute("dificultades", dificultadService.findAll());

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/crear")
    public String doCrearRutina(HttpSession session, Model model) {
        RutinaArgument rutina = new RutinaArgument();
        rutina.setId(-1);

        session.setAttribute("cache", rutina);

        model.addAttribute("dificultades", dificultadService.findAll());

        return "/entrenador/crud/rutina";
    }


    @GetMapping("/editar")
    public String doEditarRutina(@RequestParam(value = "id", required = false) Integer id,
                                 HttpSession session, Model model) {
        RutinaArgument rutina;
        if (session.getAttribute("cache") != null) {
            rutina = (RutinaArgument) session.getAttribute("cache");
        } else {
            RutinaDTO r = rutinaService.findById(id);
            List<SesionentrenamientoDTO> ss = sesionEntrenamientoService.findByRutina(r.getId());;
            List<SesionArgument> sesiones = new ArrayList<>();
            for (SesionentrenamientoDTO s : ss) {
                List<EjerciciosesionDTO> ee = ejercicioSesionService.findBySesion(s.getId());
                sesiones.add(new SesionArgument(s, ee));
            }
            rutina = new RutinaArgument(r, sesiones);
        }

        session.setAttribute("cache", rutina);

        model.addAttribute("dificultades", dificultadService.findAll());

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/guardar")
    public String doGuardarRutina(@RequestParam("nombre") String nombre,
                                  @RequestParam("dificultad") Integer dificultad,
                                  @RequestParam("descripcion") String descripcion,
                                  HttpSession session, Model model) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");

        rutina.setNombre(nombre);
        rutina.setDificultad(dificultad);
        rutina.setDescripcion(descripcion);

        List<String> errorList = new ArrayList<>();
        if (nombre.trim().isEmpty())
            errorList.add("No puedes crear una rutina sin nombre");

        if (descripcion.trim().isEmpty())
            errorList.add("No puedes tener una descripción vacía");

        if (rutina.getSesiones().isEmpty())
            errorList.add("No puedes crear una rutina sin sesiones");

        if (!errorList.isEmpty()) {
            model.addAttribute("errorList", errorList);

            return doEditarRutina(rutina.getId(), session, model);
        }

        rutinaService.saveOrCreateFullRutina(rutina, AuthUtils.getUser(session));

        return "redirect:/entrenador/rutinas?changedName=" + nombre + "&changedCase=" + (rutina.getId() < 0 ? 0 : 1);
    }

    @GetMapping("/borrar")
    public String doBorrarRutina(@RequestParam("id") Integer id) {
        RutinaDTO rutina = rutinaService.findById(id); // no deberia ser nunca null pero se puede probar
        String nombreRutina = rutina.getNombre();
        List<SesionentrenamientoDTO> sesiones = sesionEntrenamientoService.findByRutina(rutina.getId());
        for (SesionentrenamientoDTO sesion : sesiones) {
            List<EjerciciosesionDTO> ejerciciossesion = ejercicioSesionService.findBySesion(sesion.getId());
            List<Integer> ids = new ArrayList<>();
            for (EjerciciosesionDTO ejercicio : ejerciciossesion)
                ids.add(ejercicio.getId());
            ejercicioSesionService.deleteAll(ids);
        }
        List<Integer> ids = new ArrayList<>();
        for (SesionentrenamientoDTO sesion : sesiones)
            ids.add(sesion.getId());
        sesionEntrenamientoService.deleteAll(ids);
        rutinaService.delete(rutina.getId());

        return "redirect:/entrenador/rutinas?changedName=" + nombreRutina + "&changedCase=" + 2;
    }
}
