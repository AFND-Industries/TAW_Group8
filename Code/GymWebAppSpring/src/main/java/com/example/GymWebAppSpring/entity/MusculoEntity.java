package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "musculo", schema = "tawbd", catalog = "")
public class MusculoEntity {
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
    @Column(name = "IMAGEN")
    private String imagen;

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

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MusculoEntity that = (MusculoEntity) o;
        return id == that.id && Objects.equals(nombre, that.nombre) && Objects.equals(descripcion, that.descripcion) && Objects.equals(imagen, that.imagen);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nombre, descripcion, imagen);
    }
}
