package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.TipousuarioDTO;
import jakarta.persistence.*;

@Entity
@Table(name = "tipousuario")
public class Tipousuario implements DTO<TipousuarioDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "NOMBRE", nullable = false, length = 32)
    private String nombre;

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

    @Override
    public TipousuarioDTO toDTO() {
        TipousuarioDTO tipousuarioDTO = new TipousuarioDTO();
        tipousuarioDTO.setId(id);
        tipousuarioDTO.setNombre(nombre);
        return tipousuarioDTO;
    }
}