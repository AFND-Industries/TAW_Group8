package com.example.GymWebAppSpring.iu;

public class FiltroClientesEntrenadorArgument {
    private String nombre;
    private String apellidos;
    private char genero;
    private Integer edad;

    private Integer edadMode;

    public FiltroClientesEntrenadorArgument() {
        this.nombre = "";
        this.apellidos = "";
        this.genero = ' ';
        this.edad = -1;
        this.edadMode = -1;
    }

    public Integer getEdadMode() {
        return edadMode;
    }

    public void setEdadMode(Integer edadMode) {
        this.edadMode = edadMode;
    }

    public Integer getEdad() {
        return edad;
    }

    public void setEdad(Integer edad) {
        this.edad = edad;
    }

    public char getGenero() {
        return genero;
    }

    public void setGenero(char genero) {
        this.genero = genero;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public boolean estaVacio() {
        return nombre.isEmpty() && apellidos.isEmpty() && genero == ' ' && edad == -1 && edadMode == -1;
    }
}
