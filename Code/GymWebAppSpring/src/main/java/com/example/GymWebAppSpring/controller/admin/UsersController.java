package com.example.GymWebAppSpring.controller.admin;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

import static com.example.GymWebAppSpring.util.AuthUtils.isAdmin;

@Controller
@RequestMapping("/admin/users")
public class UsersController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private TipoUsuarioRepository tipoUsuarioRepository;

    /* ------------------------- Register Functions */
    @GetMapping("/register")
    public String registerPage(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";


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
        if (!isAdmin(session))
            return "redirect:/login";

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
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("user",user);
        model.addAttribute("editable",true);
        model.addAttribute("tiposUsuario",tipoUsuarioRepository.findAll());
        return "admin/users/edit-user";
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
        if (!isAdmin(session))
            return "redirect:/login";

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

    /* ------------------------- Read Functions */
    @GetMapping("/view")
    public String view(@RequestParam("id") Usuario usuario, Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("user",usuario);

        return "admin/users/view-user";
    }
    /* ------------------------- End Read Functions */

    /* ------------------------- Delete Functions */
    @GetMapping("/delete")
    public String delete(@RequestParam("id") Usuario usuario, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        usuarioRepository.delete(usuario);
        return "redirect:/admin/users";
    }
    /* ------------------------- End Delete Functions */

    /* ------------------------- List Functions */
    @GetMapping("/")
    public String listUsers(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("users",usuarioRepository.findAll());
        model.addAttribute("tipos", tipoUsuarioRepository.findAll());
        return "admin/users/list-users";
    }

    @PostMapping("/")
    public String filterUsers(
            @RequestParam(value = "dni", required = false) String dni,
            @RequestParam(value = "apellidos", required = false) String apellidos,
            @RequestParam(value = "edad", required = false) Integer edad,
            @RequestParam(value = "tipo", required = false) Tipousuario tipo,
            Model model,
            HttpSession session
    ){
        if(!isAdmin(session))
            return "redirect:/login";

        List<Usuario> users = usuarioRepository.findAll();

        if(dni != null && !dni.isBlank()){
            users.retainAll(usuarioRepository.findUsuarioByDNI(dni));
            model.addAttribute("dniFilter", dni);
        }
        if(apellidos != null && !apellidos.isBlank()){
            users.retainAll(usuarioRepository.findUsuarioByApellidos(apellidos));
            model.addAttribute("apellidosFilter", apellidos);
        }
        if(edad != null){
            users.retainAll(usuarioRepository.findUsuarioByEdad(edad));
            model.addAttribute("edadFilter", edad);
        }
        if(tipo != null){
            users.retainAll(usuarioRepository.findUsuarioByTipoUsuario(tipo));
            model.addAttribute("tipoFilter", tipo);
        }

        model.addAttribute("users",users);
        model.addAttribute("tipos", tipoUsuarioRepository.findAll());
        return "admin/users/list-users";
    }
    /* ------------------------- End List Functions */
}
