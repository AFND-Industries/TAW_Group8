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

    @Query("SELECT r.fechaInicio FROM Rutinacliente r WHERE r.rutina= :rutina AND r.usuario= :usuario")
    public LocalDate findFechaInicioByRutinaAndUsuario(@Param("rutina") Rutina rutina, @Param("usuario") Usuario usuario);

    @Query("SELECT r FROM Rutinacliente r WHERE r.usuario= :usuario")
    public List<Rutinacliente> findByUsuario(@Param("usuario") Usuario usuario);

}
