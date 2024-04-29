package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SesionentrenamientoRepository extends JpaRepository<Sesionentrenamiento, Integer> {
}
