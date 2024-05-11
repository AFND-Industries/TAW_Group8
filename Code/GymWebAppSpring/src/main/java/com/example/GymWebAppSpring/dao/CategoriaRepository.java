package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {
}
