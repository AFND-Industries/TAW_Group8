package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Dificultad;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RutinaRepository extends JpaRepository<Rutina, Integer> {
    @Query("select r from Rutina r where r.entrenador = :entrenador")
    public List<Rutina> findRutinaByEntrenadorId(@Param("entrenador") Usuario entrenador);


    @Query("SELECT r FROM Rutina r WHERE r.entrenador = :entrenador " +
            "AND UPPER(r.nombre) LIKE CONCAT('%',UPPER(:nombre),'%') " +
            "AND (r.dificultad = :dificultad OR :dificultad IS NULL) " +
            "AND (SELECT COUNT(s) FROM Sesionentrenamiento s WHERE s.rutina = r) >= :limiteBajo " +
            "AND (SELECT COUNT(s) FROM Sesionentrenamiento s WHERE s.rutina = r) <= :limiteAlto")
    public List<Rutina> findRutinaByEntrenadorWithFilter(@Param("entrenador") Usuario entrenador,
                                                         @Param("nombre") String nombre,
                                                         @Param("limiteBajo") Integer limiteBajo,
                                                         @Param("limiteAlto") Integer limiteAlto,
                                                         @Param("dificultad") Dificultad dificultad);
}
