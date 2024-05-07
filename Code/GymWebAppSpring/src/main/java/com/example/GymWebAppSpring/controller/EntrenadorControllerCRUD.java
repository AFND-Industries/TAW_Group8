package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.*;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.iu.EjercicioArgument;
import com.example.GymWebAppSpring.iu.RutinaArgument;
import com.example.GymWebAppSpring.iu.SesionArgument;
import com.example.GymWebAppSpring.util.AuthUtils;

import com.google.gson.Gson;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/entrenador/rutinas")
public class EntrenadorControllerCRUD {
    // preguntar como hacer un post o si puedo hacerlo con javascript o que
    // si psa algo por usar post
    // preguntar como hago lo de editar/<%=rutina.getId()%> de una manera mas elegante
    // como hago que lo de arriba sea un string referenciable prefix o path
    // preguntar como hacer cosas como restricciones de que no deje crear si algun cmapo esta vacio o cosas asi
    // si hacerlas con javascript o que
    // como hago lo de guardar que estoy hacindo una rutina y una sesion y blablabla
    // preguntar si en las query es mejor pasar el objeto o el id
    // en que caso una entidad tendira por atributo una lista?

    // cambiar la bd tiposbase muchos mas caracteres, la descripcion igual
    // pensar si los tipos base en categoria o donde
    // meter los días
    @Autowired
    protected RutinaRepository rutinaRepository;

    @Autowired
    protected DificultadRepository dificultadRepository;

    @Autowired
    protected SesionentrenamientoRepository sesionentrenamientoRepository;

    @Autowired
    protected EjercicioSesionRepository ejercicioSesionRepository;

    @Autowired
    protected EjercicioRepository ejercicioRepository;

    @Autowired
    protected Gson gson;

    @GetMapping("")
    public String doRutinas(HttpSession session, Model model) {
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";

        Usuario entrenador = AuthUtils.getUser(session);
        List<Rutina> rutinas = rutinaRepository.findRutinaByEntrenadorId(entrenador);

        model.addAttribute("rutinas", rutinas);

        return "/entrenador/crud/rutinas";
    }

