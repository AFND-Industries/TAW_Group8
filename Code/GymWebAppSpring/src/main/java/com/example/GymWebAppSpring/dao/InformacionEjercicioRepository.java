package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import com.example.GymWebAppSpring.entity.Informacionejercicio;
import com.example.GymWebAppSpring.entity.Informacionsesion;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface InformacionEjercicioRepository extends JpaRepository<Informacionejercicio, Integer> {

    @Query("SELECT ie FROM Informacionejercicio ie WHERE ie.informacionsesion = :info AND ie.ejerciciosesion = :ejercicio")
    public Informacionejercicio findByEjerciciosesionAndInformacionsesion(@Param("ejercicio") Ejerciciosesion ejercicio, @Param("info") Informacionsesion info);

    @Query("SELECT ie FROM Informacionejercicio ie , Sesionentrenamiento se WHERE ie.ejerciciosesion.sesionentrenamiento = se AND se = :sesion")
    public List<Informacionejercicio> findBySesionentrenamiento(Sesionentrenamiento sesion);
}
