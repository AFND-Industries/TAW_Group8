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
        this(-100);
    }

    public RutinaArgument(Integer id) {
        this(id, "", "", -1, new ArrayList<>());
    }

    public RutinaArgument(RutinaDTO rutina, List<SesionArgument> sesiones) {
        this(rutina.getId(), rutina.getNombre(), rutina.getDescripcion(), rutina.getDificultad().getId(), sesiones);
    }

    public RutinaArgument(Integer id, String nombre, String descripcion, Integer dificultad, List<SesionArgument> sesiones) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.dificultad = dificultad;
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

    public void update(String nombre, Integer dificultad, String descripcion) {
        setNombre(nombre);
        setDificultad(dificultad);
        setDescripcion(descripcion);
    }
}
