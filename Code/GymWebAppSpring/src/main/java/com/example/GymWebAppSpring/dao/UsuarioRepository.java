package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    @Query("SELECT u FROM Usuario u WHERE u.dni like :dni and u.clave like :clave")
    public Usuario findUsuarioByDniAndClave(@Param("dni") String dni, @Param("clave") String clave);
}
