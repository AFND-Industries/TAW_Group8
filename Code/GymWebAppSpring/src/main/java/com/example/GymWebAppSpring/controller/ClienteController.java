package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.*;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.iu.EjercicioSesionArgument;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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


    @Autowired
    protected InformacionEjercicioRepository informacionEjercicioRepository;

    @Autowired
    protected RutinaUsuarioRepository rutinaUsuarioRepository;

    @Autowired
    protected SesionentrenamientoRepository sesionentrenamientoRepository;

    @Autowired
    protected EjercicioSesionRepository ejerciciosesionRepository;

    @Autowired
    protected InformacionSesionRepository informacionSesionRepository;

    @GetMapping("")
    public String doClient(HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        Usuario user = (Usuario) sesion.getAttribute("user");
        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaByUsuario(user);
        modelo.addAttribute("usuario", user);
        modelo.addAttribute("rutinas", rutinas);
        return "client/clientePersonalSpace";


    }

    @GetMapping("/rutina")
    public String doVerRutina(@RequestParam("rutinaElegida") Rutina rutina, HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";


        session.removeAttribute("RutinaEntrenamiento");
        session.setAttribute("RutinaEntrenamiento", rutina);
        Usuario user = (Usuario) session.getAttribute("user");


        Map<Sesionentrenamiento, List<Object>> sesionesEjercicios = new LinkedHashMap<>();
        modelo.addAttribute("usuario", user);
        modelo.addAttribute("rutina", rutina);
        List<Sesionentrenamiento> sesionesEntrenamiento = sesionentrenamientoRepository.findSesionesByRutina(rutina);
        for (Sesionentrenamiento s : sesionesEntrenamiento) {
            List<Object> combinado = new ArrayList<>();
            List<Ejerciciosesion> ejercicos = ejerciciosesionRepository.findEjerciciosBySesion(s);
            List<Informacionejercicio> informacionEjercicios = informacionEjercicioRepository.findBySesionentrenamiento(s);
            combinado.add(ejercicos);
            combinado.add(informacionEjercicios.size());
            sesionesEjercicios.put(s, combinado);
        }

        modelo.addAttribute("sesionesEjercicios", sesionesEjercicios);


        return "client/verRutina";


    }

    @GetMapping("rutina/sesion")
    public String doVerSesion(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento, HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        List<Ejerciciosesion> ejercicios = ejerciciosesionRepository.findEjerciciosBySesion(sesionEntrenamiento); //Cambiar por una querry de solo 1

        return "redirect:/client/rutina/sesion/ejercicio?sesionEntrenamiento=" + sesionEntrenamiento.getId() + "&ejercicio=0";
    }

    @GetMapping("rutina/sesion/ejercicio")
    public String doVerEjercicio(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento,
                                 @RequestParam(value = "ejercicioIndex", required = false, defaultValue = "0") Integer ejercicioIndex,
                                 HttpSession session, Model modelo) {

        if (!AuthUtils.isClient(session))
            return "redirect:/";

        List<Ejerciciosesion> ejercicios = ejerciciosesionRepository.findEjerciciosBySesion(sesionEntrenamiento);
        if (ejercicioIndex >= ejercicios.size())
            return "redirect:/client/rutina/sesion/valorarEntrenamiento?sesionEntrenamiento=" + sesionEntrenamiento.getId();
        if(ejercicioIndex < 0)
            ejercicioIndex = 0;
        Gson gson = new Gson();
        Ejerciciosesion ejercicioSesion = ejercicios.get(ejercicioIndex);
        HashMap<String, String> especificaciones = gson.fromJson(ejercicioSesion.getEspecificaciones(), HashMap.class);
        HashMap<String, String> resultados = new HashMap<>();
        for (String key : especificaciones.keySet()) {
            resultados.put(key, "0");
        }

        EjercicioSesionArgument ejercicioSesionArgument = new EjercicioSesionArgument();

        ejercicioSesionArgument.setEjercicio(ejercicioSesion.getEjercicio());
        ejercicioSesionArgument.setId(ejercicioSesion.getId());
        ejercicioSesionArgument.setEspecificaciones(especificaciones);
        ejercicioSesionArgument.setResultados(resultados);
        ejercicioSesionArgument.setSesionEntrenamiento(sesionEntrenamiento);


        session.removeAttribute("sesionEntrenamiento");
        session.setAttribute("sesionEntrenamiento", sesionEntrenamiento);
        Usuario user = (Usuario) session.getAttribute("user");

        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        modelo.addAttribute("ejercicioSesion", ejercicios.get(ejercicioIndex));
        modelo.addAttribute("ejercicioIndex", ejercicioIndex);
        modelo.addAttribute("ejercicioSesionArgument", ejercicioSesionArgument);
        return "client/verEjercicio";
    }

    @PostMapping("rutina/sesion/ejercicio/guardar")
    public String doGuardarEjercicio(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento,
                                     @RequestParam("resultados") String resultados,
                                     @RequestParam("ejercicioIndex") Integer ejercicioIndex,
                                     HttpSession session) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        Usuario user = (Usuario) session.getAttribute("user");

        Informacionsesion informacionSesion = informacionSesionRepository.findByUsuarioAndSesion(user, sesionEntrenamiento);
        if (informacionSesion == null) {
            informacionSesion = new Informacionsesion();
            informacionSesion.setComentario("NaN");
            informacionSesion.setValoracion(0);
            informacionSesion.setSesionentrenamiento(sesionEntrenamiento);
            informacionSesion.setUsuario(user);
            informacionSesionRepository.save(informacionSesion);
        }
        List<Informacionejercicio> informacionEjercicioLista = informacionEjercicioRepository.findBySesionentrenamiento(sesionEntrenamiento);
        if (informacionEjercicioLista.size() <= ejercicioIndex) {
            Informacionejercicio informacionEjercicio = new Informacionejercicio();
            informacionEjercicio.setEjerciciosesion(ejerciciosesionRepository.findEjerciciosBySesion(sesionEntrenamiento).get(ejercicioIndex));
            informacionEjercicio.setInformacionsesion(informacionSesion);
            informacionEjercicio.setEvaluacion(resultados);
            informacionEjercicioRepository.save(informacionEjercicio);
        } else {
            Informacionejercicio informacionEjercicio = informacionEjercicioLista.get(ejercicioIndex);
            informacionEjercicio.setEvaluacion(resultados);
            informacionEjercicioRepository.save(informacionEjercicio);
        }


        return "redirect:/client/rutina/sesion/ejercicio?sesionEntrenamiento=" + sesionEntrenamiento.getId() + "&ejercicioIndex=" + (ejercicioIndex + 1);


    }

    @PostMapping("rutina/sesion/ejercicio/modificar")
    public String doModificarEjercicio(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento,
                                       @RequestParam("resultados") String resultados,
                                       @RequestParam(value = "ejercicioSesion") Ejerciciosesion ejerciciosesion,
                                       HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        Usuario user = (Usuario) session.getAttribute("user");

        Informacionsesion informacionSesion = informacionSesionRepository.findByUsuarioAndSesion(user, sesionEntrenamiento);
        Informacionejercicio informacionEjercicio = informacionEjercicioRepository.findByEjerciciosesionAndInformacionsesion(ejerciciosesion, informacionSesion);
        informacionEjercicio.setEvaluacion(resultados);
        informacionEjercicioRepository.save(informacionEjercicio);
        return "redirect:/client/rutina/sesion/desempenyo?sesionEntrenamiento=" + sesionEntrenamiento.getId();


    }


    @GetMapping("rutina/sesion/valorarEntrenamiento")
    public String doValorarEntrenamiento(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento,
                                         @RequestParam(value = "informacionSesion", required = false) Informacionsesion informacionSesionModif,
                                         HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";
        Informacionsesion informacionSesion = null;
        if (informacionSesionModif == null) {
            informacionSesion = informacionSesionRepository.findByUsuarioAndSesion((Usuario) session.getAttribute("user"), sesionEntrenamiento);
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
    public String doGuardarValoracionSesion(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento,
                                            @RequestParam("comentario") String comentario,
                                            @RequestParam("rating") String rating,
                                            HttpSession session) {


        Usuario user = (Usuario) session.getAttribute("user");
        Informacionsesion informacionSesion = informacionSesionRepository.findByUsuarioAndSesion(user, sesionEntrenamiento);
        if (informacionSesion == null)
            return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();

        informacionSesion.setComentario(comentario);
        informacionSesion.setValoracion(Integer.parseInt(rating));
        informacionSesion.setFechaFin(LocalDate.now());
        informacionSesionRepository.save(informacionSesion);


        return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();
    }

    @GetMapping("/rutina/sesion/desempenyo")
    public String doDesempenyo(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento, HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        Usuario usuario = (Usuario) session.getAttribute("user");
        Informacionsesion informacionSesion = informacionSesionRepository.findByUsuarioAndSesion(usuario, sesionEntrenamiento);
        if (informacionSesion == null)
            return "redirect:/client";

        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        modelo.addAttribute("informacionSesion", informacionSesion);
        HashMap<Ejerciciosesion, Informacionejercicio> ejercicios = new HashMap<>();
        List<Ejerciciosesion> ejerciciosSesion = ejerciciosesionRepository.findEjerciciosBySesion(sesionEntrenamiento);
        for (Ejerciciosesion e : ejerciciosSesion) {
            Informacionejercicio informacionEjercicio = informacionEjercicioRepository.findByEjerciciosesionAndInformacionsesion(e, informacionSesion);
            ejercicios.put(e, informacionEjercicio);
        }
        modelo.addAttribute("ejercicios", ejercicios);
        return "client/verDesempenyo";
    }

    @PostMapping("/rutina/sesion/desempenyo/borrar")
    public String doBorrarDesempenyo(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento, HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        Usuario usuario = (Usuario) session.getAttribute("user");
        Informacionsesion informacionSesion = informacionSesionRepository.findByUsuarioAndSesion(usuario, sesionEntrenamiento);
        List<Informacionejercicio> informacionEjercicios = informacionEjercicioRepository.findBySesionentrenamiento(sesionEntrenamiento);
        if (informacionSesion == null)
            return "redirect:/client";
        informacionEjercicioRepository.deleteAll(informacionEjercicios);
        informacionSesionRepository.delete(informacionSesion);


        return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();
    }

}
