package com.example.GymWebAppSpring.iu;

import com.example.GymWebAppSpring.entity.Sesionentrenamiento;

import java.util.List;

public class SesionArgument {
    private int id;
    private String nombre;
    private String descripcion;
    private List<EjercicioArgument> ejercicios;

    public SesionArgument() {
        this.id = -100;
        this.nombre = "";
        this.descripcion = "";
    }

    public SesionArgument(Sesionentrenamiento s) {
        this.id = s.getId();
        this.nombre = s.getNombre();
        this.descripcion = s.getDescripcion();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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
}
