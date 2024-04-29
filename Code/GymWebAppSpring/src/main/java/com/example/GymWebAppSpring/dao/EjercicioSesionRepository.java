package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Ejercicio;
import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EjercicioSesionRepository extends JpaRepository<Ejercicio, Integer> {

    @Query("SELECT e FROM Ejerciciosesion e WHERE e.sesionentrenamiento = :sesionEntre")
    List<Ejerciciosesion> findEjercicioSesionBySesionEntrenamiento(@Param("sesionEntre") Sesionentrenamiento sesionentrenamiento);
}
