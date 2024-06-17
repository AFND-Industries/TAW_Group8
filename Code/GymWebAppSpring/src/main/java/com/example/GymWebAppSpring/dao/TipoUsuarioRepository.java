package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Tipousuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface TipoUsuarioRepository extends JpaRepository<Tipousuario, Integer>{
    @Query("SELECT t FROM Tipousuario t WHERE t.nombre like :name")
    Tipousuario findByName(String name);
}
