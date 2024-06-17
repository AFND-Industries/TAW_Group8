package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.EntrenadorasignadoIdDTO;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.util.Objects;

@Embeddable
public class EntrenadorasignadoId implements java.io.Serializable, DTO<EntrenadorasignadoIdDTO> {
    private static final long serialVersionUID = 2201934405635535458L;
    @Column(name = "ENTRENADOR", nullable = false)
    private Integer entrenador;

    @Column(name = "CLIENTE", nullable = false)
    private Integer cliente;

    public Integer getEntrenador() {
        return entrenador;
    }

    public void setEntrenador(Integer entrenador) {
        this.entrenador = entrenador;
    }

    public Integer getCliente() {
        return cliente;
    }

    public void setCliente(Integer cliente) {
        this.cliente = cliente;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        EntrenadorasignadoId entity = (EntrenadorasignadoId) o;
        return Objects.equals(this.cliente, entity.cliente) &&
                Objects.equals(this.entrenador, entity.entrenador);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cliente, entrenador);
    }

    @Override
    public EntrenadorasignadoIdDTO toDTO() {
EntrenadorasignadoIdDTO entrenadorasignadoIdDTO = new EntrenadorasignadoIdDTO();
        entrenadorasignadoIdDTO.setCliente(cliente);
        entrenadorasignadoIdDTO.setEntrenador(entrenador);
        return entrenadorasignadoIdDTO;
    }
}