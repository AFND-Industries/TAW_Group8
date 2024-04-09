package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "rutina", schema = "tawbd", catalog = "")
public class RutinaEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "ID")
    private int id;
    @Basic
    @Column(name = "NOMBRE")
    private String nombre;
    @Basic
    @Column(name = "DESCRIPCION")
    private String descripcion;
    @Basic
    @Column(name = "DIFICULTAD")
    private int dificultad;
    @Basic
    @Column(name = "FECHA_CREACION")
    private Date fechaCreacion;

    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public int getDificultad() {
        return dificultad;
    }

    public void setDificultad(int dificultad) {
        this.dificultad = dificultad;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RutinaEntity that = (RutinaEntity) o;
        return id == that.id && dificultad == that.dificultad && Objects.equals(nombre, that.nombre) && Objects.equals(descripcion, that.descripcion) && Objects.equals(fechaCreacion, that.fechaCreacion);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nombre, descripcion, dificultad, fechaCreacion);
    }
}
