package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "entrenadorasignado")
public class Entrenadorasignado {
    @EmbeddedId
    private EntrenadorasignadoId id;

    @MapsId("entrenador")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "ENTRENADOR", nullable = false)
    private Usuario entrenador;

    @MapsId("cliente")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "CLIENTE", nullable = false)
    private Usuario cliente;

    public EntrenadorasignadoId getId() {
        return id;
    }

    public void setId(EntrenadorasignadoId id) {
        this.id = id;
    }

    public Usuario getEntrenador() {
        return entrenador;
    }

    public void setEntrenador(Usuario entrenador) {
        this.entrenador = entrenador;
    }

    public Usuario getCliente() {
        return cliente;
    }

    public void setCliente(Usuario cliente) {
        this.cliente = cliente;
    }

}