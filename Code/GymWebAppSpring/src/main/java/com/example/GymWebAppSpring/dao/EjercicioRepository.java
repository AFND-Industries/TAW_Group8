package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Ejercicio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface EjercicioRepository extends JpaRepository<Ejercicio, Integer> {

    @Query("select e from Ejercicio e where e.categoria.id = 1") // Categoria 1 es Fuerza
    public List<Ejercicio> findAllEjerciciosFuerza();
}
