package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "rutinaentrenador")
public class Rutinaentrenador {
    @EmbeddedId
    private RutinaentrenadorId id;

    @MapsId("rutinaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "RUTINA_ID", nullable = false)
    private Rutina rutina;

    @MapsId("usuarioId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "USUARIO_ID", nullable = false)
    private Usuario usuario;

    public RutinaentrenadorId getId() {
        return id;
    }

    public void setId(RutinaentrenadorId id) {
        this.id = id;
    }

    public Rutina getRutina() {
        return rutina;
    }

    public void setRutina(Rutina rutina) {
        this.rutina = rutina;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

}