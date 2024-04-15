package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "informacionsesion")
public class Informacionsesion {
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

}