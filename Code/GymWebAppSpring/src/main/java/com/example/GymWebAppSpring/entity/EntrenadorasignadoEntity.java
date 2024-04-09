package com.example.GymWebAppSpring.entity;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.util.Objects;

@Entity
@Table(name = "entrenadorasignado", schema = "tawbd", catalog = "")
public class EntrenadorasignadoEntity {
    @Basic
    @Column(name = "ENTRENADOR")
    private Integer entrenador;
    @Basic
    @Column(name = "CLIENTE")
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
        if (o == null || getClass() != o.getClass()) return false;
        EntrenadorasignadoEntity that = (EntrenadorasignadoEntity) o;
        return Objects.equals(entrenador, that.entrenador) && Objects.equals(cliente, that.cliente);
    }

    @Override
    public int hashCode() {
        return Objects.hash(entrenador, cliente);
    }
}
