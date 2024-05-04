package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SesionEntrenamientoRepository extends JpaRepository<Sesionentrenamiento, Integer> {
    @Query("SELECT s FROM Sesionentrenamiento s WHERE s.rutina = :rutina")
    public List<Sesionentrenamiento> findSesionentrenamientoByRutina(@Param("rutina") Rutina rutina);
}