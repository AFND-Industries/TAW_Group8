package com.example.GymWebAppSpring.controller.admin;

import com.example.GymWebAppSpring.dao.CategoriaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class CategoryController {

    @Autowired
    private CategoriaRepository categoriaRepository;
}
