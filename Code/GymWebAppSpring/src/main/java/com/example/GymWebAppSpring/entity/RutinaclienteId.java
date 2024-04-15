package com.example.GymWebAppSpring.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.util.Objects;

@Embeddable
public class RutinaclienteId implements java.io.Serializable {
    private static final long serialVersionUID = 743632115256409635L;
    @Column(name = "USUARIO_ID", nullable = false)
    private Integer usuarioId;

    @Column(name = "RUTINA_ID", nullable = false)
    private Integer rutinaId;

    public Integer getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Integer usuarioId) {
        this.usuarioId = usuarioId;
    }

    public Integer getRutinaId() {
        return rutinaId;
    }

    public void setRutinaId(Integer rutinaId) {
        this.rutinaId = rutinaId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        RutinaclienteId entity = (RutinaclienteId) o;
        return Objects.equals(this.rutinaId, entity.rutinaId) &&
                Objects.equals(this.usuarioId, entity.usuarioId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(rutinaId, usuarioId);
    }

}