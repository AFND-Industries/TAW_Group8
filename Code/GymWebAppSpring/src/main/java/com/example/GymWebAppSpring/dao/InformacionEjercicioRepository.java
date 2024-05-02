package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import com.example.GymWebAppSpring.entity.Informacionejercicio;
import com.example.GymWebAppSpring.entity.Informacionsesion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface InformacionEjercicioRepository extends JpaRepository<Informacionejercicio, Integer> {

    @Query("SELECT ie FROM Informacionejercicio ie WHERE ie.informacionsesion = :info AND ie.ejerciciosesion = :ejercicio")
    public Informacionejercicio findByEjercicioAndInfo(@Param("info") Informacionsesion info, @Param("ejercicio") Ejerciciosesion ejercicio);
}
