package com.example.GymWebAppSpring.controller.entrenador.crud;

import com.example.GymWebAppSpring.dto.EjercicioDTO;
import com.example.GymWebAppSpring.dto.EjerciciosesionDTO;
import com.example.GymWebAppSpring.iu.EjercicioArgument;
import com.example.GymWebAppSpring.iu.RutinaArgument;
import com.example.GymWebAppSpring.iu.SesionArgument;
import com.example.GymWebAppSpring.util.AuthUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/entrenador/rutinas/ejercicio")
public class EjercicioController extends BaseController {

    @GetMapping("/volver")
    public String doVolverDesdeCrearEjercicio(@RequestParam("ejpos") Integer ejpos, HttpSession session) {
        SesionArgument sesion = getSesionFromSession(session);
        sesion.getEjercicios().remove((int) ejpos);
        return "redirect:/entrenador/rutinas/ejercicio/seleccionar";
    }

    @GetMapping("/seleccionar")
    public String doSeleccionarEjercicio(@RequestParam(value = "nombre", required = false) String nombre,
                                       @RequestParam(value = "dia", required = false) String dia,
                                       @RequestParam(value = "descripcion", required = false) String descripcion,
                                       Model model, HttpSession session) {
        SesionArgument sesion = getSesionFromSession(session);
        sesion.update(nombre, dia, descripcion);

        List<EjercicioDTO> ejerciciosBase = AuthUtils.isStrengthTrainer(session)
                ? ejercicioService.findAllEjerciciosFuerza()
                : ejercicioService.findAll();

        model.addAttribute("ejerciciosBase", ejerciciosBase);
        return "entrenador/crud/seleccionar_ejercicio/seleccionar_ejercicio";
    }

    @GetMapping("/ver")
    public String doVerEjercicio(@RequestParam("id") Integer id, Model model, HttpSession session) {
        RutinaArgument rutina = getRutinaFromSession(session);
        int pos = findEjercicioPosition(rutina.getSesiones(), id);
        EjerciciosesionDTO ejerciciosesion = ejercicioSesionService.findById(id);

        int ejbase = ejerciciosesion.getEjercicio().getId();
        inicializarEjercicio(model, ejbase, true, pos);

        return "entrenador/crud/ejercicio_sesion/ejercicio_sesion";
    }

    @GetMapping("/crear")
    public String doCrearEjercicio(@RequestParam("ejbase") Integer ejbase, Model model, HttpSession session) {
        SesionArgument sesion = getSesionFromSession(session);
        if (sesion.getEjercicios().isEmpty() || sesion.getEjercicios().getLast().getId() >= -1)
            sesion.getEjercicios().add(new EjercicioArgument());

        inicializarEjercicio(model, ejbase, false, -1);

        return "entrenador/crud/ejercicio_sesion/ejercicio_sesion";
    }

    @GetMapping("/editar")
    public String doEditarEjercicio(@RequestParam(value = "nombre", required = false) String nombre,
                                  @RequestParam(value = "dia", required = false) String dia,
                                  @RequestParam(value = "descripcion", required = false) String descripcion,
                                  @RequestParam("ejPos") Integer ejPos,
                                  HttpSession session, Model model) {
        SesionArgument sesion = getSesionFromSession(session);
        sesion.update(nombre, dia, descripcion);

        int ejbase = sesion.getEjercicios().get(ejPos).getEjercicio();
        inicializarEjercicio(model, ejbase, false, ejPos);

        return "entrenador/crud/ejercicio_sesion/ejercicio_sesion";
    }

