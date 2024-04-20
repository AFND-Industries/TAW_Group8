package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Tipousuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TipoUsuarioRepository extends JpaRepository<Tipousuario, Integer>{
}