    @GetMapping("/ver")
    public String doVerRutina(@RequestParam(value = "cache", defaultValue = "") String cache,
                              @RequestParam(value = "id", required = false) Integer id, Model model) {
        RutinaArgument rutina;
        if (!cache.isEmpty())
            rutina = gson.fromJson(cache, RutinaArgument.class);
        else {
            Rutina r = rutinaRepository.findById(id).orElse(null);
            List<Sesionentrenamiento> ss = sesionentrenamientoRepository.findSesionesByRutina(r);;
            List<SesionArgument> sesiones = new ArrayList<>();
            for (Sesionentrenamiento s : ss) {
                List<Ejerciciosesion> ee = ejercicioSesionRepository.findEjerciciosBySesion(s);
                sesiones.add(new SesionArgument(s, ee));
            }
            rutina = new RutinaArgument(r, sesiones);
        }

        model.addAttribute("readOnly", true);
        model.addAttribute("cache", gson.toJson(rutina));

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/crear")
    public String doCrearRutina(@RequestParam(value = "cache", defaultValue = "") String cache, Model model) {
        RutinaArgument rutina = new RutinaArgument();
        rutina.setId(-1);

        model.addAttribute("cache", gson.toJson(rutina));

        return "/entrenador/crud/rutina";
    }


    @GetMapping("/editar")
    public String doEditarRutina(@RequestParam(value = "cache", defaultValue = "") String cache,
                                 @RequestParam(value = "id", required = false) Integer id, Model model) {
        RutinaArgument rutina;
        if (!cache.isEmpty())
            rutina = gson.fromJson(cache, RutinaArgument.class);
        else {
            Rutina r = rutinaRepository.findById(id).orElse(null);
            List<Sesionentrenamiento> ss = sesionentrenamientoRepository.findSesionesByRutina(r);;
            List<SesionArgument> sesiones = new ArrayList<>();
            for (Sesionentrenamiento s : ss) {
                List<Ejerciciosesion> ee = ejercicioSesionRepository.findEjerciciosBySesion(s);
                sesiones.add(new SesionArgument(s, ee));
            }
            rutina = new RutinaArgument(r, sesiones);
        }

        model.addAttribute("cache", gson.toJson(rutina));

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/guardar")
    public String doGuardarRutina(@RequestParam("cache") String cache,
                                  HttpSession session) {
        RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);

        // RUTINA
        // CREAR O MODIFICAR DATOS RUTINA
        Rutina r = rutinaRepository.findById(rutina.getId()).orElse(null);

        if (r == null) {
            r = new Rutina();

            r.setEntrenador(AuthUtils.getUser(session));
            r.setFechaCreacion(LocalDate.now());
        }

        r.setNombre(rutina.getNombre());
        r.setDificultad(dificultadRepository.findById(rutina.getDificultad()).orElse(null)); // no va a ser null, pero habria que controlarlo
        r.setDescripcion(rutina.getDescripcion()); // problema description too long

        rutinaRepository.save(r);

        // SESION
        List<SesionArgument> sesiones = rutina.getSesiones();

        // ELIMINAR SESIONES
        List<Integer> sesionesId = new ArrayList<>();
        for (SesionArgument sesion : sesiones)
            sesionesId.add(sesion.getId());

        List<Sesionentrenamiento> sesionesRutina = sesionentrenamientoRepository.findSesionesByRutina(r);
        for (Sesionentrenamiento sesion : sesionesRutina) {
            if (!sesionesId.contains(sesion.getId()))
                sesionentrenamientoRepository.delete(sesion);
        }

        // CREAR O EDITAR SESIONES
        for (int i = 0; i < sesiones.size(); i++) {
            SesionArgument sesion = sesiones.get(i);
            Sesionentrenamiento s = sesionentrenamientoRepository.findById(sesion.getId()).orElse(null);

            if (s == null) {
                s = new Sesionentrenamiento();

                s.setRutina(r);
            }

            s.setNombre(sesion.getNombre());
            s.setDia(i + 1);
            s.setDescripcion(sesion.getDescripcion());

            sesionentrenamientoRepository.save(s);

            // EJERCICIOS
            List<EjercicioArgument> ejercicios = sesion.getEjercicios();

            // ELIMINAR EJERCICIOS
            List<Integer> ejerciciosId = new ArrayList<>();
            for (EjercicioArgument ejercicio : ejercicios)
                ejerciciosId.add(ejercicio.getId());

            List<Ejerciciosesion> ejerciciossesion = ejercicioSesionRepository.findEjerciciosBySesion(s);
            for (Ejerciciosesion ejerciciosesion : ejerciciossesion) {
                if (!ejerciciosId.contains(ejerciciosesion.getId()))
                    ejercicioSesionRepository.delete(ejerciciosesion);
            }

            // CREAR O EDITAR SESIONES
            for (int j = 0; j < ejercicios.size(); j++) {
                EjercicioArgument ejercicio = ejercicios.get(j);
                Ejerciciosesion es = ejercicioSesionRepository.findById(ejercicio.getId()).orElse(null);

                if (es == null) {
                    es = new Ejerciciosesion();

                    es.setSesionentrenamiento(s);
                }

                es.setEjercicio(ejercicioRepository.findById(ejercicio.getEjercicio()).orElse(null));
                es.setEspecificaciones(gson.toJson(ejercicio.getEspecificaciones()));
                es.setOrden(j + 1);
                es.setSesionentrenamiento(s);

                ejercicioSesionRepository.save(es);
            }
        }

        return "redirect:/entrenador/rutinas";
    }

    @GetMapping("/borrar")
    public String doBorrarRutina(@RequestParam("id") Integer id) {
        Rutina rutina = rutinaRepository.findById(id).orElse(null); // no deberia ser nunca null pero se puede probar
        List<Sesionentrenamiento> sesiones = sesionentrenamientoRepository.findSesionesByRutina(rutina);
        for (Sesionentrenamiento sesion : sesiones) {
            List<Ejerciciosesion> ejerciciossesion = ejercicioSesionRepository.findEjerciciosBySesion(sesion);
            ejercicioSesionRepository.deleteAll(ejerciciossesion);
        }
        sesionentrenamientoRepository.deleteAll(sesiones);
        rutinaRepository.delete(rutina);

        return "redirect:/entrenador/rutinas";
    }

    /*
        SESIONES DE ENTRENAMIENTO
     */
    @GetMapping("/crear/sesion/ver")
    public String doVerSesion(@RequestParam("cache") String cache,
                              @RequestParam("pos") Integer pos, Model model) {
        RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);
        SesionArgument sesion = rutina.getSesiones().get(pos);

        List<Integer> ids = new ArrayList<>();
        for (EjercicioArgument ejerciciosesion : sesion.getEjercicios())
            ids.add(ejerciciosesion.getEjercicio());
        List<Ejercicio> ejercicios = ejercicioRepository.findAll();

        model.addAttribute("ejercicios", ejercicios);
        model.addAttribute("readOnly", true);
        model.addAttribute("sesionPos", pos);
        model.addAttribute("oldSesion", "{}");
        model.addAttribute("cache", gson.toJson(rutina));

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/crear/sesion")
    public String doCrearSesion(@RequestParam("cache") String cache, Model model) {
        RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);
        SesionArgument sesion = new SesionArgument();
        sesion.setId(-1);

        rutina.getSesiones().add(sesion);

        model.addAttribute("sesionPos", rutina.getSesiones().size() - 1);
        model.addAttribute("oldSesion", "{}");
        model.addAttribute("cache", gson.toJson(rutina));

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/crear/sesion/editar")
    public String doEditarSesion(@RequestParam("cache") String cache,
                                 @RequestParam("oldSesion") String oldSesion,
                                 @RequestParam("pos") Integer pos, Model model) {
        RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);
        SesionArgument sesion = rutina.getSesiones().get(pos);

        List<Integer> ids = new ArrayList<>();
        for (EjercicioArgument ejerciciosesion : sesion.getEjercicios())
            ids.add(ejerciciosesion.getEjercicio());
        List<Ejercicio> ejercicios = ejercicioRepository.findAll();

        model.addAttribute("ejercicios", ejercicios);
        model.addAttribute("sesionPos", pos);
        model.addAttribute("oldSesion", oldSesion);
        model.addAttribute("cache", gson.toJson(rutina));

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/crear/sesion/borrar")
    public String doBorrarSesion(@RequestParam("cache") String cache,
                                 @RequestParam("pos") Integer pos) {
        RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);
        rutina.getSesiones().remove((int) pos);

        String jsonCache = gson.toJson(rutina);
        String encodedCache = URLEncoder.encode(jsonCache, StandardCharsets.UTF_8);

        return "redirect:/entrenador/rutinas/editar?cache=" + encodedCache;
    }

