package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.entity.Entrenadorasignado;
import com.example.GymWebAppSpring.entity.EntrenadorasignadoId;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EntrenadorAsignadoRepository extends JpaRepository<Entrenadorasignado, EntrenadorasignadoId> {
    @Query("SELECT e.cliente FROM Entrenadorasignado e WHERE e.entrenador.id = :id")
    List<Usuario> findClientsByEntrenadorID(Integer id);

    @Query("SELECT e.entrenador FROM Entrenadorasignado e WHERE e.cliente.id = :id")
    List<Usuario> findEntrenadoresByClientID(Integer id);

    @Query("SELECT e FROM Entrenadorasignado e WHERE e.cliente.id = :id")
    List<Entrenadorasignado> findByCliente(Integer id);

    @Query("SELECT e.cliente FROM Entrenadorasignado e WHERE e.entrenador.id = :entrenadorId " +
            "AND (:nombre IS NULL OR UPPER(e.cliente.nombre) LIKE CONCAT('%', UPPER(:nombre), '%')) " +
            "AND (:apellido IS NULL OR UPPER(e.cliente.apellidos) LIKE CONCAT('%', UPPER(:apellido), '%')) " +
            "AND (:genero IS NULL OR UPPER(e.cliente.genero) LIKE UPPER(:genero) ) " +
            "AND e.cliente.edad >= :limiteBajo " +
            "AND e.cliente.edad <= :limiteAlto")
    List<Usuario> findClientesByEntrenadorWithFilter(@Param("entrenadorId") Integer entrenadorId,
                                                     @Param("nombre") String nombre,
                                                     @Param("genero") Character genero,
                                                     @Param("limiteBajo") Integer limiteBajo,
                                                     @Param("limiteAlto") Integer limiteAlto,
                                                     @Param("apellido") String apellido);
}
