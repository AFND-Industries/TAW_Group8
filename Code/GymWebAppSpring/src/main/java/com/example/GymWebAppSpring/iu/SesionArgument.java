package com.example.GymWebAppSpring.iu;

import com.example.GymWebAppSpring.dto.EjerciciosesionDTO;
import com.example.GymWebAppSpring.dto.SesionentrenamientoDTO;

import java.util.ArrayList;
import java.util.List;

public class SesionArgument {
    private Integer id;
    private String nombre;
    private String dia;
    private String descripcion;
    private List<EjercicioArgument> ejercicios;

    public SesionArgument() {
        this.id = -100;
        this.nombre = "";
        this.dia = "";
        this.descripcion = "";
        this.ejercicios = new ArrayList<>();
    }

    public SesionArgument(SesionentrenamientoDTO s, List<EjerciciosesionDTO> ee) {
        this.id = s.getId();
        this.nombre = s.getNombre();
        this.dia = s.getDia().toString();
        this.descripcion = s.getDescripcion();
        this.ejercicios = new ArrayList<>();
        for (EjerciciosesionDTO e : ee)
            ejercicios.add(new EjercicioArgument(e));
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

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public List<EjercicioArgument> getEjercicios() {
        return ejercicios;
    }

    public void setEjercicios(List<EjercicioArgument> ejercicios) {
        this.ejercicios = ejercicios;
    }
}
