package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RutinaUsuarioRepository extends JpaRepository<Rutina, String> {

    @Query("SELECT r from Rutina r, Rutinacliente rc where r=rc.rutina and rc.usuario= :user")
    public List<Rutina> findRutinaByUsuario(@Param("user") Usuario user);


}
