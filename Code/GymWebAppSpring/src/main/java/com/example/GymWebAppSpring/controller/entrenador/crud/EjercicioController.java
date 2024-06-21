package com.example.GymWebAppSpring.controller.entrenador.crud;

import com.example.GymWebAppSpring.dto.EjercicioDTO;
import com.example.GymWebAppSpring.dto.EjerciciosesionDTO;
import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import com.example.GymWebAppSpring.iu.EjercicioArgument;
import com.example.GymWebAppSpring.iu.RutinaArgument;
import com.example.GymWebAppSpring.iu.SesionArgument;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/entrenador/rutinas/ejercicio")
public class EjercicioController extends BaseController {

    @GetMapping("/volver")
    public String doVolverFromCrearEjercicio(@RequestParam("ejpos") Integer ejpos,
                                             HttpSession session) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");
        SesionArgument sesion = rutina.getSesiones().get(pos);
        sesion.getEjercicios().remove((int) ejpos);

        return "redirect:/entrenador/rutinas/ejercicio/seleccionar";
    }

    @GetMapping("/seleccionar")
    public String doSeleccionarEjercicio(@RequestParam(value = "nombre", required = false) String nombre,
                                         @RequestParam(value = "dia", required = false) String dia,
                                         @RequestParam(value = "descripcion", required = false) String descripcion,
                                         Model model, HttpSession session) {
        // Las modificaciones de sesion antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");

        SesionArgument sesion = rutina.getSesiones().get(pos);
        if (nombre != null) sesion.setNombre(nombre);
        if (dia != null) sesion.setDia(dia);
        if (descripcion != null) sesion.setDescripcion(descripcion);

        List<EjercicioDTO> ejerciciosBase = AuthUtils.isStrengthTrainer(session) // Si es de fuerza solo fuerza, si no todos
                ? ejercicioService.findAllEjerciciosFuerza() : ejercicioService.findAll();

        model.addAttribute("ejerciciosBase", ejerciciosBase);

        return "/entrenador/crud/seleccionar_ejercicio";
    }

    @GetMapping("/ver")
    public String doVerEjercicio(@RequestParam("id") Integer id,
                                 Model model, HttpSession session) {
        EjerciciosesionDTO ejerciciosesion = ejercicioSesionService.findById(id);
        EjercicioDTO ejercicioBase = ejerciciosesion.getEjercicio();

        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        List<SesionArgument> sesiones = rutina.getSesiones();

        int pos = -1;
        for (SesionArgument sesione : sesiones) {
            List<EjercicioArgument> ejercicios = sesione.getEjercicios();
            for (int j = 0; j < ejercicios.size(); j++) {
                if (ejercicios.get(j).getId().equals(id)) {
                    pos = j;
                    break;
                }
            }
            if (pos != -1)
                break;
        }

        model.addAttribute("readOnly", true);
        model.addAttribute("ejercicioBase", ejercicioBase);
        model.addAttribute("ejercicioPos", pos);

        return "entrenador/crud/ejercicio_sesion";
    }

    @GetMapping("/crear")
    public String doCrearEjercicio(@RequestParam("ejbase") Integer ejbase,
                                   Model model, HttpSession session) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");
        SesionArgument sesion = rutina.getSesiones().get(pos);

        if (sesion.getEjercicios().isEmpty() || sesion.getEjercicios().getLast().getId() >= -1)
            sesion.getEjercicios().add(new EjercicioArgument());

        EjercicioDTO ejercicioBase = ejercicioService.findById(ejbase);
        model.addAttribute("ejercicioPos", -1);
        model.addAttribute("ejercicioBase", ejercicioBase);

        return "entrenador/crud/ejercicio_sesion";
    }

    @GetMapping("/editar")
    public String doEditarEjercicio(@RequestParam(value = "nombre", required = false) String nombre,
                                    @RequestParam(value = "dia", required = false) String dia,
                                    @RequestParam(value = "descripcion", required = false) String descripcion,
                                    @RequestParam("ejPos") Integer ejPos,
                                    HttpSession session, Model model) {
        // Las modificaciones de sesion antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");

        SesionArgument sesion = rutina.getSesiones().get(pos);
        if (nombre != null) sesion.setNombre(nombre);
        if (dia != null) sesion.setDia(dia);
        if (descripcion != null) sesion.setDescripcion(descripcion);

        int ejbase = sesion.getEjercicios().get(ejPos).getEjercicio();
        EjercicioDTO ejercicioBase = ejercicioService.findById(ejbase);
        model.addAttribute("ejercicioBase", ejercicioBase);
        model.addAttribute("ejercicioPos", ejPos);

        return "entrenador/crud/ejercicio_sesion";
    }

    @GetMapping("/guardar")
    public String doGuardarEjercicio(@RequestParam("especificaciones") String especificaciones,
                                     @RequestParam("ejpos") Integer ejpos,
                                     HttpSession session, Model model) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");
        SesionArgument sesion = rutina.getSesiones().get(pos);
        EjercicioArgument ejercicioSesion = sesion.getEjercicios().get(ejpos);

        Gson gson = new Gson();
        JsonObject esp = gson.fromJson(especificaciones, JsonObject.class);
        ejercicioSesion.setEspecificaciones(esp);
        if (ejercicioSesion.getId() < -1) { // Si es una creacion
            int maxOrden = -1;
            for (int i = 0; i < sesion.getEjercicios().size(); i++) {
                int orden = sesion.getEjercicios().get(i).getOrden();
                if (i != ejpos && orden > maxOrden)
                    maxOrden = orden;
            }

            ejercicioSesion.setOrden(maxOrden + 1);
            ejercicioSesion.setId(-1);
        }

        List<String> errorList = new ArrayList<>();
        for (String tipoBase : esp.keySet()) {
            String value = esp.get(tipoBase).getAsString();

            if (value.trim().isEmpty())
                errorList.add("No has especificado el atributo " + tipoBase);
        }

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
        // Las modificaciones de sesion antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");

        SesionArgument sesion = rutina.getSesiones().get(pos);
        sesion.setNombre(nombre);
        sesion.setDia(dia);
        sesion.setDescripcion(descripcion);

        rutina.getSesiones().get(pos).getEjercicios().remove((int) ejPos);
        for (int i = ejPos; i < rutina.getSesiones().get(pos).getEjercicios().size(); i++) { // shift
            EjercicioArgument ejercicio = rutina.getSesiones().get(pos).getEjercicios().get(i);
            rutina.getSesiones().get(pos).getEjercicios().get(i).setOrden(ejercicio.getOrden() - 1);
        }

        return "redirect:/entrenador/rutinas/sesion/editar";
    }
}
