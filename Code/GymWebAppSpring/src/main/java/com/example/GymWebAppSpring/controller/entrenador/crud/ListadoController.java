package com.example.GymWebAppSpring.controller.entrenador.crud;

import com.example.GymWebAppSpring.dto.RutinaDTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.iu.FiltroArgument;
import com.example.GymWebAppSpring.service.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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
    public String doRutinas(@RequestParam(value = "changed", required = false) Integer changed,
                            @RequestParam(value = "mode", required = false) Integer mode,
                            Model model, HttpSession session) {
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";

        flushContext(session);
        List<RutinaDTO> rutinas = rutinaService.findRutinaByEntrenadorId(AuthUtils.getUser(session).getId());

        model.addAttribute("rutinas", rutinas);
        model.addAttribute("dificultades", dificultadService.findAll());
        model.addAttribute("filtro", new FiltroArgument());
        if (changed != null) model.addAttribute("rutinaChanged", rutinaService.findById(changed));
        if (mode != null) model.addAttribute("changeMode", mode);

        return "/entrenador/crud/rutinas";
    }

    @GetMapping("/filtrar")
    public String doFiltrar(@ModelAttribute("filtro") FiltroArgument filtro,
                            Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session)) {
            return "redirect:/";
        }

        // Si se ignora uno de los dos campos, el otro también, pues van de la mano
        if (filtro.getIntegerSesionNum() == -1 || filtro.getSesionMode() == -1) {
            filtro.setSesionMode(-1);
            filtro.setSesionNum("");
        }

        if (filtro.estaVacio()) {
            return "redirect:/entrenador/rutinas";
        }

        UsuarioDTO entrenador = AuthUtils.getUser(session);
        List<RutinaDTO> rutinas = rutinaService.filtrarRutinas(filtro, entrenador.getId());

        model.addAttribute("rutinas", rutinas);
        model.addAttribute("dificultades", dificultadService.findAll());
        model.addAttribute("filtro", filtro);

        return "/entrenador/crud/rutinas";
    }
}
