package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Dificultad;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RutinaRepository extends JpaRepository<Rutina, Integer> {
    @Query("select r from Rutina r where r.entrenador.id = :entrenadorId")
    public List<Rutina> findRutinaByEntrenadorId(@Param("entrenadorId") Integer entrenadorId);


    @Query("SELECT r FROM Rutina r WHERE r.entrenador.id = :entrenadorId " +
            "AND UPPER(r.nombre) LIKE CONCAT('%',UPPER(:nombre),'%') " +
            "AND (r.dificultad.id = :dificultadId OR :dificultadId IS NULL) " +
            "AND (SELECT COUNT(s) FROM Sesionentrenamiento s WHERE s.rutina = r) >= :limiteBajo " +
            "AND (SELECT COUNT(s) FROM Sesionentrenamiento s WHERE s.rutina = r) <= :limiteAlto")
    public List<Rutina> findRutinaByEntrenadorWithFilter(@Param("entrenadorId") Integer entrenadorId,
                                                         @Param("nombre") String nombre,
                                                         @Param("limiteBajo") Integer limiteBajo,
                                                         @Param("limiteAlto") Integer limiteAlto,
                                                         @Param("dificultadId") Integer dificultadId);

    @Query("SELECT r from Rutina r, Rutinacliente rc where r=rc.rutina and rc.usuario.id= :id")
    public List<Rutina> findRutinaByUsuarioID(@Param("id") int id);
}
