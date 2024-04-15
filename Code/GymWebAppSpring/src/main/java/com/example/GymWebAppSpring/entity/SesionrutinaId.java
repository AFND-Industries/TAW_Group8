package com.example.GymWebAppSpring.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.util.Objects;

@Embeddable
public class SesionrutinaId implements java.io.Serializable {
    private static final long serialVersionUID = 2036711581122145355L;
    @Column(name = "RUTINA_ID", nullable = false)
    private Integer rutinaId;

    @Column(name = "SESIONENTRENAMIENTO_ID", nullable = false)
    private Integer sesionentrenamientoId;

    public Integer getRutinaId() {
        return rutinaId;
    }

    public void setRutinaId(Integer rutinaId) {
        this.rutinaId = rutinaId;
    }

    public Integer getSesionentrenamientoId() {
        return sesionentrenamientoId;
    }

    public void setSesionentrenamientoId(Integer sesionentrenamientoId) {
        this.sesionentrenamientoId = sesionentrenamientoId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        SesionrutinaId entity = (SesionrutinaId) o;
        return Objects.equals(this.rutinaId, entity.rutinaId) &&
                Objects.equals(this.sesionentrenamientoId, entity.sesionentrenamientoId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(rutinaId, sesionentrenamientoId);
    }

}