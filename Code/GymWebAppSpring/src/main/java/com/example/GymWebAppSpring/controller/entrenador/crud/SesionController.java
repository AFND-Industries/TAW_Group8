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
@RequestMapping("/entrenador/rutinas/crear/sesion")
public class SesionController extends BaseController {

    @GetMapping("/volver")
    public String doVolverFromSesion(HttpSession session) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int sesionPos = (int) session.getAttribute("sesionPos");
        SesionArgument oldSesion = (SesionArgument) session.getAttribute("oldSesion");

        if (oldSesion.getId() < -1) rutina.getSesiones().remove(sesionPos);
        else rutina.getSesiones().set(sesionPos, oldSesion);

        session.removeAttribute("sesionPos");
        session.removeAttribute("oldSesion");

        return "redirect:/entrenador/rutinas/crear/rutina/editar";
    }

    @GetMapping("/ver")
    public String doVerSesion(@RequestParam(value = "id", required = false) Integer id,
                              Model model, HttpSession session) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        List<SesionArgument> sesiones = rutina.getSesiones();

        int i = 0;
        SesionArgument sesion = null;
        while (i < sesiones.size() && sesion == null) {
            if (Objects.equals(sesiones.get(i).getId(), id))
                sesion = sesiones.get(i);
            i++;
        }

        List<Integer> ids = new ArrayList<>();
        for (EjercicioArgument ejerciciosesion : sesion.getEjercicios())
            ids.add(ejerciciosesion.getEjercicio());
        List<EjercicioDTO> ejercicios = ejercicioService.findEjercicioByIds(ids); /////////////////////////////////////////

        model.addAttribute("ejercicios", ejercicios);
        model.addAttribute("readOnly", true);

        session.setAttribute("sesionPos", i - 1);
        session.setAttribute("oldSesion", new SesionArgument());

        return "/entrenador/crud/sesion";
    }

    @GetMapping("")
    public String doCrearSesion(@RequestParam("nombre") String nombre,
                                @RequestParam("dificultad") Integer dificultad,
                                @RequestParam("descripcion") String descripcion,
                                HttpSession session) {
        // Las modificaciones de rutina antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        rutina.setNombre(nombre);
        rutina.setDificultad(dificultad);
        rutina.setDescripcion(descripcion);

        if (session.getAttribute("oldSesion") == null) { // Para que si recargas la pagina no se cree otra
            SesionArgument sesion = new SesionArgument();

            rutina.getSesiones().add(sesion);

            session.setAttribute("sesionPos", rutina.getSesiones().size() - 1);
            session.setAttribute("oldSesion", sesion); // al crear no hay ninguna antigua, metemos la misma que estamos creando
        }

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/editar")
    public String doEditarSesion(@RequestParam(value = "nombre", required = false) String nombre,
                                 @RequestParam(value = "dificultad", required = false) Integer dificultad,
                                 @RequestParam(value = "descripcion", required = false) String descripcion,
                                 @RequestParam(value = "pos", required = false) Integer pos,
                                 HttpSession session, Model model) {
        // Las modificaciones de rutina antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        if (nombre != null) rutina.setNombre(nombre);
        if (dificultad != null) rutina.setDificultad(dificultad);
        if (descripcion != null) rutina.setDescripcion(descripcion);

        Object sesionPosObject = session.getAttribute("sesionPos");
        int sesionPos = sesionPosObject != null ? (int) sesionPosObject : pos;

        SesionArgument sesion = rutina.getSesiones().get(sesionPos);

        List<Integer> ids = new ArrayList<>();
        for (EjercicioArgument ejerciciosesion : sesion.getEjercicios())
            ids.add(ejerciciosesion.getEjercicio());
        List<EjercicioDTO> ejercicios = ejercicioService.findAll(); //////////////////////////////////////////////////////////////

        model.addAttribute("ejercicios", ejercicios);

        if (session.getAttribute("oldSesion") == null)
            session.setAttribute("oldSesion", sesion);

        if (session.getAttribute("sesionPos") == null)
            session.setAttribute("sesionPos", sesionPos);

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/guardar")
    public String doGuardarSesion(@RequestParam("nombre") String nombre,
                                  @RequestParam("dia") String dia,
                                  @RequestParam("descripcion") String descripcion,
                                  HttpSession session, Model model) {
        // Las modificaciones de sesion antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");

        List<SesionArgument> sesiones = rutina.getSesiones();
        SesionArgument sesion = sesiones.get(pos);

        sesion.setNombre(nombre);
        sesion.setDia(dia);
        sesion.setDescripcion(descripcion);

        List<String> errorList = new ArrayList<>();
        if (nombre.trim().isEmpty())
            errorList.add("No puedes crear una sesión sin nombre");

        if (dia.trim().isEmpty())
            errorList.add("Debes especificar un día");
        else {
            Integer diaInt;
            try {
                diaInt = Integer.parseInt(dia);
            } catch (Exception e) {
                diaInt = null;
            }

            if (diaInt == null)
                errorList.add("Has introducido un dia no númerico");
            else if (diaInt <= 0 || diaInt > 7)
                errorList.add("El dia debe ser un numero entre 1 y 7, corresponde a un dia de la semana");
            else {
                boolean diaFound = false;
                int i = 0;
                while(!diaFound && i < sesiones.size()) {
                    SesionArgument s = sesiones.get(i);
                    if (sesion != s && Integer.parseInt(s.getDia()) == diaInt)
                        diaFound = true;
                    i++;
                }

                if (diaFound)
                    errorList.add("Ya existe una sesión en esta rutina para el día " + diaInt);
            }
        }

        if (descripcion.trim().isEmpty())
            errorList.add("No puedes tener una descripción vacía");

        if (sesion.getEjercicios().isEmpty())
            errorList.add("No puedes crear una sesión sin ejercicios");

        if (!errorList.isEmpty()) {
            model.addAttribute("errorList", errorList);

            return doEditarSesion(null, null, null, null, session, model);
        }

        if (sesion.getId() < -1)
            sesion.setId(-1); // para indicar que ha sido guardada y no es una dummy recien creada, se usa en doVolverFromSesion

        session.removeAttribute("sesionPos");
        session.removeAttribute("oldSesion");

        return "redirect:/entrenador/rutinas/crear/rutina/editar";
    }

    @GetMapping("/borrar")
    public String doBorrarSesion(@RequestParam("nombre") String nombre,
                                 @RequestParam("dificultad") Integer dificultad,
                                 @RequestParam("descripcion") String descripcion,
                                 @RequestParam("pos") Integer pos,
                                 HttpSession session) {
        // Las modificaciones de rutina antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        rutina.setNombre(nombre);
        rutina.setDificultad(dificultad);
        rutina.setDescripcion(descripcion);

        rutina.getSesiones().remove((int) pos);

        return "redirect:/entrenador/rutinas/crear/rutina/editar";
    }

}
