package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Entrenadorasignado;
import com.example.GymWebAppSpring.entity.EntrenadorasignadoId;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EntrenadorAsignadoRepository extends JpaRepository<Entrenadorasignado, EntrenadorasignadoId> {
    @Query("SELECT e.cliente FROM Entrenadorasignado e WHERE e.entrenador = :entrenador")
    public List<Usuario> findClientsByEntrenadorID(Usuario entrenador);

    @Query("SELECT e.entrenador FROM Entrenadorasignado e WHERE e.cliente = :cliente")
    public List<Usuario> findEntrenadoresByClientID(Usuario cliente);

    @Query("SELECT e FROM Entrenadorasignado e WHERE e.cliente = :cliente")
    public List<Entrenadorasignado> findByCliente(Usuario cliente);
}
