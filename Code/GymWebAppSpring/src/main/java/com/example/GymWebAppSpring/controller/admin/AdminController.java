package com.example.GymWebAppSpring.controller.admin;


import com.example.GymWebAppSpring.dto.EntrenadorasignadoDTO;
import com.example.GymWebAppSpring.dto.EntrenadorasignadoIdDTO;
import com.example.GymWebAppSpring.dto.TipousuarioDTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.service.EntrenadorAsignadoService;
import com.example.GymWebAppSpring.service.TipoUsuarioService;
import com.example.GymWebAppSpring.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

import static com.example.GymWebAppSpring.util.AuthUtils.isAdmin;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private TipoUsuarioService tipoUsuarioService;

    @Autowired
    private EntrenadorAsignadoService entrenadorAsignadoService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        return "admin/dashboard";
    }

    /* ------------------------- Assign Functions */
    @GetMapping("/assign")
    public String asignarEntrenadorPage(@RequestParam("id") Integer id, Model model, HttpSession session){
        UsuarioDTO user = usuarioService.findById(id);
        if(!isAdmin(session))
            return "redirect:/login";

        if(!user.getTipo().getNombre().equals("Cliente"))
            return "redirect:/admin/users/";

        TipousuarioDTO fuerza = tipoUsuarioService.findByName("Entrenador de Fuerza");
        TipousuarioDTO crossfit = tipoUsuarioService.findByName("Entrenador de Crossfit");

        model.addAttribute("user",user);
        model.addAttribute("strength-trainers", usuarioService.findUsuarioByTipoUsuario(fuerza));
        model.addAttribute("crossfit-trainers", usuarioService.findUsuarioByTipoUsuario(crossfit));
        model.addAttribute("sTrainers", entrenadorAsignadoService.findEntrenadoresByClientID(user));
        return "admin/users/assign-trainer";
    }

    @PostMapping("/assign")
    public String asignarEntrenador(
            @RequestParam("user") Integer usuario,
            @RequestParam(value = "trainers", required = false) List<Integer> trainers,
            HttpSession session
    ){
        UsuarioDTO user = usuarioService.findById(usuario);
        if(!isAdmin(session))
            return "redirect:/login";

        if(user == null || !user.getTipo().getNombre().equals("Cliente"))
            return "redirect:/admin/users/";

        entrenadorAsignadoService.deleteAll(entrenadorAsignadoService.findByCliente(user).stream().map((u) -> {
            EntrenadorasignadoIdDTO id = new EntrenadorasignadoIdDTO(){{
                setCliente(u.getCliente().getId());
                setEntrenador(u.getEntrenador().getId());
            }};

            return id;
        }).toList());
        if(trainers == null || trainers.isEmpty())
            return "redirect:/admin/users/";

        List<EntrenadorasignadoDTO> entrenadorasignados = new ArrayList<>();

        for(Integer trainerID : trainers){
            UsuarioDTO trainer = usuarioService.findById(trainerID == null ? -1 : trainerID);
            if (trainer != null && trainer.getTipo().getNombre().contains("Entrenador")){
                EntrenadorasignadoDTO asignado = new EntrenadorasignadoDTO();
                asignado.setEntrenador(trainer);
                asignado.setCliente(user);
                EntrenadorasignadoIdDTO id = new EntrenadorasignadoIdDTO();
                id.setEntrenador(trainerID);
                id.setCliente(user.getId());
                asignado.setId(id);
                entrenadorasignados.add(asignado);
            }
        }

        entrenadorAsignadoService.saveAll(entrenadorasignados);

        return "redirect:/admin/users/";
    }
    /* ------------------------- End Assign Functions */
}
