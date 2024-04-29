package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Informacionsesion;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface InformacionSesionRepository extends JpaRepository<Informacionsesion, Integer> {

    @Query("SELECT i FROM Informacionsesion i WHERE i.usuario = :usuario AND i.sesionentrenamiento = :sesion")
    public Informacionsesion findByUsuarioAndSesion(@Param("usuario") Usuario usuario, @Param("sesion") Sesionentrenamiento sesion);
}
