package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "informacionsesion", schema = "tawbd", catalog = "")
public class InformacionsesionEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "ID")
    private int id;
    @Basic
    @Column(name = "VALORACION")
    private Integer valoracion;
    @Basic
    @Column(name = "COMENTARIO")
    private String comentario;
    @Basic
    @Column(name = "FECHA_FIN")
    private Date fechaFin;
    @Basic
    @Column(name = "SESIONENTRENAMIENTO_ID")
    private int sesionentrenamientoId;
    @Basic
    @Column(name = "USUARIO_ID")
    private int usuarioId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getValoracion() {
        return valoracion;
    }

    public void setValoracion(Integer valoracion) {
        this.valoracion = valoracion;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public int getSesionentrenamientoId() {
        return sesionentrenamientoId;
    }

    public void setSesionentrenamientoId(int sesionentrenamientoId) {
        this.sesionentrenamientoId = sesionentrenamientoId;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InformacionsesionEntity that = (InformacionsesionEntity) o;
        return id == that.id && sesionentrenamientoId == that.sesionentrenamientoId && usuarioId == that.usuarioId && Objects.equals(valoracion, that.valoracion) && Objects.equals(comentario, that.comentario) && Objects.equals(fechaFin, that.fechaFin);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, valoracion, comentario, fechaFin, sesionentrenamientoId, usuarioId);
    }
}
