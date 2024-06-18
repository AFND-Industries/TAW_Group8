package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Ejercicio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EjercicioRepository extends JpaRepository<Ejercicio, Integer> {

    @Query("select e from Ejercicio e, Ejerciciosesion es, Sesionentrenamiento s where es.ejercicio = e and es.sesionentrenamiento = s and s.id = :sesionId")
    List<Ejercicio> findEjercicioBySesion(@Param("sesionId") Integer sesionId);

    @Query("select e from Ejercicio e where e.categoria.id = 1")
    List<Ejercicio> findAllEjerciciosFuerza();

    @Query("SELECT e FROM Ejercicio e WHERE e.categoria.id = :categoriaId")
    List<Ejercicio> findAllByCategoria(Integer categoriaId);

    @Query("SELECT e FROM Ejercicio e WHERE e.musculo.id = :musculoId")
    List<Ejercicio> findAllByMusculo(Integer musculoId);

    @Query("SELECT e FROM Ejercicio e WHERE e.nombre like %:nombre%")
    List<Ejercicio> findAllByNombre(String nombre);
}
