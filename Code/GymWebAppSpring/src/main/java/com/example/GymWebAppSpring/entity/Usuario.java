package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import jakarta.persistence.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "usuario")
public class Usuario implements DTO<UsuarioDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "NOMBRE", nullable = false, length = 32)
    private String nombre;

    @Column(name = "APELLIDOS", nullable = false, length = 32)
    private String apellidos;

    @Column(name = "GENERO", nullable = false)
    private Character genero;

    @Column(name = "EDAD", nullable = false)
    private Integer edad;

    @Column(name = "DNI", nullable = false, length = 32)
    private String dni;

    @Column(name = "CLAVE", nullable = false, length = 64)
    private String clave;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "TIPO", nullable = false)
    @Fetch(FetchMode.JOIN)
    private Tipousuario tipo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public Character getGenero() {
        return genero;
    }

    public void setGenero(Character genero) {
        this.genero = genero;
    }

    public Integer getEdad() {
        return edad;
    }

    public void setEdad(Integer edad) {
        this.edad = edad;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public Tipousuario getTipo() {
        return tipo;
    }

    public void setTipo(Tipousuario tipo) {
        this.tipo = tipo;
    }

    @Override
    public UsuarioDTO toDTO() {
        UsuarioDTO usuarioDTO = new UsuarioDTO();
        usuarioDTO.setId(id);
        usuarioDTO.setNombre(nombre);
        usuarioDTO.setApellidos(apellidos);
        usuarioDTO.setGenero(genero);
        usuarioDTO.setEdad(edad);
        usuarioDTO.setDni(dni);
        usuarioDTO.setClave(clave);
        usuarioDTO.setTipo(tipo.toDTO());
        return usuarioDTO;
    }
}