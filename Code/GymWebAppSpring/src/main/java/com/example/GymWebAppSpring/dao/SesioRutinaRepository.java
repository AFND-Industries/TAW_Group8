package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import com.example.GymWebAppSpring.entity.Sesionrutina;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SesioRutinaRepository extends JpaRepository<Sesionrutina, Integer>{
    @Query("SELECT s.sesionentrenamiento from Sesionrutina s where s.rutina.id= :id")
    public List<Sesionentrenamiento> findSesionsByRutinaId(@Param("id") int id);
}
