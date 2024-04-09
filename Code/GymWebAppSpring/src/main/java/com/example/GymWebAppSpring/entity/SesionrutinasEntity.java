package com.example.GymWebAppSpring.entity;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.util.Objects;

@Entity
@Table(name = "sesionrutinas", schema = "tawbd", catalog = "")
public class SesionrutinasEntity {
    @Basic
    @Column(name = "SESIONENTRENAMIENTO_ID")
    private int sesionentrenamientoId;
    @Basic
    @Column(name = "RUTINA_ID")
    private int rutinaId;
    @Basic
    @Column(name = "DIA")
    private int dia;

    public int getSesionentrenamientoId() {
        return sesionentrenamientoId;
    }

    public void setSesionentrenamientoId(int sesionentrenamientoId) {
        this.sesionentrenamientoId = sesionentrenamientoId;
    }

    public int getRutinaId() {
        return rutinaId;
    }

    public void setRutinaId(int rutinaId) {
        this.rutinaId = rutinaId;
    }

    public int getDia() {
        return dia;
    }

    public void setDia(int dia) {
        this.dia = dia;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SesionrutinasEntity that = (SesionrutinasEntity) o;
        return sesionentrenamientoId == that.sesionentrenamientoId && rutinaId == that.rutinaId && dia == that.dia;
    }

    @Override
    public int hashCode() {
        return Objects.hash(sesionentrenamientoId, rutinaId, dia);
    }
}
