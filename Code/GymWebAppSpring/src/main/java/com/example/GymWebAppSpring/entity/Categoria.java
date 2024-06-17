package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.CategoriaDTO;
import jakarta.persistence.*;

@Entity
@Table(name = "categoria")
public class Categoria implements DTO<CategoriaDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "NOMBRE", nullable = false, length = 32)
    private String nombre;

    @Column(name = "DESCRIPCION", nullable = false, length = 256)
    private String descripcion;

    @Column(name = "TIPOS_BASE", nullable = false, length = 64)
    private String tiposBase;

    @Column(name = "ICONO", nullable = false, length = 256)
    private String icono;

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

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getTiposBase() {
        return tiposBase;
    }

    public void setTiposBase(String tiposBase) {
        this.tiposBase = tiposBase;
    }

    public String getIcono() {
        return icono;
    }

    public void setIcono(String icono) {
        this.icono = icono;
    }

    @Override
    public CategoriaDTO toDTO() {
        CategoriaDTO categoriaDTO = new CategoriaDTO();
        categoriaDTO.setId(this.id);
        categoriaDTO.setNombre(this.nombre);
        categoriaDTO.setDescripcion(this.descripcion);
        categoriaDTO.setTiposBase(this.tiposBase);
        categoriaDTO.setIcono(this.icono);
        return categoriaDTO;
    }
}