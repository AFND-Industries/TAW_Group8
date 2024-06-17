package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.InformacionejercicioDTO;
import jakarta.persistence.*;

@Entity
@Table(name = "informacionejercicio")
public class Informacionejercicio implements DTO<InformacionejercicioDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "EVALUACION", nullable = false, length = 256)
    private String evaluacion;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "EJERCICIOSESION_ID", nullable = false)
    private Ejerciciosesion ejerciciosesion;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "INFORMACIONSESION_ID", nullable = false)
    private Informacionsesion informacionsesion;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEvaluacion() {
        return evaluacion;
    }

    public void setEvaluacion(String evaluacion) {
        this.evaluacion = evaluacion;
    }

    public Ejerciciosesion getEjerciciosesion() {
        return ejerciciosesion;
    }

    public void setEjerciciosesion(Ejerciciosesion ejerciciosesion) {
        this.ejerciciosesion = ejerciciosesion;
    }

    public Informacionsesion getInformacionsesion() {
        return informacionsesion;
    }

    public void setInformacionsesion(Informacionsesion informacionsesion) {
        this.informacionsesion = informacionsesion;
    }

    @Override
    public InformacionejercicioDTO toDTO() {
        InformacionejercicioDTO informacionejercicioDTO = new InformacionejercicioDTO();
        informacionejercicioDTO.setEvaluacion(evaluacion);
        informacionejercicioDTO.setEjerciciosesion(ejerciciosesion.toDTO());
        informacionejercicioDTO.setInformacionsesion(informacionsesion.toDTO());
        return informacionejercicioDTO;
    }
}