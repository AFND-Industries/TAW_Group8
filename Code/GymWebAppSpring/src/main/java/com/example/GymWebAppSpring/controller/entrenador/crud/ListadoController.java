package com.example.GymWebAppSpring.controller.entrenador.crud;

import com.example.GymWebAppSpring.dto.DificultadDTO;
import com.example.GymWebAppSpring.dto.RutinaDTO;
import com.example.GymWebAppSpring.iu.EjercicioArgument;
import com.example.GymWebAppSpring.iu.FiltroArgument;
import com.example.GymWebAppSpring.iu.RutinaArgument;
import com.example.GymWebAppSpring.iu.SesionArgument;
import com.example.GymWebAppSpring.util.AuthUtils;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/entrenador/rutinas")
public class ListadoController extends BaseController {

    @GetMapping("")
    public String doRutinas(@RequestParam(value = "changedName", required = false, defaultValue = "") String changedName,
                            @RequestParam(value = "changedCase", required = false, defaultValue = "-1") Integer changedCase,
                            Model model, HttpSession session) {
        Integer entrenadorId = AuthUtils.getUser(session).getId();
        initializeListado(model, entrenadorId, new FiltroArgument());

        model.addAttribute("changedName", changedName);
        model.addAttribute("changedCase", changedCase);

        return "/entrenador/crud/rutinas";
    }

    @GetMapping("/filtrar")
    public String doFiltrar(@ModelAttribute("filtro") FiltroArgument filtro, Model model, HttpSession session) {
        filtro.processFiltro();

        String strTo = "/entrenador/crud/rutinas";
        if (filtro.estaVacio()) strTo = "redirect:/entrenador/rutinas";
        else {
            Integer entrenadorId = AuthUtils.getUser(session).getId();
            initializeListado(model, entrenadorId, filtro);
        }

        return strTo;
    }

    @GetMapping("/recuperar")
    public String doRecuperarRutina(HttpSession session) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");

        String strTo =  "redirect:/entrenador/rutinas";
        if (rutina == null)  strTo = "redirect:/entrenador/rutinas/rutina/editar";
        else {
            SesionArgument oldSesion = (SesionArgument) session.getAttribute("oldSesion");
            if (oldSesion != null) {
                limpiarEjerciciosTemporales(session, rutina);
                strTo = "redirect:/entrenador/rutinas/sesion/editar";
            }

        }

        return strTo;
    }

    private void limpiarEjerciciosTemporales(HttpSession session, RutinaArgument rutina) {
        int sesionPos = (int) session.getAttribute("sesionPos");
        SesionArgument sesion = rutina.getSesiones().get(sesionPos);
        List<EjercicioArgument> ejerciciosAEliminar = new ArrayList<>();

        for (EjercicioArgument ejercicio : sesion.getEjercicios()) {
            if (ejercicio.getOrden() < 0) {
                ejerciciosAEliminar.add(ejercicio);
            }
        }

        sesion.getEjercicios().removeAll(ejerciciosAEliminar);
    }


    @GetMapping("/descartar")
    public String doDescartarRutina(HttpSession session) {
        flushContext(session);
        return "redirect:/entrenador/rutinas";
    }

    private void initializeListado(Model model, Integer entrenadorId, FiltroArgument filtro) {
        List<RutinaDTO> rutinas = rutinaService.filtrarRutinas(filtro, entrenadorId);
        List<DificultadDTO> dificultades = dificultadService.findAll();

        model.addAttribute("rutinas", rutinas);
        model.addAttribute("dificultades", dificultades);
        model.addAttribute("filtro", filtro);
    }
}
