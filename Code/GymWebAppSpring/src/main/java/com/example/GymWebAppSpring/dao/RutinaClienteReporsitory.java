package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Rutinacliente;
import com.example.GymWebAppSpring.entity.RutinaclienteId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RutinaClienteReporsitory extends JpaRepository<Rutinacliente, RutinaclienteId> {
}
