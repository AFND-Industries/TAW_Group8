package com.example.GymWebAppSpring.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "ejercicio", schema = "tawbd", catalog = "")
public class EjercicioEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "ID")
    private int id;
    @Basic
    @Column(name = "NOMBRE")
    private String nombre;
    @Basic
    @Column(name = "DESCRIPCION")
    private String descripcion;
    @Basic
    @Column(name = "MUSCULO")
    private int musculo;
    @Basic
    @Column(name = "EQUIPAMIENTO")
    private String equipamiento;
    @Basic
    @Column(name = "TIPOFUERZA")
    private int tipofuerza;
    @Basic
    @Column(name = "MUSCULO_SECUNDARIO")
    private Integer musculoSecundario;
    @Basic
    @Column(name = "VIDEO")
    private String video;
    @Basic
    @Column(name = "LOGO")
    private String logo;
    @Basic
    @Column(name = "CATEGORIA")
    private int categoria;

    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public int getMusculo() {
        return musculo;
    }

    public void setMusculo(int musculo) {
        this.musculo = musculo;
    }

    public String getEquipamiento() {
        return equipamiento;
    }

    public void setEquipamiento(String equipamiento) {
        this.equipamiento = equipamiento;
    }

    public int getTipofuerza() {
        return tipofuerza;
    }

    public void setTipofuerza(int tipofuerza) {
        this.tipofuerza = tipofuerza;
    }

    public Integer getMusculoSecundario() {
        return musculoSecundario;
    }

    public void setMusculoSecundario(Integer musculoSecundario) {
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

    public int getCategoria() {
        return categoria;
    }

    public void setCategoria(int categoria) {
        this.categoria = categoria;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        EjercicioEntity that = (EjercicioEntity) o;
        return id == that.id && musculo == that.musculo && tipofuerza == that.tipofuerza && categoria == that.categoria && Objects.equals(nombre, that.nombre) && Objects.equals(descripcion, that.descripcion) && Objects.equals(equipamiento, that.equipamiento) && Objects.equals(musculoSecundario, that.musculoSecundario) && Objects.equals(video, that.video) && Objects.equals(logo, that.logo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nombre, descripcion, musculo, equipamiento, tipofuerza, musculoSecundario, video, logo, categoria);
    }
}
