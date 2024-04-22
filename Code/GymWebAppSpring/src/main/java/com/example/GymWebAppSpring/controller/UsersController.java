package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.TipoUsuarioRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.entity.Usuario;
import com.example.GymWebAppSpring.util.HashUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import static com.example.GymWebAppSpring.util.AuthUtils.isAdmin;

@Controller
public class UsersController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private TipoUsuarioRepository tipoUsuarioRepository;

    /* ------------------------- Auth Functions */
    @GetMapping("/login")
    public String loginPage(){
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("dni") String dni, @RequestParam("clave") String password, Model model, HttpSession session) {
        String passDigest = HashUtils.hashString(password);
        Usuario usuario = usuarioRepository.findUsuarioByDniAndClave(dni,passDigest);
        if (usuario != null){
            session.setAttribute("user",usuario);
            return "redirect:/";
        }

        model.addAttribute("error", "El usuario o la contraseña no son válidos");
        return "auth/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/";
    }
    /* ------------------------- End Auth Functions */

    /* ------------------------- Register Functions */
    @GetMapping("/register")
    public String registerPage(HttpSession session){
        if (!isAdmin(session)){
            return "redirect:/";
        }
        return "admin/users/edit-user";
    }


    @PostMapping("/register")
    public String register(
            @RequestParam("dni") String dni,
            @RequestParam("nombre") String nombre,
            @RequestParam("apellidos") String apellido,
            @RequestParam("edad") int edad,
            @RequestParam("clave") String password,
            @RequestParam("tipoUsuario") int tipo,
            @RequestParam("genero") char genero,
            Model model,
            HttpSession session
    ){
        if (!isAdmin(session)){
            return "redirect:/";
        }
        Usuario usuario = new Usuario(){{
            setDni(dni);
            setNombre(nombre);
            setEdad(edad);
            setGenero(genero);
            setApellidos(apellido);
            setClave(HashUtils.hashString(password));
            setTipo(tipoUsuarioRepository.findById(tipo).get());
        }};

        usuarioRepository.save(usuario);
        return "redirect:/";
    }
    /* ------------------------- End Register Functions */

    /* ------------------------- Edit Functions */
    @GetMapping("/edit")
    public String editPage(@RequestParam("id") Usuario user, Model model, HttpSession session){
        if (!isAdmin(session)){
            return "redirect:/";
        }
        model.addAttribute("user",user);
        return "admin/users/edit-user";
    }

    @PostMapping("/edit")
    public String doEdit(
            @RequestParam("id") Usuario usuario,
            @RequestParam("dni") String dni,
            @RequestParam("nombre") String nombre,
            @RequestParam("apellidos") String apellido,
            @RequestParam("edad") int edad,
            @RequestParam("clave") String password,
            @RequestParam("tipoUsuario") int tipo,
            @RequestParam("genero") char genero,
            HttpSession session
    ){
        if (!isAdmin(session)){
            return "redirect:/";
        }
        usuario.setDni(dni);
        usuario.setNombre(nombre);
        usuario.setEdad(edad);
        usuario.setGenero(genero);
        usuario.setApellidos(apellido);
        usuario.setClave(HashUtils.hashString(password));
        usuario.setTipo(tipoUsuarioRepository.findById(tipo).get());
        usuarioRepository.save(usuario);
        return "redirect:/";
    }
    /* ------------------------- End Edit Functions*/
}
