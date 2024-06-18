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

    @Query("SELECT ie FROM Informacionejercicio ie WHERE ie.informacionsesion.id = :info AND ie.ejerciciosesion.id = :ejercicio")
    public Informacionejercicio findByEjerciciosesionAndInformacionsesion(@Param("ejercicio") Integer ejercicio, @Param("info") Integer info);

    @Query("SELECT ie FROM Informacionejercicio ie , Sesionentrenamiento se WHERE ie.ejerciciosesion.sesionentrenamiento = se AND se = :sesion")
    public List<Informacionejercicio> findBySesionentrenamiento(Sesionentrenamiento sesion);
}
