package com.example.GymWebAppSpring.controller.admin;

import com.example.GymWebAppSpring.dao.CategoriaRepository;
import com.example.GymWebAppSpring.dao.EjercicioRepository;
import com.example.GymWebAppSpring.dao.MusculoRepository;
import com.example.GymWebAppSpring.dao.TipoFuerzaRepository;
import com.example.GymWebAppSpring.entity.Categoria;
import com.example.GymWebAppSpring.entity.Ejercicio;
import com.example.GymWebAppSpring.entity.Musculo;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import static com.example.GymWebAppSpring.util.AuthUtils.isAdmin;

import java.util.List;

@Controller
@RequestMapping("/admin/exercises")
public class ExercisesController {

    @Autowired
    private EjercicioRepository ejercicioRepository;

    @Autowired
    private CategoriaRepository categoriaRepository;

    @Autowired
    private TipoFuerzaRepository tipoFuerzaRepository;
    @Autowired
    private MusculoRepository musculoRepository;

    @GetMapping("/")
    public String ejerciciosPage(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("categorias", categoriaRepository.findAll());
        model.addAttribute("musculos", musculoRepository.findAll());
        model.addAttribute("ejercicios", ejercicioRepository.findAll());

        return "admin/exercises/list-exercises";
    }

    @PostMapping("/")
    public String ejerciciosFilters(
            @RequestParam(value = "categoria", required = false) Categoria categoria,
            @RequestParam(value = "musculo", required = false) Musculo musculo,
            @RequestParam(value = "nombre", required = false) String nombre,
            Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";
        List<Ejercicio> list = ejercicioRepository.findAll();

        if (categoria != null){
            list.retainAll(ejercicioRepository.findAllByCategoria(categoria));
            model.addAttribute("categoria", categoria);
        }
        if (musculo != null){
            list.retainAll(ejercicioRepository.findAllByMusculo(musculo));
            model.addAttribute("musculo", musculo);
        }
        if (nombre != null && !nombre.isBlank()){
            list.retainAll(ejercicioRepository.findAllByNombre(nombre));
            model.addAttribute("nombre", nombre);
        }

        model.addAttribute("categorias", categoriaRepository.findAll());
        model.addAttribute("musculos", musculoRepository.findAll());
        model.addAttribute("ejercicios",list);

        return "admin/exercises/list-exercises";
    }

    @GetMapping("/view")
    public String viewExercise(@RequestParam("id") Ejercicio ejercicio, Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";
        model.addAttribute("ejericicio", ejercicio);

        return "admin/exercises/view-exercise";
    }

    @GetMapping("/edit")
    public String editExercisePage(@RequestParam("id") Ejercicio ejercicio, Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("ejercicio", ejercicio);
        model.addAttribute("categorias", categoriaRepository.findAll());
        model.addAttribute("musculos", musculoRepository.findAll());
        model.addAttribute("tipos", tipoFuerzaRepository.findAll());

        return "admin/exercises/edit-exercise";
    }

    @PostMapping("/edit")
    public String editExercise(@ModelAttribute Ejercicio ejercicio, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        ejercicioRepository.save(ejercicio);

        return "redirect:/admin/exercises/";
    }

    @GetMapping("/new")
    public String addExercisePage(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("ejercicio", new Ejercicio());
        model.addAttribute("categorias", categoriaRepository.findAll());
        model.addAttribute("musculos", musculoRepository.findAll());
        model.addAttribute("tipos", tipoFuerzaRepository.findAll());

        return "admin/exercises/edit-exercise";
    }

    @GetMapping("/delete")
    public String deleteExercise(@RequestParam("id") Ejercicio ejercicio, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        ejercicioRepository.delete(ejercicio);

        return "redirect:/admin/exercises/";
    }
}