    @GetMapping("/guardar")
    public String doGuardarEjercicio(@RequestParam("especificaciones") String especificaciones,
                                   @RequestParam("ejpos") Integer ejpos,
                                   HttpSession session, Model model) {
        SesionArgument sesion = getSesionFromSession(session);
        EjercicioArgument ejercicioSesion = sesion.getEjercicios().get(ejpos);
        ejercicioSesion.update(especificaciones);

        if (ejercicioSesion.getId() < -1) {
            int maxOrden = getMaxOrderExceptCurrent(sesion.getEjercicios(), ejpos);
            ejercicioSesion.setOrden(maxOrden + 1);
            ejercicioSesion.setId(-1);
        }

        List<String> errorList = validateEjercicio(ejercicioSesion);
        if (!errorList.isEmpty()) {
            model.addAttribute("errorList", errorList);
            return doEditarEjercicio(null, null, null, ejpos, session, model);
        }

        return "redirect:/entrenador/rutinas/sesion/editar";
    }

    @GetMapping("/borrar")
    public String doBorrarEjercicio(@RequestParam("nombre") String nombre,
                                  @RequestParam("dia") String dia,
                                  @RequestParam("descripcion") String descripcion,
                                  @RequestParam("ejPos") Integer ejPos,
                                  HttpSession session) {
        SesionArgument sesion = getSesionFromSession(session);
        sesion.update(nombre, dia, descripcion);

        removeEjercicioAndReorder(sesion.getEjercicios(), ejPos);

        return "redirect:/entrenador/rutinas/sesion/editar";
    }

    @GetMapping("/mover")
    public String doMoverEjercicio(@RequestParam("ejPos") Integer ejPos, @RequestParam("move") Integer move, HttpSession session) {
        SesionArgument sesion = getSesionFromSession(session);
        List<EjercicioArgument> ejercicios = sesion.getEjercicios();

        EjercicioArgument ejercicio = ejercicios.get(ejPos);
        ejercicios.stream()
                .filter(e -> e.getOrden() == ejercicio.getOrden() + move)
                .findFirst()
                .ifPresent(swapEjercicio -> swapOrden(ejercicio, swapEjercicio));

        return "redirect:/entrenador/rutinas/sesion/editar";
    }

    private List<String> validateEjercicio(EjercicioArgument ejercicio) {
        List<String> errorList = new ArrayList<>();
        for (String tipoBase : ejercicio.getEspecificaciones().keySet()) {
            String value = ejercicio.getEspecificaciones().get(tipoBase).getAsString();

            if (value.trim().isEmpty())
                errorList.add("No has especificado el atributo " + tipoBase);
        }

        return errorList;
    }

    private void swapOrden(EjercicioArgument ejercicio1, EjercicioArgument ejercicio2) {
        int orden1 = ejercicio1.getOrden();
        ejercicio1.setOrden(ejercicio2.getOrden());
        ejercicio2.setOrden(orden1);
    }

    private int findEjercicioPosition(List<SesionArgument> sesiones, Integer id) {
        for (SesionArgument sesion : sesiones) {
            for (int j = 0; j < sesion.getEjercicios().size(); j++) {
                if (sesion.getEjercicios().get(j).getId().equals(id)) {
                    return j;
                }
            }
        }
        return -1;
    }

    private void removeEjercicioAndReorder(List<EjercicioArgument> ejercicios, int ejPos) {
        int orden = ejercicios.get(ejPos).getOrden();
        ejercicios.remove(ejPos);

        for (EjercicioArgument ejercicio : ejercicios) {
            if (ejercicio.getOrden() > orden)
                ejercicio.setOrden(ejercicio.getOrden() - 1);
        }
    }

    private int getMaxOrderExceptCurrent(List<EjercicioArgument> ejercicios, int ejpos) {
        int maxOrden = -1;
        for (int i = 0; i < ejercicios.size(); i++) {
            int orden = ejercicios.get(i).getOrden();
            if (i != ejpos && orden > maxOrden) {
                maxOrden = orden;
            }
        }
        return maxOrden;
    }

    private void inicializarEjercicio(Model model, int ejBase, boolean readOnly, int ejercicioPos) {
        EjercicioDTO ejercicioBase = ejercicioService.findById(ejBase);
        model.addAttribute("readOnly", readOnly);
        model.addAttribute("ejercicioBase", ejercicioBase);
        model.addAttribute("ejercicioPos", ejercicioPos);
    }
}