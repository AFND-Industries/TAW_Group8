package com.example.GymWebAppSpring.dao;

import com.example.GymWebAppSpring.entity.Tipousuario;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    @Query("SELECT u FROM Usuario u WHERE u.dni like :dni and u.clave like :clave")
    public Usuario findUsuarioByDniAndClave(@Param("dni") String dni, @Param("clave") String clave);

    @Query("SELECT u FROM Usuario u WHERE u.tipo.id = :id")
    public List<Usuario> findUsuarioByTipoUsuario(Integer id);

    @Query("SELECT u FROM Usuario u WHERE u.dni = :dni")
    public List<Usuario> findUsuarioByDNI(String dni);

    @Query("SELECT u FROM Usuario u WHERE u.apellidos like %:apellidos%")
    public List<Usuario> findUsuarioByApellidos(String apellidos);

    @Query("SELECT u FROM Usuario u WHERE u.edad >= :edad")
    public List<Usuario> findUsuarioByEdad(int edad);
}
