package com.example.GymWebAppSpring.controller.admin;


import com.example.GymWebAppSpring.dto.TipousuarioDTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.service.TipoUsuarioService;
import com.example.GymWebAppSpring.service.UsuarioService;
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
    private UsuarioService usuarioService;

    @Autowired
    private TipoUsuarioService tipoUsuarioService;

    /* ------------------------- Register Functions */
    @GetMapping("/register")
    public String registerPage(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";


        model.addAttribute("tiposUsuario",tipoUsuarioService.findAll());
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

        UsuarioDTO usuario = new UsuarioDTO();
        usuario.setDni(dni);
        usuario.setNombre(nombre);
        usuario.setEdad(edad);
        usuario.setGenero(genero);
        usuario.setApellidos(apellido);
        usuario.setClave(HashUtils.hashString(password));
        usuario.setTipo(tipoUsuarioService.findById(tipo));

        usuarioService.save(usuario);
        return "redirect:/admin/users/";
    }
    /* ------------------------- End Register Functions */

    /* ------------------------- Edit Functions */
    @GetMapping("/edit")
    public String editPage(@RequestParam("id") Integer id, Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        UsuarioDTO user = usuarioService.findById(id);

        model.addAttribute("user",user);
        model.addAttribute("editable",true);
        model.addAttribute("tiposUsuario",tipoUsuarioService.findAll());
        return "admin/users/edit-user";
    }

    @PostMapping("/edit")
    public String doEdit(
            @RequestParam("id") Integer id,
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

        UsuarioDTO usuario = usuarioService.findById(id);
        usuario.setDni(dni);
        usuario.setNombre(nombre);
        usuario.setEdad(edad);
        usuario.setGenero(genero);
        usuario.setApellidos(apellido);
        if(password != null && !password.isBlank())
            usuario.setClave(HashUtils.hashString(password));
        usuario.setTipo(tipoUsuarioService.findById(tipo));
        usuarioService.save(usuario);
        return "redirect:/admin/users/";
    }
    /* ------------------------- End Edit Functions*/

    /* ------------------------- Read Functions */
    @GetMapping("/view")
    public String view(@RequestParam("id") Integer id, Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        UsuarioDTO usuario = usuarioService.findById(id);
        model.addAttribute("user",usuario);

        return "admin/users/view-user";
    }
    /* ------------------------- End Read Functions */

    /* ------------------------- Delete Functions */
    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        usuarioService.delete(id);
        return "redirect:/admin/users/";
    }
    /* ------------------------- End Delete Functions */

    /* ------------------------- List Functions */
    @GetMapping("/")
    public String listUsers(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("users",usuarioService.findAll());
        model.addAttribute("tipos", tipoUsuarioService.findAll());
        return "admin/users/list-users";
    }

    @PostMapping("/")
    public String filterUsers(
            @RequestParam(value = "dni", required = false) String dni,
            @RequestParam(value = "apellidos", required = false) String apellidos,
            @RequestParam(value = "edad", required = false) Integer edad,
            @RequestParam(value = "tipo", required = false) Integer tipo,
            Model model,
            HttpSession session
    ){
        if(!isAdmin(session))
            return "redirect:/login";

        List<UsuarioDTO> users = usuarioService.findAll();
        TipousuarioDTO tipousuario = tipoUsuarioService.findById(tipo);

        if(dni != null && !dni.isBlank()){
            users.retainAll(usuarioService.findUsuarioByDNI(dni));
            model.addAttribute("dniFilter", dni);
        }
        if(apellidos != null && !apellidos.isBlank()){
            users.retainAll(usuarioService.findUsuarioByApellidos(apellidos));
            model.addAttribute("apellidosFilter", apellidos);
        }
        if(edad != null){
            users.retainAll(usuarioService.findUsuarioByEdad(edad));
            model.addAttribute("edadFilter", edad);
        }
        if(tipo != null){
            users.retainAll(usuarioService.findUsuarioByTipoUsuario(tipousuario));
            model.addAttribute("tipoFilter", tipousuario);
        }

        model.addAttribute("users",users);
        model.addAttribute("tipos", tipoUsuarioService.findAll());
        return "admin/users/list-users";
    }
    /* ------------------------- End List Functions */
}
