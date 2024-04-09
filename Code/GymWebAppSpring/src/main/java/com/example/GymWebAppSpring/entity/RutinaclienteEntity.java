package com.example.GymWebAppSpring.entity;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "rutinacliente", schema = "tawbd", catalog = "")
public class RutinaclienteEntity {
    @Basic
    @Column(name = "USUARIO_ID")
    private int usuarioId;
    @Basic
    @Column(name = "RUTINA_ID")
    private int rutinaId;
    @Basic
    @Column(name = "FECHA_INICIO")
    private Date fechaInicio;

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

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RutinaclienteEntity that = (RutinaclienteEntity) o;
        return usuarioId == that.usuarioId && rutinaId == that.rutinaId && Objects.equals(fechaInicio, that.fechaInicio);
    }

    @Override
    public int hashCode() {
        return Objects.hash(usuarioId, rutinaId, fechaInicio);
    }
}
