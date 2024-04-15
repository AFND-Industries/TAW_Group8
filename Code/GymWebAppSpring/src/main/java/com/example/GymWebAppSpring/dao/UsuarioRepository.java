package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
}
