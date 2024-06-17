package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.InformacionsesionDTO;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "informacionsesion")
public class Informacionsesion implements DTO<InformacionsesionDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "VALORACION")
    private Integer valoracion;

    @Column(name = "COMENTARIO", length = 256)
    private String comentario;

    @Column(name = "FECHA_FIN")
    private LocalDate fechaFin;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "SESIONENTRENAMIENTO_ID", nullable = false)
    private Sesionentrenamiento sesionentrenamiento;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "USUARIO_ID", nullable = false)
    private Usuario usuario;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getValoracion() {
        return valoracion;
    }

    public void setValoracion(Integer valoracion) {
        this.valoracion = valoracion;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public LocalDate getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(LocalDate fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Sesionentrenamiento getSesionentrenamiento() {
        return sesionentrenamiento;
    }

    public void setSesionentrenamiento(Sesionentrenamiento sesionentrenamiento) {
        this.sesionentrenamiento = sesionentrenamiento;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    @Override
    public InformacionsesionDTO toDTO() {
        InformacionsesionDTO informacionsesionDTO = new InformacionsesionDTO();
        informacionsesionDTO.setId(this.id);
        informacionsesionDTO.setValoracion(this.valoracion);
        informacionsesionDTO.setComentario(this.comentario);
        informacionsesionDTO.setFechaFin(this.fechaFin);
        informacionsesionDTO.setSesionentrenamiento(this.sesionentrenamiento.toDTO());
        informacionsesionDTO.setUsuario(this.usuario.toDTO());
        return informacionsesionDTO;
    }
}