package com.example.GymWebAppSpring.controller.entrenador.crud;

import com.example.GymWebAppSpring.dto.DificultadDTO;
import com.example.GymWebAppSpring.dto.RutinaDTO;
import com.example.GymWebAppSpring.iu.FiltroArgument;
import com.example.GymWebAppSpring.util.AuthUtils;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/entrenador/rutinas")
public class ListadoController extends BaseController {

    @GetMapping("")
    public String doRutinas(@RequestParam(value = "changedName", required = false, defaultValue = "") String changedName,
                            @RequestParam(value = "changedCase", required = false, defaultValue = "-1") Integer changedCase,
                            Model model, HttpSession session) {
        flushContext(session);

        Integer entrenadorId = AuthUtils.getUser(session).getId();
        initializeListado(model, entrenadorId, new FiltroArgument());

        model.addAttribute("changedName", changedName);
        model.addAttribute("changedCase", changedCase);

        return "/entrenador/crud/rutinas";
    }

    @GetMapping("/filtrar")
    public String doFiltrar(@ModelAttribute("filtro") FiltroArgument filtro, Model model, HttpSession session) {
        filtro.processFiltro();

        String strTo = "/entrenador/crud/rutinas";
        if (filtro.estaVacio()) strTo = "redirect:/entrenador/rutinas";
        else {
            Integer entrenadorId = AuthUtils.getUser(session).getId();
            initializeListado(model, entrenadorId, filtro);
        }

        return strTo;
    }

    private void initializeListado(Model model, Integer entrenadorId, FiltroArgument filtro) {
        List<RutinaDTO> rutinas = rutinaService.filtrarRutinas(filtro, entrenadorId);
        List<DificultadDTO> dificultades = dificultadService.findAll();

        model.addAttribute("rutinas", rutinas);
        model.addAttribute("dificultades", dificultades);
        model.addAttribute("filtro", filtro);
    }
}
