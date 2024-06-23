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
@RequestMapping("/entrenador/rutinas/rutina")
public class RutinaController extends BaseController {

    @GetMapping("/volver")
    public String doVolverFromRutina(HttpSession session) {
        flushContext(session);
        return "redirect:/entrenador/rutinas";
    }

    @GetMapping("/ver")
    public String doVerRutina(@RequestParam("id") Integer id, Model model, HttpSession session) {
        RutinaArgument rutina = createRutinaArgument(id);
        initializeRutina(model, session, rutina, true);

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/crear")
    public String doCrearRutina(HttpSession session, Model model) {
        RutinaArgument rutina = new RutinaArgument(-1);
        initializeRutina(model, session, rutina, false);

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/editar")
    public String doEditarRutina(@RequestParam(value = "id", required = false) Integer id,
                                 @RequestParam(value = "fullSesion", required = false) Boolean fullSesion,
                                 HttpSession session, Model model) {
        Object cache = session.getAttribute("cache");
        RutinaArgument rutina = cache != null ? (RutinaArgument) cache : createRutinaArgument(id);
        initializeRutina(model, session, rutina, false);

        if (fullSesion != null && fullSesion) {
            List<String> errorList = new ArrayList<>();
            errorList.add("No puedes añadir más sesiones. Ya has completado toda la semana");
            model.addAttribute("errorList", errorList);
        }

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/guardar")
    public String doGuardarRutina(@RequestParam("nombre") String nombre,
                                  @RequestParam("dificultad") Integer dificultad,
                                  @RequestParam("descripcion") String descripcion,
                                  HttpSession session, Model model) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        rutina.update(nombre, dificultad, descripcion);

        List<String> errorList = validateRutina(rutina);
        if (!errorList.isEmpty()) {
            model.addAttribute("errorList", errorList);
            return doEditarRutina(rutina.getId(), false, session, model);
        }

        rutinaService.updateRutina(rutina, AuthUtils.getUser(session));
        flushContext(session);

        return "redirect:/entrenador/rutinas?changedName=" + nombre + "&changedCase=" + (rutina.getId() < 0 ? 0 : 1);
    }

    @PostMapping("/borrar")
    public String doBorrarRutina(@RequestParam("id") Integer id) {
        RutinaDTO rutina = rutinaService.findById(id);

        List<SesionentrenamientoDTO> sesionesDTO = sesionEntrenamientoService.findByRutina(rutina.getId());
        for (SesionentrenamientoDTO sesion : sesionesDTO) {
            List<EjerciciosesionDTO> ejerciciosDTO = ejercicioSesionService.findBySesion(sesion.getId());
            ejercicioSesionService.deleteAll(ejerciciosDTO);
        }

        sesionEntrenamientoService.deleteAll(sesionesDTO);
        rutinaService.delete(rutina.getId());

        return "redirect:/entrenador/rutinas?changedName=" + rutina.getNombre() + "&changedCase=" + 2;
    }

    private List<String> validateRutina(RutinaArgument rutina) {
        List<String> errorList = new ArrayList<>();
        if (rutina.getNombre().trim().isEmpty())
            errorList.add("No puedes crear una rutina sin nombre");

        if (rutina.getDescripcion().trim().isEmpty())
            errorList.add("No puedes tener una descripción vacía");

        if (rutina.getSesiones().isEmpty())
            errorList.add("No puedes crear una rutina sin sesiones");

        return errorList;
    }

    private void initializeRutina(Model model, HttpSession session, RutinaArgument rutina, boolean readOnly) {
        session.setAttribute("cache", rutina);
        session.setAttribute("recover", !readOnly);

        List<DificultadDTO> dificultades = dificultadService.findAll();
        model.addAttribute("dificultades", dificultades);
        model.addAttribute("readOnly", readOnly);
    }
}
