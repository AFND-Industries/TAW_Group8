package com.example.GymWebAppSpring.controller.admin;

import com.example.GymWebAppSpring.dao.EntrenadorAsignadoRepository;
import com.example.GymWebAppSpring.dao.TipoUsuarioRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.entity.Entrenadorasignado;
import com.example.GymWebAppSpring.entity.EntrenadorasignadoId;
import com.example.GymWebAppSpring.entity.Tipousuario;
import com.example.GymWebAppSpring.entity.Usuario;
import com.example.GymWebAppSpring.util.HashUtils;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
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

    /* ------------------------- Read Functions */
    @GetMapping("/view")
    public String view(@RequestParam("id") Usuario usuario, Model model, HttpSession session){
        if (!isAdmin(session)){
            return "redirect:/";
        }
        model.addAttribute("user",usuario);
        model.addAttribute("tiposUsuario",tipoUsuarioRepository.findAll());
        model.addAttribute("editable",false);
        return "admin/users/edit-user";
    }
    /* ------------------------- End Read Functions */

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
        if (!isAdmin(session))
            return "redirect:/";

        model.addAttribute("users",usuarioRepository.findAll());
        model.addAttribute("tipos", tipoUsuarioRepository.findAll());
        return "admin/users/list-users";
    }

    @PostMapping("/users")
    public String filterUsers(
            @RequestParam(value = "dni", required = false) String dni,
            @RequestParam(value = "apellidos", required = false) String apellidos,
            @RequestParam(value = "edad", required = false) Integer edad,
            @RequestParam(value = "tipo", required = false) Tipousuario tipo,
            Model model,
            HttpSession session
    ){
        if(!isAdmin(session))
            return "redirect:/";

        List<Usuario> users = usuarioRepository.findAll();

        if(dni != null)
            users.retainAll(usuarioRepository.findUsuarioByDNI(dni));
        if(apellidos != null)
            users.retainAll(usuarioRepository.findUsuarioByApellidos(apellidos));
        if(edad != null)
            users.retainAll(usuarioRepository.findUsuarioByEdad(edad));
        if(tipo != null)
            users.retainAll(usuarioRepository.findUsuarioByTipoUsuario(tipo));

        model.addAttribute("users",users);
        model.addAttribute("tipos", tipoUsuarioRepository.findAll());
        return "admin/users/list-users";
    }
    /* ------------------------- End List Functions */

    /* ------------------------- Assign Functions */
    @GetMapping("/assign")
    public String asignarEntrenadorPage(@RequestParam("id") Usuario user, Model model, HttpSession session){
        if(!isAdmin(session))
            return "redirect:/";

        Tipousuario cliente = tipoUsuarioRepository.findByName("Cliente");
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
            return "redirect:/";

        entrenadorAsignadoRepository.deleteAll(entrenadorAsignadoRepository.findByCliente(user));
        if(trainers == null)
            return "redirect:/admin/users";

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

        return "redirect:/admin/users";
    }
    /* ------------------------- End Assign Functions */
}
