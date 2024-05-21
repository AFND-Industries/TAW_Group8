package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Categoria;
import com.example.GymWebAppSpring.entity.Ejercicio;
import com.example.GymWebAppSpring.entity.Musculo;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EjercicioRepository extends JpaRepository<Ejercicio, Integer> {

    @Query("select e from Ejercicio e, Ejerciciosesion es, Sesionentrenamiento s where es.ejercicio = e and es.sesionentrenamiento = s and s = :sesion")
    List<Ejercicio> findEjercicioBySesion(@Param("sesion") Sesionentrenamiento sesion);

    @Query("SELECT e FROM Ejercicio e WHERE e.id IN :ids")
    List<Ejercicio> findEjercicioByIds(@Param("ids") List<Integer> lista);

    @Query("select e from Ejercicio e where e.categoria.id = 1") // Categoria 1 es Fuerza
    List<Ejercicio> findAllEjerciciosFuerza();

    @Query("SELECT e FROM Ejercicio e WHERE e.categoria = :categoria")
    List<Ejercicio> findAllByCategoria(Categoria categoria);

    @Query("SELECT e FROM Ejercicio e WHERE e.musculo = :musculo")
    List<Ejercicio> findAllByMusculo(Musculo musculo);

    @Query("SELECT e FROM Ejercicio e WHERE e.nombre like %:nombre%")
    List<Ejercicio> findAllByNombre(String nombre);
}
