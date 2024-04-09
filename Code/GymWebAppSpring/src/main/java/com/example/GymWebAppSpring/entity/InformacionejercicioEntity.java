package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "informacionejercicio", schema = "tawbd", catalog = "")
public class InformacionejercicioEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "ID")
    private int id;
    @Basic
    @Column(name = "EVALUACION")
    private String evaluacion;
    @Basic
    @Column(name = "EJERCICIOSESION_ID")
    private int ejerciciosesionId;
    @Basic
    @Column(name = "INFORMACIONSESION_ID")
    private int informacionsesionId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEvaluacion() {
        return evaluacion;
    }

    public void setEvaluacion(String evaluacion) {
        this.evaluacion = evaluacion;
    }

    public int getEjerciciosesionId() {
        return ejerciciosesionId;
    }

    public void setEjerciciosesionId(int ejerciciosesionId) {
        this.ejerciciosesionId = ejerciciosesionId;
    }

    public int getInformacionsesionId() {
        return informacionsesionId;
    }

    public void setInformacionsesionId(int informacionsesionId) {
        this.informacionsesionId = informacionsesionId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InformacionejercicioEntity that = (InformacionejercicioEntity) o;
        return id == that.id && ejerciciosesionId == that.ejerciciosesionId && informacionsesionId == that.informacionsesionId && Objects.equals(evaluacion, that.evaluacion);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, evaluacion, ejerciciosesionId, informacionsesionId);
    }
}
