package com.example.GymWebAppSpring.iu;

public class RutinaArgument {
    private Integer id;
    private String nombre;
    private Integer dificultad;

    public RutinaArgument() {
        this.id = null;
        this.nombre = null;
        this.dificultad = null;
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

    public Integer getDificultad() {
        return dificultad;
    }

    public void setDificultad(Integer dificultad) {
        this.dificultad = dificultad;
    }
}
