package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {

    @Query("select c from Categoria c where c.nombre like %:nombre%")
    List<Categoria> findByNombre(String nombre);
}
