package com.example.GymWebAppSpring.iu;

import com.example.GymWebAppSpring.entity.Ejercicio;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;

public class EjercicioSesionArgument {
    private Integer id;
    private Integer orden;
    private String especificaciones;
    private SesionArgument sesionentrenamiento;
    private Ejercicio ejercicio;

    public EjercicioSesionArgument(Integer id, Integer orden, String especificaciones, SesionArgument sesionentrenamiento, Ejercicio ejercicio) {
        this.id = id;
        this.orden = orden;
        this.especificaciones = especificaciones;
        this.sesionentrenamiento = sesionentrenamiento;
        this.ejercicio = ejercicio;
    }

    public EjercicioSesionArgument() {
        this.id = null;
        this.orden = null;
        this.especificaciones = "";
        this.sesionentrenamiento = null;
        this.ejercicio = ejercicio;
    }

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

    public SesionArgument getSesionentrenamiento() {
        return sesionentrenamiento;
    }

    public void setSesionentrenamiento(SesionArgument sesionentrenamiento) {
        this.sesionentrenamiento = sesionentrenamiento;
    }

    public Ejercicio getEjercicio() {
        return ejercicio;
    }

    public void setEjercicio(Ejercicio ejercicio) {
        this.ejercicio = ejercicio;
    }
}
