package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.MusculoDTO;
import com.example.GymWebAppSpring.dto.DTO;
import jakarta.persistence.*;

@Entity
@Table(name = "musculo")
public class Musculo implements DTO<MusculoDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "NOMBRE", nullable = false, length = 32)
    private String nombre;

    @Column(name = "DESCRIPCION", nullable = false, length = 256)
    private String descripcion;

    @Column(name = "IMAGEN", nullable = false, length = 256)
    private String imagen;

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

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    @Override
    public MusculoDTO toDTO() {
        MusculoDTO musculoDTO = new MusculoDTO();
        musculoDTO.setId(id);
        musculoDTO.setNombre(nombre);
        musculoDTO.setDescripcion(descripcion);
        musculoDTO.setImagen(imagen);
        return musculoDTO;
    }
}