    /*
        EJERCICIOS
     */
    @GetMapping("/crear/ejercicio/seleccionar")
    public String doSeleccionarEjercicio(@RequestParam("cache") String cache,
                                         @RequestParam("oldSesion") String oldSesion,
                                         @RequestParam("pos") Integer pos, Model model) {
        RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);
        List<Ejercicio> ejerciciosBase = ejercicioRepository.findAll();

        EjercicioArgument ejercicio = new EjercicioArgument();
        ejercicio.setId(-1);

        rutina.getSesiones().get(pos).getEjercicios().add(ejercicio);

        model.addAttribute("ejercicioPos", -1);
        model.addAttribute("sesionPos", pos);
        model.addAttribute("oldSesion", gson.toJson(oldSesion));
        model.addAttribute("cache", gson.toJson(rutina));
        model.addAttribute("ejerciciosBase", ejerciciosBase);

        return "/entrenador/crud/seleccionar_ejercicio";
    }

    @GetMapping("/crear/ejercicio")
    public String doCrearEjercicio(@RequestParam("cache") String cache,
                                   @RequestParam("ejercicioPos") Integer ejercicioPos,
                                   @RequestParam("oldSesion") String oldSesion,
                                   @RequestParam("pos") Integer pos,
                                   @RequestParam("ejbase") Integer ejbase, Model model) {
        RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);
        Ejercicio ejercicioBase = ejercicioRepository.findById(ejbase).orElse(null);

        model.addAttribute("ejercicioPos", ejercicioPos);
        model.addAttribute("sesionPos", pos);
        model.addAttribute("oldSesion", gson.toJson(oldSesion));
        model.addAttribute("cache", gson.toJson(rutina));
        model.addAttribute("ejercicioBase", ejercicioBase);

        return "/entrenador/crud/crear_ejercicio_sesion";
    }

    @GetMapping("/crear/ejercicio/borrar")
    public String doBorrarEjercicio(@RequestParam("cache") String cache,
                                    @RequestParam("oldSesion") String oldSesion,
                                    @RequestParam("pos") Integer pos,
                                    @RequestParam("ejPos") Integer ejPos) {
        RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);
        rutina.getSesiones().get(pos).getEjercicios().remove((int) ejPos);

        String jsonCache = gson.toJson(rutina);
        String encodedCache = URLEncoder.encode(jsonCache, StandardCharsets.UTF_8);
        String encodedOldSesion = URLEncoder.encode(oldSesion, StandardCharsets.UTF_8);

        return "redirect:/entrenador/rutinas/crear/sesion/editar?cache=" + encodedCache + "&oldSesion=" + encodedOldSesion + "&pos=" + pos;
    }
}
