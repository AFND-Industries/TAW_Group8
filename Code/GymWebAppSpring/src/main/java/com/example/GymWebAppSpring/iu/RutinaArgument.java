package com.example.GymWebAppSpring.iu;

import com.example.GymWebAppSpring.entity.Rutina;

public class RutinaArgument {
    private Integer id;
    private String nombre;
    private String descripcion;
    private Integer dificultad;

    public RutinaArgument() {
        this.id = -100;
        this.nombre = "";
        this.descripcion = "";
        this.dificultad = -1;
    }

    public RutinaArgument(Rutina rutina) {
        this.id = rutina.getId();
        this.nombre = rutina.getNombre();
        this.descripcion = rutina.getDescripcion();
        this.dificultad = rutina.getDificultad().getId();
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

    public Integer getDificultad() {
        return dificultad;
    }

    public void setDificultad(Integer dificultad) {
        this.dificultad = dificultad;
    }

    public boolean isNull() {
        return this.nombre.isEmpty();
    }
}
