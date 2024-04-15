package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "sesionrutinas")
public class Sesionrutina {
    @EmbeddedId
    private SesionrutinaId id;

    @MapsId("rutinaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "RUTINA_ID", nullable = false)
    private Rutina rutina;

    @MapsId("sesionentrenamientoId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "SESIONENTRENAMIENTO_ID", nullable = false)
    private Sesionentrenamiento sesionentrenamiento;

    @Column(name = "DIA", nullable = false)
    private Integer dia;

    public SesionrutinaId getId() {
        return id;
    }

    public void setId(SesionrutinaId id) {
        this.id = id;
    }

    public Rutina getRutina() {
        return rutina;
    }

    public void setRutina(Rutina rutina) {
        this.rutina = rutina;
    }

    public Sesionentrenamiento getSesionentrenamiento() {
        return sesionentrenamiento;
    }

    public void setSesionentrenamiento(Sesionentrenamiento sesionentrenamiento) {
        this.sesionentrenamiento = sesionentrenamiento;
    }

    public Integer getDia() {
        return dia;
    }

    public void setDia(Integer dia) {
        this.dia = dia;
    }

}