package com.example.GymWebAppSpring.controller.entrenador.crud;

import com.example.GymWebAppSpring.dto.EjercicioDTO;
import com.example.GymWebAppSpring.iu.EjercicioArgument;
import com.example.GymWebAppSpring.iu.RutinaArgument;
import com.example.GymWebAppSpring.iu.SesionArgument;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/entrenador/rutinas/sesion")
public class SesionController extends BaseController {

    @GetMapping("/volver")
    public String doVolverFromSesion(HttpSession session) {
        RutinaArgument rutina = getRutinaFromSession(session);
        int sesionPos = (int) session.getAttribute("sesionPos");
        SesionArgument oldSesion = (SesionArgument) session.getAttribute("oldSesion");

        if (oldSesion.getId() < -1) rutina.getSesiones().remove(sesionPos);
        else rutina.getSesiones().set(sesionPos, oldSesion);

        flushSesionEntrenamiento(session);
        return "redirect:/entrenador/rutinas/rutina/editar";
    }

    @GetMapping("/ver")
    public String doVerSesion(@RequestParam("id") Integer id, Model model, HttpSession session) {
        RutinaArgument rutina = getRutinaFromSession(session);
        SesionArgument sesion = findSesionById(rutina, id);
        Integer sesionPos = rutina.getSesiones().indexOf(sesion);

        initializeSesion(model, sesion, true);
        session.setAttribute("oldSesion", sesion.clone());
        session.setAttribute("sesionPos", sesionPos);

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/crear")
    public String doCrearSesion(@RequestParam("nombre") String nombre,
                                @RequestParam("dificultad") Integer dificultad,
                                @RequestParam("descripcion") String descripcion,
                                HttpSession session, Model model) {
        RutinaArgument rutina = getRutinaFromSession(session);
        rutina.update(nombre, dificultad, descripcion);

        String strTo = "/entrenador/crud/sesion";
        if (rutina.getSesiones().size() >= 7) strTo = "redirect:/entrenador/rutinas/rutina/editar?fullSesion=true";
        else {
            if (session.getAttribute("oldSesion") == null) { // Para que si recargas la pagina no se cree otra
                SesionArgument sesion = new SesionArgument();
                rutina.getSesiones().add(sesion);

                session.setAttribute("sesionPos", rutina.getSesiones().size() - 1);
                session.setAttribute("oldSesion", sesion.clone()); // al crear no hay ninguna antigua, metemos la misma que estamos creando
            }

            model.addAttribute("diasCogidos", rutina.getDiasSesiones());
        }

        return strTo;
    }

    @GetMapping("/editar")
    public String doEditarSesion(@RequestParam(value = "nombre", required = false) String nombre,
                                 @RequestParam(value = "dificultad", required = false) Integer dificultad,
                                 @RequestParam(value = "descripcion", required = false) String descripcion,
                                 @RequestParam(value = "pos", required = false) Integer pos,
                                 HttpSession session, Model model) {
        RutinaArgument rutina = getRutinaFromSession(session);
        rutina.update(nombre, dificultad, descripcion);

        int sesionPos = getSessionPosition(session, pos);
        SesionArgument sesion = rutina.getSesiones().get(sesionPos);
        model.addAttribute("diasCogidos", rutina.getDiasSesiones());

        initializeSesion(model, sesion, false);
        if (session.getAttribute("oldSesion") == null) session.setAttribute("oldSesion", sesion.clone());
        if (session.getAttribute("sesionPos") == null) session.setAttribute("sesionPos", sesionPos);

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/guardar")
    public String doGuardarSesion(@RequestParam("nombre") String nombre,
                                  @RequestParam("dia") String dia,
                                  @RequestParam("descripcion") String descripcion,
                                  HttpSession session, Model model) {
        RutinaArgument rutina = getRutinaFromSession(session);
        int pos = (int) session.getAttribute("sesionPos");

        SesionArgument sesion = rutina.getSesiones().get(pos);
        sesion.update(nombre, dia, descripcion);

        List<String> errorList = new ArrayList<>();
        if (nombre.trim().isEmpty())
            errorList.add("No puedes crear una sesión sin nombre");

        if (descripcion.trim().isEmpty())
            errorList.add("No puedes tener una descripción vacía");

        if (sesion.getEjercicios().isEmpty())
            errorList.add("No puedes crear una sesión sin ejercicios");

        if (!errorList.isEmpty()) {
            model.addAttribute("errorList", errorList);
            return doEditarSesion(null, null, null, null, session, model);
        }

        sesion.setId(sesion.getId() < -1 ? -1 : sesion.getId());
        flushSesionEntrenamiento(session);
        return "redirect:/entrenador/rutinas/rutina/editar";
    }

    @GetMapping("/borrar")
    public String doBorrarSesion(@RequestParam("nombre") String nombre,
                                 @RequestParam("dificultad") Integer dificultad,
                                 @RequestParam("descripcion") String descripcion,
                                 @RequestParam("pos") Integer pos,
                                 HttpSession session) {
        RutinaArgument rutina = getRutinaFromSession(session);
        rutina.update(nombre, dificultad, descripcion);
        rutina.getSesiones().remove((int) pos);

        return "redirect:/entrenador/rutinas/rutina/editar";
    }

    private RutinaArgument getRutinaFromSession(HttpSession session) {
        return (RutinaArgument) session.getAttribute("cache");
    }

    private SesionArgument findSesionById(RutinaArgument rutina, Integer id) {
        return rutina.getSesiones().stream()
                .filter(s -> Objects.equals(s.getId(), id))
                .findFirst()
                .orElse(null);
    }

    private int getSessionPosition(HttpSession session, Integer pos) {
        Object sesionPosObject = session.getAttribute("sesionPos");
        return sesionPosObject != null ? (int) sesionPosObject : pos;
    }

    private void initializeSesion(Model model, SesionArgument sesion, boolean readOnly) {
        List<EjercicioDTO> ejercicios = ejercicioService.findEjercicioByIds(sesion.getEjerciciosId());
        model.addAttribute("ejercicios", ejercicios);
        model.addAttribute("readOnly", readOnly);
    }
}
