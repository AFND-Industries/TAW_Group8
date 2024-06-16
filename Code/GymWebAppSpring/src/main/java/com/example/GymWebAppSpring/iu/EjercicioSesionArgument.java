package com.example.GymWebAppSpring.iu;

import com.example.GymWebAppSpring.entity.Ejercicio;
import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;

import java.util.HashMap;

public class EjercicioSesionArgument {

    private Integer id;
    private HashMap<String,String> especificaciones;
    private HashMap<String,String> resultados;
    private Sesionentrenamiento sesionEntrenamiento;
    private Ejercicio ejercicio;

    public EjercicioSesionArgument() {
        this.id = -100;
        this.especificaciones = new HashMap<>();
        this.resultados = new HashMap<>();
        this.sesionEntrenamiento = new Sesionentrenamiento();
        this.ejercicio = null;
    }



    public Sesionentrenamiento getSesionEntrenamiento() {
        return sesionEntrenamiento;
    }

    public void setSesionEntrenamiento(Sesionentrenamiento sesionEntrenamiento) {
        this.sesionEntrenamiento = sesionEntrenamiento;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    public Ejercicio getEjercicio() {
        return ejercicio;
    }

    public void setEjercicio(Ejercicio ejercicio) {
        this.ejercicio = ejercicio;
    }

    public HashMap<String, String> getEspecificaciones() {
        return especificaciones;
    }

    public void setEspecificaciones(HashMap<String, String> especificaciones) {
        this.especificaciones = especificaciones;
    }

    public HashMap<String, String> getResultados() {
        return resultados;
    }

    public void setResultados(HashMap<String, String> resultados) {
        this.resultados = resultados;
    }
}
