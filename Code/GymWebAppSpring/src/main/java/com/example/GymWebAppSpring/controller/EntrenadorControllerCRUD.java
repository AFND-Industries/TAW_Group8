package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.DificultadRepository;
import com.example.GymWebAppSpring.dao.RutinaRepository;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Usuario;
import com.example.GymWebAppSpring.util.AuthUtils;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/entrenador/rutinas")
public class EntrenadorControllerCRUD {
    // preguntar como hacer un post o si puedo hacerlo con javascript o que
    // si psa algo por usar post
    // preguntar como hago lo de editar/<%=rutina.getId()%> de una manera mas elegante
    // como hago que lo de arriba sea un string referenciable prefix o path

    @Autowired
    protected RutinaRepository rutinaRepository;

    @Autowired
    protected DificultadRepository dificultadRepository;

    @GetMapping("")
    public String doRutinas(HttpSession session, Model model) {
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";

        Usuario entrenador = AuthUtils.getUser(session);
        List<Rutina> rutinas = rutinaRepository.findRutinaByEntrenadorId(entrenador);

        model.addAttribute("rutinas", rutinas);

        return "/entrenador/crud/rutinas";
    }

    @GetMapping("/crear")
    public String doCrearRutina(Model model) {
        Rutina rutina = new Rutina();
        rutina.setId(-1);

        model.addAttribute("rutina", rutina);

        return "/entrenador/crud/crear_rutina";
    }

    @GetMapping("/editar")
    public String doEditarRutina(@RequestParam("id") Integer id, Model model) {
        Rutina rutina = rutinaRepository.findById(id).orElse(null);

        model.addAttribute("rutina", rutina);

        return "/entrenador/crud/crear_rutina";
    }

    @GetMapping("/guardar")
    public String doGuardar(@RequestParam("id") Integer id,
                            @RequestParam("nombre") String nombre,
                            @RequestParam("dificultad") Integer dificultad,
                            @RequestParam("descripcion") String descripcion,
                            HttpSession session) {

        Rutina rutina = rutinaRepository.findById(id).orElse(null);

        if (rutina == null) {
            rutina = new Rutina();

            rutina.setEntrenador(AuthUtils.getUser(session));
            rutina.setFechaCreacion(LocalDate.now());
        }

        rutina.setNombre(nombre);
        rutina.setDificultad(dificultadRepository.findById(dificultad).orElse(null)); // no va a ser null, pero habria que controlarlo
        rutina.setDescripcion(descripcion); // problema description too long

        rutinaRepository.save(rutina);

        return "redirect:/entrenador/rutinas";
    }

    @GetMapping("/ver")
    public String doVerRutina() {
        return "redirect:/entrenador/rutinas/crear";
    }

    @GetMapping("/crear/sesion")
    public String doCrearSesion() {
        return "/entrenador/crud/crear_sesion";
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
