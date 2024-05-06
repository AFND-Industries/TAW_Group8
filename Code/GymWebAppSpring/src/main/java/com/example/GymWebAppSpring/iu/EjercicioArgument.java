package com.example.GymWebAppSpring.iu;

import com.example.GymWebAppSpring.entity.Ejercicio;
import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class EjercicioArgument {
    private Integer id;
    private Integer ejercicio;
    private List<String> especificaciones;

    public EjercicioArgument() {
        this.id = -100;
        this.ejercicio = -1;
        this.especificaciones = new ArrayList<>();
    }

    public EjercicioArgument(Ejerciciosesion e) {
        this.id = e.getId();
        this.ejercicio = e.getEjercicio().getId();

        Gson gson = new Gson();
        this.especificaciones = Arrays.asList(gson.fromJson(e.getEspecificaciones(), String[].class));
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getEjercicio() {
        return ejercicio;
    }

    public void setEjercicio(Integer ejercicio) {
        this.ejercicio = ejercicio;
    }

    public List<String> getEspecificaciones() {
        return especificaciones;
    }

    public void setEspecificaciones(List<String> especificaciones) {
        this.especificaciones = especificaciones;
    }
}
