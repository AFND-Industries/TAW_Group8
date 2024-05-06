package com.example.GymWebAppSpring.iu;

import java.util.ArrayList;
import java.util.List;

public class EjercicioArgument {
    private String ejercicio;
    private List<String> especificaciones;

    public EjercicioArgument() {
        this.ejercicio = "";
        this.especificaciones = new ArrayList<>();
    }

    public String getEjercicio() {
        return ejercicio;
    }

    public void setEjercicio(String ejercicio) {
        this.ejercicio = ejercicio;
    }

    public List<String> getEspecificaciones() {
        return especificaciones;
    }

    public void setEspecificaciones(List<String> especificaciones) {
        this.especificaciones = especificaciones;
    }
}
