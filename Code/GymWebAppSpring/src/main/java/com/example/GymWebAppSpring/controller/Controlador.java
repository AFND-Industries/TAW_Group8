package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.TipoUsuarioRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.entity.Tipousuario;
import com.example.GymWebAppSpring.entity.Usuario;
import com.example.GymWebAppSpring.util.HashUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.List;

@Controller
public class Controlador {

    @Autowired
    protected UsuarioRepository usuarioRepository;

    @Autowired
    protected TipoUsuarioRepository tipoUsuarioRepository;

    @GetMapping("/")
    public String example(Model model, HttpSession session) {
        List<Usuario> usuario = this.usuarioRepository.findAll();

        if (session.getAttribute("user") == null)
            session.setAttribute("user", usuario.get(2));

        model.addAttribute("usuarios", usuario);

        return "index";
    }

    @GetMapping("/crear")
    public String doCrear() {
        return "redirect:/";
    }

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
        Usuario user = (Usuario) session.getAttribute("user");
        if (user != null && user.getTipo().getNombre().equals("Administrador")){
            return "admin/users/add-user";
        }
        return "redirect:/";
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
        String passDigest = HashUtils.hashString(password);
        Usuario usuario = new Usuario();
        usuario.setDni(dni);
        usuario.setNombre(nombre);
        usuario.setEdad(edad);
        usuario.setGenero(genero);
        usuario.setApellidos(apellido);
        usuario.setClave(passDigest);
        usuario.setTipo(tipoUsuarioRepository.findById(tipo).get());
        usuarioRepository.save(usuario);
        return "redirect:/";
    }
    /* ------------------------- End Register Functions */

    @GetMapping("/error")
    public String doError(){
        return "error";
    }
}
