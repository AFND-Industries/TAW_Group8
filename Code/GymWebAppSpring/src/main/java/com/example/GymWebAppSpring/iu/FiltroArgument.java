package com.example.GymWebAppSpring.iu;

public class FiltroArgument {
    private String nombre;
    private Integer sesionMode;
    private String sesionNum;
    private Integer dificultad;

    public FiltroArgument() {
        this("", -1, "", -1);
    }

    public FiltroArgument(String nombre, Integer sesionMode, String sesionNum, Integer dificultad) {
        setNombre(nombre);
        setSesionMode(sesionMode);
        setSesionNum(sesionNum);
        setDificultad(dificultad);
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getSesionMode() {
        return sesionMode;
    }

    public void setSesionMode(Integer sesionMode) {
        this.sesionMode = sesionMode;
    }

    public String getSesionNum() {
        return sesionNum;
    }

    public void setSesionNum(String sesionNum) {
        this.sesionNum = sesionNum;
    }

    public Integer getDificultad() {
        return dificultad;
    }

    public void setDificultad(Integer dificultad) {
        this.dificultad = dificultad;
    }

    public Integer getIntegerSesionNum() {
        return this.sesionNum.isEmpty() ? -1 : Integer.parseInt(sesionNum);
    }

    public void processFiltro() {
        // Si se ignora uno de los dos campos, el otro también, pues van de la mano
        if (getIntegerSesionNum() == -1 || getSesionMode() == -1) {
            setSesionMode(-1);
            setSesionNum("");
        }
    }

    public boolean estaVacio() {
        return this.sesionNum.isEmpty() && this.sesionMode == -1 && this.dificultad == -1 && this.nombre.isEmpty();
    }
}
