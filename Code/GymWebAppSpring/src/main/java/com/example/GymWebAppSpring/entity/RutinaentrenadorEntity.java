package com.example.GymWebAppSpring.entity;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.util.Objects;

@Entity
@Table(name = "rutinaentrenador", schema = "tawbd", catalog = "")
public class RutinaentrenadorEntity {
    @Basic
    @Column(name = "USUARIO_ID")
    private int usuarioId;
    @Basic
    @Column(name = "RUTINA_ID")
    private int rutinaId;

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public int getRutinaId() {
        return rutinaId;
    }

    public void setRutinaId(int rutinaId) {
        this.rutinaId = rutinaId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RutinaentrenadorEntity that = (RutinaentrenadorEntity) o;
        return usuarioId == that.usuarioId && rutinaId == that.rutinaId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(usuarioId, rutinaId);
    }
}
