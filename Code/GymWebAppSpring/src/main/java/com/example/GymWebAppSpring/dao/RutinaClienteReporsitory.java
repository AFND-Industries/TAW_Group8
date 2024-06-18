package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Rutinacliente;
import com.example.GymWebAppSpring.entity.RutinaclienteId;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface RutinaClienteReporsitory extends JpaRepository<Rutinacliente, RutinaclienteId> {

    @Query("SELECT r.fechaInicio FROM Rutinacliente r WHERE r.rutina.id= :rutina AND r.usuario.id= :usuario")
    public LocalDate findFechaInicioByRutinaAndUsuario(@Param("rutina") Integer rutina, @Param("usuario") Integer usuario);

    @Query("SELECT r FROM Rutinacliente r WHERE r.usuario.id= :usuario")
    public List<Rutinacliente> findByUsuario(@Param("usuario") Integer usuario);


}
