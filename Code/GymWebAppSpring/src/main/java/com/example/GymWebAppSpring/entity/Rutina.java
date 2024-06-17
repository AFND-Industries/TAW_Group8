package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.RutinaDTO;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "rutina")
public class Rutina  implements DTO<RutinaDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "NOMBRE", nullable = false, length = 32)
    private String nombre;

    @Column(name = "DESCRIPCION", nullable = false, length = 256)
    private String descripcion;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "DIFICULTAD", nullable = false)
    private Dificultad dificultad;

    @Column(name = "FECHA_CREACION", nullable = false)
    private LocalDate fechaCreacion;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "ENTRENADOR", nullable = false)
    private Usuario entrenador;

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

    public Dificultad getDificultad() {
        return dificultad;
    }

    public void setDificultad(Dificultad dificultad) {
        this.dificultad = dificultad;
    }

    public LocalDate getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(LocalDate fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public Usuario getEntrenador() {
        return entrenador;
    }

    public void setEntrenador(Usuario entrenador) {
        this.entrenador = entrenador;
    }

    @Override
    public RutinaDTO toDTO() {
        RutinaDTO rutinaDTO = new RutinaDTO();
        rutinaDTO.setId(id);
        rutinaDTO.setNombre(nombre);
        rutinaDTO.setDescripcion(descripcion);
        rutinaDTO.setDificultad(dificultad.toDTO());
        rutinaDTO.setFechaCreacion(fechaCreacion);
        rutinaDTO.setEntrenador(entrenador.toDTO());
        return rutinaDTO;
    }
}