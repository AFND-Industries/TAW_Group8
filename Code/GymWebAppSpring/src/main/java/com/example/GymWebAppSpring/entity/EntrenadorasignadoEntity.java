package com.example.GymWebAppSpring.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.util.Objects;

@Entity
@jakarta.persistence.Table(name = "entrenadorasignado", schema = "tawbd", catalog = "")
@jakarta.persistence.IdClass(com.example.GymWebAppSpring.entity.EntrenadorasignadoEntityPK.class)
public class EntrenadorasignadoEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @jakarta.persistence.Column(name = "ENTRENADOR")
    private int entrenador;

    public int getEntrenador() {
        return entrenador;
    }

    public void setEntrenador(int entrenador) {
        this.entrenador = entrenador;
    }

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @jakarta.persistence.Column(name = "CLIENTE")
    private int cliente;

    public int getCliente() {
        return cliente;
    }

    public void setCliente(int cliente) {
        this.cliente = cliente;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        EntrenadorasignadoEntity that = (EntrenadorasignadoEntity) o;
        return entrenador == that.entrenador && cliente == that.cliente;
    }

    @Override
    public int hashCode() {
        return Objects.hash(entrenador, cliente);
    }
}
