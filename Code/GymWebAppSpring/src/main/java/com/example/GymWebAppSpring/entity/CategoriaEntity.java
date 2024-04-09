package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "categoria", schema = "tawbd", catalog = "")
public class CategoriaEntity {
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
    @Column(name = "TIPOS_BASE")
    private String tiposBase;
    @Basic
    @Column(name = "ICONO")
    private String icono;

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

    public String getTiposBase() {
        return tiposBase;
    }

    public void setTiposBase(String tiposBase) {
        this.tiposBase = tiposBase;
    }

    public String getIcono() {
        return icono;
    }

    public void setIcono(String icono) {
        this.icono = icono;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CategoriaEntity that = (CategoriaEntity) o;
        return id == that.id && Objects.equals(nombre, that.nombre) && Objects.equals(descripcion, that.descripcion) && Objects.equals(tiposBase, that.tiposBase) && Objects.equals(icono, that.icono);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nombre, descripcion, tiposBase, icono);
    }
}
