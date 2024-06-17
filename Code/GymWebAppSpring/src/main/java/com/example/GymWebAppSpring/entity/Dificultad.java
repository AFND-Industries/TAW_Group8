package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.DificultadDTO;
import jakarta.persistence.*;

@Entity
@Table(name = "dificultad")
public class Dificultad implements DTO<DificultadDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "NOMBRE", nullable = false, length = 32)
    private String nombre;

    @Column(name = "LOGO", nullable = false, length = 256)
    private String logo;

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

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    @Override
    public DificultadDTO toDTO() {
        DificultadDTO dificultadDTO = new DificultadDTO();
        dificultadDTO.setId(this.id);
        dificultadDTO.setNombre(this.nombre);
        dificultadDTO.setLogo(this.logo);
        return dificultadDTO;
    }
}