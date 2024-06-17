package com.example.GymWebAppSpring.controller.admin;

import com.example.GymWebAppSpring.dto.CategoriaDTO;
import com.example.GymWebAppSpring.dto.EjercicioDTO;
import com.example.GymWebAppSpring.dto.MusculoDTO;
import com.example.GymWebAppSpring.service.CategoriaService;
import com.example.GymWebAppSpring.service.EjercicioService;
import com.example.GymWebAppSpring.service.MusculoService;
import com.example.GymWebAppSpring.service.TipoFuerzaService;
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
    private EjercicioService ejercicioService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private TipoFuerzaService tipoFuerzaService;

    @Autowired
    private MusculoService musculoService;

    @GetMapping("/")
    public String ejerciciosPage(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("categorias", categoriaService.findAll());
        model.addAttribute("musculos", musculoService.findAll());
        model.addAttribute("ejercicios", ejercicioService.findAll());

        return "admin/exercises/list-exercises";
    }

    @PostMapping("/")
    public String ejerciciosFilters(
            @RequestParam(value = "categoria", required = false) Integer _categoria,
            @RequestParam(value = "musculo", required = false) Integer _musculo,
            @RequestParam(value = "nombre", required = false) String nombre,
            Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";
        CategoriaDTO categoria = categoriaService.findById(_categoria);
        MusculoDTO musculo = musculoService.findById(_musculo);
        List<EjercicioDTO> list = ejercicioService.findAll();

        if (categoria != null){
            list.retainAll(ejercicioService.findAllByCategoria(categoria.getId()));
            model.addAttribute("categoria", categoria);
        }
        if (musculo != null){
            list.retainAll(ejercicioService.findAllByMusculo(musculo.getId()));
            model.addAttribute("musculo", musculo);
        }
        if (nombre != null && !nombre.isBlank()){
            list.retainAll(ejercicioService.findAllByNombre(nombre));
            model.addAttribute("nombre", nombre);
        }

        model.addAttribute("categorias", categoriaService.findAll());
        model.addAttribute("musculos", musculoService.findAll());
        model.addAttribute("ejercicios",list);

        return "admin/exercises/list-exercises";
    }

    @GetMapping("/view")
    public String viewExercise(@RequestParam("id") Integer id, Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        EjercicioDTO ejercicio = ejercicioService.findById(id);
        model.addAttribute("ejericicio", ejercicio);

        return "admin/exercises/view-exercise";
    }

    @GetMapping("/edit")
    public String editExercisePage(@RequestParam("id") Integer id, Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        EjercicioDTO ejercicio = ejercicioService.findById(id);

        model.addAttribute("ejercicio", ejercicio);
        model.addAttribute("categorias", categoriaService.findAll());
        model.addAttribute("musculos", musculoService.findAll());
        model.addAttribute("tipos", tipoFuerzaService.findAll());

        return "admin/exercises/edit-exercise";
    }

    @PostMapping("/edit")
    public String editExercise(@ModelAttribute EjercicioDTO ejercicio, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        ejercicioService.save(ejercicio);

        return "redirect:/admin/exercises/";
    }

    @GetMapping("/new")
    public String addExercisePage(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("ejercicio", new EjercicioDTO());
        model.addAttribute("categorias", categoriaService.findAll());
        model.addAttribute("musculos", musculoService.findAll());
        model.addAttribute("tipos", tipoFuerzaService.findAll());

        return "admin/exercises/edit-exercise";
    }

    @GetMapping("/delete")
    public String deleteExercise(@RequestParam("id") Integer id, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        ejercicioService.delete(id);

        return "redirect:/admin/exercises/";
    }
}
