package com.example.GymWebAppSpring.controller.admin;

import ch.qos.logback.classic.encoder.JsonEncoder;
import com.example.GymWebAppSpring.dao.CategoriaRepository;
import com.example.GymWebAppSpring.entity.Categoria;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
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
    private CategoriaRepository categoriaRepository;

    @GetMapping("/")
    public String listCategories(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("categorias", categoriaRepository.findAll());

        return "admin/categories/list-categories";
    }

    @PostMapping("/")
    public String categoriaFilter(HttpSession session){
        if (!isAdmin(session))
                return "redirect:/login";

        return "admin/categories/list-categories";
    }

    @GetMapping("/view")
    public String viewCategorie(@RequestParam("id")Categoria categoria, Model model, HttpSession session) throws ParseException {
        if (!isAdmin(session))
            return "redirect:/login";

        JSONParser tipos = new JSONParser(categoria.getTiposBase());

        model.addAttribute("categoria", categoria);
        model.addAttribute("tipos", tipos.list());

        return "admin/categories/view-category";
    }

    @GetMapping("/new")
    public String addCategoryPage(Model model, HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("categoria", new Categoria());

        return "admin/categories/edit-category";
    }

    @GetMapping("/edit")
    public String editCategoryPage(@RequestParam("id") Categoria categoria,Model model, HttpSession session) throws ParseException {
        if (!isAdmin(session))
            return "redirect:/login";

        JSONParser tipos = new JSONParser(categoria.getTiposBase());

        model.addAttribute("categoria", categoria);
        model.addAttribute("tipos", tipos.list());

        return "admin/categories/edit-category";
    }

    @PostMapping("/edit")
    public String editCategory(@ModelAttribute Categoria categoria,
                               @RequestParam(value = "tipos", required = false) List<String> tipos,
                               HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        JsonArray array = new JsonArray();
        for (String t : tipos) array.add(t);

        categoria.setTiposBase(array.toString());

        categoriaRepository.save(categoria);

        return "redirect:/admin/categories/";
    }

    @GetMapping("/delete")
    public String deleteCategory(@RequestParam("id") Categoria categoria,HttpSession session){
        if (!isAdmin(session))
            return "redirect:/login";

        categoriaRepository.delete(categoria);

        return "redirect:/admin/categories/";
    }
}
