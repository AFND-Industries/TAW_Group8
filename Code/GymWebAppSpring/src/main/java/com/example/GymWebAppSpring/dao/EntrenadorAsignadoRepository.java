package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Entrenadorasignado;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EntrenadorAsignadoRepository extends JpaRepository<Entrenadorasignado, Integer> {
    @Query("SELECT u FROM Usuario u, Entrenadorasignado e WHERE e.entrenador.id = :id AND e.cliente.id = u.id")
    public List<Usuario> findClientsByEntrenadorID(@Param("id") int id);
}
