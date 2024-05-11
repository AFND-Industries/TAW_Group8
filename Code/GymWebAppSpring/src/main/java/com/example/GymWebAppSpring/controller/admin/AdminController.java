package com.example.GymWebAppSpring.controller.admin;

import com.example.GymWebAppSpring.dao.EjercicioRepository;
import com.example.GymWebAppSpring.dao.EntrenadorAsignadoRepository;
import com.example.GymWebAppSpring.dao.TipoUsuarioRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.util.HashUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static com.example.GymWebAppSpring.util.AuthUtils.isAdmin;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private TipoUsuarioRepository tipoUsuarioRepository;

    @Autowired
    private EntrenadorAsignadoRepository entrenadorAsignadoRepository;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        return "admin/dashboard";
    }

    /* ------------------------- Assign Functions */
    @GetMapping("/assign")
    public String asignarEntrenadorPage(@RequestParam("id") Usuario user, Model model, HttpSession session){
        if(!isAdmin(session))
            return "redirect:/login";

        Tipousuario entrenador = tipoUsuarioRepository.findByName("Entrenador");

        model.addAttribute("user",user);
        model.addAttribute("trainers", usuarioRepository.findUsuarioByTipoUsuario(entrenador));
        model.addAttribute("sTrainers", entrenadorAsignadoRepository.findEntrenadoresByClientID(user));
        return "admin/users/assign-trainer";
    }

    @PostMapping("/assign")
    public String asignarEntrenador(
            @RequestParam("user") Usuario user,
            @RequestParam(value = "trainers", required = false) List<Usuario> trainers,
            HttpSession session
    ){
        if(!isAdmin(session))
            return "redirect:/login";

        entrenadorAsignadoRepository.deleteAll(entrenadorAsignadoRepository.findByCliente(user));
        if(trainers == null)
            return "redirect:/admin/users/";

        List<Entrenadorasignado> entrenadorasignados = new ArrayList<>();

        for(Usuario trainer : trainers){
            Entrenadorasignado asignado = new Entrenadorasignado();
            asignado.setEntrenador(trainer);
            asignado.setCliente(user);
            EntrenadorasignadoId id = new EntrenadorasignadoId();
            id.setEntrenador(trainer.getId());
            id.setCliente(user.getId());
            asignado.setId(id);
            entrenadorasignados.add(asignado);
        }

        entrenadorAsignadoRepository.saveAll(entrenadorasignados);

        return "redirect:/admin/users/";
    }
    /* ------------------------- End Assign Functions */
}
