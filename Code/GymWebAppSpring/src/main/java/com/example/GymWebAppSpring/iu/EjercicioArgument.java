package com.example.GymWebAppSpring.iu;

import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class EjercicioArgument {
    private Integer id;
    private Integer ejercicio;
    private JsonObject especificaciones;

    public EjercicioArgument() {
        this.id = -100;
        this.ejercicio = -1;
        this.especificaciones = new JsonObject();
    }

    public EjercicioArgument(Ejerciciosesion e) {
        this.id = e.getId();
        this.ejercicio = e.getEjercicio().getId();

        Gson gson = new Gson();
        this.especificaciones = gson.fromJson(e.getEspecificaciones(), JsonObject.class);
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

    public JsonObject getEspecificaciones() {
        return especificaciones;
    }

    public void setEspecificaciones(JsonObject especificaciones) {
        this.especificaciones = especificaciones;
    }
}
