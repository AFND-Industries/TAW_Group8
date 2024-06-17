package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.RutinaclienteDTO;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "rutinacliente")
public class Rutinacliente implements DTO<RutinaclienteDTO> {
    @EmbeddedId
    private RutinaclienteId id;

    @MapsId("usuarioId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "USUARIO_ID", nullable = false)
    private Usuario usuario;

    @MapsId("rutinaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "RUTINA_ID", nullable = false)
    private Rutina rutina;

    @Column(name = "FECHA_INICIO", nullable = false)
    private LocalDate fechaInicio;

    public RutinaclienteId getId() {
        return id;
    }

    public void setId(RutinaclienteId id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Rutina getRutina() {
        return rutina;
    }

    public void setRutina(Rutina rutina) {
        this.rutina = rutina;
    }

    public LocalDate getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(LocalDate fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    @Override
    public RutinaclienteDTO toDTO() {
        RutinaclienteDTO rutinaclienteDTO = new RutinaclienteDTO();
        rutinaclienteDTO.setUsuario(usuario.toDTO());
        rutinaclienteDTO.setRutina(rutina.toDTO());
        rutinaclienteDTO.setFechaInicio(fechaInicio);
        return rutinaclienteDTO;
    }
}