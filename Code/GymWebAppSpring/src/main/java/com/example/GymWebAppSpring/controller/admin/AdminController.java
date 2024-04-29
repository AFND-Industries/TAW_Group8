package com.example.GymWebAppSpring.controller.admin;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import static com.example.GymWebAppSpring.util.AuthUtils.isAdmin;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private TipoUsuarioRepository tipoUsuarioRepository;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session){
        if (!isAdmin(session)){
            return "redirect:/";
        }
        return "admin/dashboard";
    }

    /* ------------------------- Register Functions */
    @GetMapping("/register")
    public String registerPage(Model model, HttpSession session){
        if (!isAdmin(session)){
            return "redirect:/";
        }

        model.addAttribute("tiposUsuario",tipoUsuarioRepository.findAll());
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
        Usuario usuario = new Usuario();
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
    /* ------------------------- End Register Functions */

    /* ------------------------- Edit Functions */
    @GetMapping("/edit")
    public String editPage(@RequestParam("id") Usuario user, Model model, HttpSession session){
        if (!isAdmin(session)){
            return "redirect:/";
        }
        model.addAttribute("user",user);
        model.addAttribute("tiposUsuario",tipoUsuarioRepository.findAll());
        return "admin/users-crud/edit-user";
    }

    @PostMapping("/edit")
    public String doEdit(
            @RequestParam("id") Usuario usuario,
            @RequestParam("dni") String dni,
            @RequestParam("nombre") String nombre,
            @RequestParam("apellidos") String apellido,
            @RequestParam("edad") int edad,
            @RequestParam(value = "clave", required = false) String password,
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
        if(password != null && !password.isBlank())
            usuario.setClave(HashUtils.hashString(password));
        usuario.setTipo(tipoUsuarioRepository.findById(tipo).get());
        usuarioRepository.save(usuario);
        return "redirect:/admin/users";
    }
    /* ------------------------- End Edit Functions*/

    /* ------------------------- Delete Functions */
    @GetMapping("/delete")
    public String delete(@RequestParam("id") Usuario usuario, HttpSession session){
        if (!isAdmin(session)){
            return "redirect:/";
        }
        usuarioRepository.delete(usuario);
        return "redirect:/admin/users";
    }
    /* ------------------------- End Delete Functions */

    /* ------------------------- List Functions */
    @GetMapping("/users")
    public String listUsers(Model model, HttpSession session){
        if (!isAdmin(session)){
            return "redirect:/";
        }
        model.addAttribute("users",usuarioRepository.findAll());
        return "admin/users-crud/list-users";
    }
    /* ------------------------- End List Functions */
}
