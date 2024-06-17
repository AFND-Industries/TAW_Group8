package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.TipofuerzaDTO;
import jakarta.persistence.*;

@Entity
@Table(name = "tipofuerza")
public class Tipofuerza implements DTO<TipofuerzaDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "NOMBRE", nullable = false, length = 32)
    private String nombre;

    @Column(name = "DESCRIPCION", nullable = false, length = 256)
    private String descripcion;

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

    @Override
    public TipofuerzaDTO toDTO() {
        TipofuerzaDTO tipofuerzaDTO = new TipofuerzaDTO();
        tipofuerzaDTO.setId(id);
        tipofuerzaDTO.setNombre(nombre);
        tipofuerzaDTO.setDescripcion(descripcion);
        return tipofuerzaDTO;
    }
}