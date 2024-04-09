package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "ejerciciosesion", schema = "tawbd", catalog = "")
public class EjerciciosesionEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "ID")
    private int id;
    @Basic
    @Column(name = "ORDEN")
    private int orden;
    @Basic
    @Column(name = "ESPECIFICACIONES")
    private String especificaciones;
    @Basic
    @Column(name = "SESIONENTRENAMIENTO_ID")
    private int sesionentrenamientoId;
    @Basic
    @Column(name = "EJERCICIO_ID")
    private int ejercicioId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrden() {
        return orden;
    }

    public void setOrden(int orden) {
        this.orden = orden;
    }

    public String getEspecificaciones() {
        return especificaciones;
    }

    public void setEspecificaciones(String especificaciones) {
        this.especificaciones = especificaciones;
    }

    public int getSesionentrenamientoId() {
        return sesionentrenamientoId;
    }

    public void setSesionentrenamientoId(int sesionentrenamientoId) {
        this.sesionentrenamientoId = sesionentrenamientoId;
    }

    public int getEjercicioId() {
        return ejercicioId;
    }

    public void setEjercicioId(int ejercicioId) {
        this.ejercicioId = ejercicioId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        EjerciciosesionEntity that = (EjerciciosesionEntity) o;
        return id == that.id && orden == that.orden && sesionentrenamientoId == that.sesionentrenamientoId && ejercicioId == that.ejercicioId && Objects.equals(especificaciones, that.especificaciones);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, orden, especificaciones, sesionentrenamientoId, ejercicioId);
    }
}
