package com.example.GymWebAppSpring.iu;

import com.example.GymWebAppSpring.dto.RutinaDTO;

import java.util.ArrayList;
import java.util.List;

public class RutinaArgument {
    private Integer id;
    private String nombre;
    private String descripcion;
    private Integer dificultad;
    private List<SesionArgument> sesiones;

    public RutinaArgument() {
        this.id = -100;
        this.nombre = "";
        this.descripcion = "";
        this.dificultad = -1;
        this.sesiones = new ArrayList<>();
    }

    public RutinaArgument(RutinaDTO rutina, List<SesionArgument> sesiones) {
        this.id = rutina.getId();
        this.nombre = rutina.getNombre();
        this.descripcion = rutina.getDescripcion();
        this.dificultad = rutina.getDificultad().getId();
        this.sesiones = sesiones;
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

    public List<SesionArgument> getSesiones() {
        return sesiones;
    }

    public void setSesiones(List<SesionArgument> sesiones) {
        this.sesiones = sesiones;
    }

}
