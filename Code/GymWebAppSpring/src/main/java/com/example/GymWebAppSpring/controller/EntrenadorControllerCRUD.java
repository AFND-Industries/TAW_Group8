package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.DificultadRepository;
import com.example.GymWebAppSpring.dao.RutinaRepository;
import com.example.GymWebAppSpring.dao.SesionentrenamientoRepository;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import com.example.GymWebAppSpring.entity.Usuario;
import com.example.GymWebAppSpring.iu.RutinaArgument;
import com.example.GymWebAppSpring.util.AuthUtils;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
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
    @Autowired
    protected RutinaRepository rutinaRepository;

    @Autowired
    protected DificultadRepository dificultadRepository;

    @Autowired
    protected SesionentrenamientoRepository sesionentrenamientoRepository;

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
    public String doVerRutina(@RequestParam("id") Integer id, Model model) {
        Rutina r = rutinaRepository.findById(id).orElse(null);
        RutinaArgument rutina = new RutinaArgument(r);
        List<Sesionentrenamiento> sesiones = sesionentrenamientoRepository.findSesionesByRutina(r);

        model.addAttribute("readOnly", true);

        model.addAttribute("rutina", rutina);
        model.addAttribute("sesiones", sesiones);

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/crear")
    public String doCrearRutina(@ModelAttribute("rutina") RutinaArgument rutina, Model model) {
        if (rutina == null) {
            rutina = new RutinaArgument();
            rutina.setId(-1);
        }

        model.addAttribute("rutina", rutina);

        return "/entrenador/crud/rutina";
    }


    @GetMapping("/editar")
    public String doEditarRutina(@ModelAttribute("rutina") RutinaArgument rutina,
                                 @RequestParam(value = "id", required = false) Integer id, Model model) {
        Rutina r = rutinaRepository.findById(rutina.isNull() ? id : rutina.getId()).orElse(null);

        if (rutina.isNull())
            rutina = new RutinaArgument(r);

        List<Sesionentrenamiento> sesiones = sesionentrenamientoRepository.findSesionesByRutina(r);;

        model.addAttribute("rutina", rutina);
        model.addAttribute("sesiones", sesiones);

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/guardar")
    public String doGuardarRutina(@ModelAttribute("rutina") RutinaArgument rutina,
                                  HttpSession session) {
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

        return "redirect:/entrenador/rutinas";
    }

    @GetMapping("/borrar")
    public String doBorrarRutina(@RequestParam("id") Integer id) {
        Rutina rutina = rutinaRepository.findById(id).orElse(null); // no deberia ser nunca null pero se puede probar

        rutinaRepository.delete(rutina);

        return "redirect:/entrenador/rutinas";
    }

    @GetMapping("/crear/sesion/ver")
    public String doVerSesion(@RequestParam("id") Integer id, Model model) {
        Sesionentrenamiento sesion = sesionentrenamientoRepository.findById(id).orElse(null);

        model.addAttribute("readOnly", true);

        model.addAttribute("sesion", sesion);

        return "/entrenador/crud/crear_sesion";
    }

    @GetMapping("/crear/sesion")
    public String doCrearSesion(Model model) {
        Sesionentrenamiento sesion = new Sesionentrenamiento();
        sesion.setId(-1);

        model.addAttribute("sesion", sesion);

        return "/entrenador/crud/crear_sesion";
    }

    @GetMapping("/crear/sesion/editar")
    public String doEditarSesion(@RequestParam("id") Integer id, Model model) {
        Sesionentrenamiento sesion = sesionentrenamientoRepository.findById(id).orElse(null);

        model.addAttribute("sesion", sesion);

        return "/entrenador/crud/crear_sesion";
    }

    @GetMapping("/crear/sesion/guardar")
    public String doGuardarSesion(Model model) {
        return "redirect:/entrenador/rutinas";
    }

    @GetMapping("/crear/sesion/borrar")
    public String doBorrarSesion(@RequestParam("id") Integer id, Model model) {
        Sesionentrenamiento sesion = sesionentrenamientoRepository.findById(id).orElse(null);

        sesionentrenamientoRepository.delete(sesion);

        return "redirect:/entrenador/rutinas";
    }

    @GetMapping("/crear/ejercicio")
    public String doCrearEjercicio() {
        return "/entrenador/crud/crear_ejercicio_sesion";
    }

    @GetMapping("/crear/ejercicio/seleccionar")
    public String doSeleccionarEjercicio() {
        return "/entrenador/crud/seleccionar_ejercicio";
    }

    @GetMapping("/crear/ejercicio/ver")
    public String doEjercicioBase() {
        return "/entrenador/crud/ejercicio_base";
    }
}
