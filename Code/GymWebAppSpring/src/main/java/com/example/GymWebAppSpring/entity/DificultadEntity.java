package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "dificultad", schema = "tawbd", catalog = "")
public class DificultadEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "ID")
    private int id;
    @Basic
    @Column(name = "NOMBRE")
    private String nombre;
    @Basic
    @Column(name = "LOGO")
    private String logo;

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

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DificultadEntity that = (DificultadEntity) o;
        return id == that.id && Objects.equals(nombre, that.nombre) && Objects.equals(logo, that.logo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nombre, logo);
    }
}
