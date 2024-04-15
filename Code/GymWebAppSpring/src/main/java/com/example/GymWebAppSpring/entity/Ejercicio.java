package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "ejercicio")
public class Ejercicio {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "NOMBRE", nullable = false, length = 32)
    private String nombre;

    @Column(name = "DESCRIPCION", nullable = false, length = 256)
    private String descripcion;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "MUSCULO", nullable = false)
    private Musculo musculo;

    @Column(name = "EQUIPAMIENTO", nullable = false, length = 32)
    private String equipamiento;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "TIPOFUERZA", nullable = false)
    private Tipofuerza tipofuerza;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MUSCULO_SECUNDARIO")
    private Musculo musculoSecundario;

    @Column(name = "VIDEO", nullable = false, length = 256)
    private String video;

    @Column(name = "LOGO", nullable = false, length = 256)
    private String logo;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "CATEGORIA", nullable = false)
    private Categoria categoria;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Musculo getMusculo() {
        return musculo;
    }

    public void setMusculo(Musculo musculo) {
        this.musculo = musculo;
    }

    public String getEquipamiento() {
        return equipamiento;
    }

    public void setEquipamiento(String equipamiento) {
        this.equipamiento = equipamiento;
    }

    public Tipofuerza getTipofuerza() {
        return tipofuerza;
    }

    public void setTipofuerza(Tipofuerza tipofuerza) {
        this.tipofuerza = tipofuerza;
    }

    public Musculo getMusculoSecundario() {
        return musculoSecundario;
    }

    public void setMusculoSecundario(Musculo musculoSecundario) {
        this.musculoSecundario = musculoSecundario;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

}