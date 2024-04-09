package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<UsuarioEntity, Integer> {
}
