package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Entrenadorasignado;
import com.example.GymWebAppSpring.entity.EntrenadorasignadoId;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EntrenadorAsignadoRepository extends JpaRepository<Entrenadorasignado, EntrenadorasignadoId> {
    @Query("SELECT e.cliente FROM Entrenadorasignado e WHERE e.entrenador.id = :id")
    List<Usuario> findClientsByEntrenadorID(Integer id);

    @Query("SELECT e.entrenador FROM Entrenadorasignado e WHERE e.cliente.id = :id")
    List<Usuario> findEntrenadoresByClientID(Integer id);

    @Query("SELECT e FROM Entrenadorasignado e WHERE e.cliente.id = :cliente")
    List<Entrenadorasignado> findByCliente(Integer id);
}
