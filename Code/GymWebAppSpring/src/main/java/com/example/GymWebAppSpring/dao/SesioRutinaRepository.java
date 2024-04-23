package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Sesionrutina;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SesioRutinaRepository extends JpaRepository<Sesionrutina, Integer>{
    @Query("SELECT count(s) from Sesionrutina s where s.rutina.id= :id")
    public int findNumberSesionsByRutinaId(@Param("id") int id);
}
