package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import com.example.GymWebAppSpring.entity.Sesionrutina;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SesionRutinaRepository extends JpaRepository<Sesionrutina, Integer>{
    @Query("SELECT s.sesionentrenamiento from Sesionrutina s where s.rutina = :rutina")
    public List<Sesionentrenamiento> findSesionsByRutina(@Param("rutina") Rutina rutina);

    @Query("SELECT s from Sesionrutina s where s.rutina = :rutina")
    public List<Sesionrutina> findSesionRutinaByRutina(@Param("rutina") Rutina rutina);
}
