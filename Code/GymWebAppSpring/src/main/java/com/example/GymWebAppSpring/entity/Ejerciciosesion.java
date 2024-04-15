package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "ejerciciosesion")
public class Ejerciciosesion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "ORDEN", nullable = false)
    private Integer orden;

    @Column(name = "ESPECIFICACIONES", nullable = false, length = 256)
    private String especificaciones;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "SESIONENTRENAMIENTO_ID", nullable = false)
    private Sesionentrenamiento sesionentrenamiento;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "EJERCICIO_ID", nullable = false)
    private Ejercicio ejercicio;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrden() {
        return orden;
    }

    public void setOrden(Integer orden) {
        this.orden = orden;
    }

    public String getEspecificaciones() {
        return especificaciones;
    }

    public void setEspecificaciones(String especificaciones) {
        this.especificaciones = especificaciones;
    }

    public Sesionentrenamiento getSesionentrenamiento() {
        return sesionentrenamiento;
    }

    public void setSesionentrenamiento(Sesionentrenamiento sesionentrenamiento) {
        this.sesionentrenamiento = sesionentrenamiento;
    }

    public Ejercicio getEjercicio() {
        return ejercicio;
    }

    public void setEjercicio(Ejercicio ejercicio) {
        this.ejercicio = ejercicio;
    }

}