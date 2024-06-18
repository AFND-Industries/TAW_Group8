package com.example.GymWebAppSpring.controller.admin;

import com.example.GymWebAppSpring.dto.CategoriaDTO;
import com.example.GymWebAppSpring.service.CategoriaService;
import com.google.gson.JsonArray;
import jakarta.servlet.http.HttpSession;
import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.example.GymWebAppSpring.util.AuthUtils.isAdmin;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/")
    public String listCategories(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("categorias", categoriaService.findAll());

        return "admin/categories/list-categories";
    }

    @PostMapping("/")
    public String categoriaFilter(@RequestParam("nombre") String nombre, HttpSession session, Model model){
        if (!isAdmin(session))
                return "redirect:/login";

        model.addAttribute("categorias", categoriaService.findByNombre(nombre));
        model.addAttribute("nombre", nombre);

        return "admin/categories/list-categories";
    }

    @GetMapping("/view")
    public String viewCategorie(@RequestParam("id") Integer id, Model model, HttpSession session) throws ParseException {
        if (!isAdmin(session))
            return "redirect:/login";

        CategoriaDTO categoria = categoriaService.findById(id);

        if (categoria == null) return "redirect:/admin/categories/";

        JSONParser tipos = new JSONParser(categoria.getTiposBase());

        model.addAttribute("categoria", categoria);
        model.addAttribute("tipos", tipos.list());

        return "admin/categories/view-category";
    }

    @GetMapping("/new")
    public String addCategoryPage(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("categoria", new CategoriaDTO());

        return "admin/categories/edit-category";
    }

    @GetMapping("/edit")
    public String editCategoryPage(@RequestParam("id") Integer id,Model model, HttpSession session) throws ParseException {
        if (!isAdmin(session))
            return "redirect:/login";

        CategoriaDTO categoria = categoriaService.findById(id);

        if (categoria == null) return "redirect:/admin/categories/";

        JSONParser tipos = new JSONParser(categoria.getTiposBase());

        model.addAttribute("categoria", categoria);
        model.addAttribute("tipos", tipos.list());

        return "admin/categories/edit-category";
    }

    @PostMapping("/edit")
    public String editCategory(@ModelAttribute CategoriaDTO categoria,
                               @RequestParam(value = "tipos", required = false) List<String> tipos,
                               HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        JsonArray array = new JsonArray();
        for (String t : tipos) array.add(t);

        categoria.setTiposBase(array.toString());

        categoriaService.save(categoria);

        return "redirect:/admin/categories/";
    }

    @GetMapping("/delete")
    public String deleteCategory(@RequestParam("id") Integer id,HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        categoriaService.delete(id);

        return "redirect:/admin/categories/";
    }
}
