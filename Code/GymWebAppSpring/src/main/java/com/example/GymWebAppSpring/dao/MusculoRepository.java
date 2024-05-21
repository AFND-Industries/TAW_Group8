package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Musculo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MusculoRepository extends JpaRepository<Musculo, Integer> {
}
