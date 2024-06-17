package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.EntrenadorasignadoDTO;
import jakarta.persistence.*;

@Entity
@Table(name = "entrenadorasignado")
public class Entrenadorasignado implements DTO<EntrenadorasignadoDTO> {
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

    @Override
    public EntrenadorasignadoDTO toDTO() {
        EntrenadorasignadoDTO entrenadorasignadoDTO = new EntrenadorasignadoDTO();
        entrenadorasignadoDTO.setEntrenador(entrenador.toDTO());
        entrenadorasignadoDTO.setCliente(cliente.toDTO());
        return entrenadorasignadoDTO;
    }
}