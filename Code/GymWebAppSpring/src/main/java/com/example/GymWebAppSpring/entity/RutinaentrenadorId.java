package com.example.GymWebAppSpring.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.util.Objects;

@Embeddable
public class RutinaentrenadorId implements java.io.Serializable {
    private static final long serialVersionUID = -8622890611833361093L;
    @Column(name = "RUTINA_ID", nullable = false)
    private Integer rutinaId;

    @Column(name = "USUARIO_ID", nullable = false)
    private Integer usuarioId;

    public Integer getRutinaId() {
        return rutinaId;
    }

    public void setRutinaId(Integer rutinaId) {
        this.rutinaId = rutinaId;
    }

    public Integer getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Integer usuarioId) {
        this.usuarioId = usuarioId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        RutinaentrenadorId entity = (RutinaentrenadorId) o;
        return Objects.equals(this.rutinaId, entity.rutinaId) &&
                Objects.equals(this.usuarioId, entity.usuarioId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(rutinaId, usuarioId);
    }

}