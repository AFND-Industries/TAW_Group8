package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Informacionejercicio;
import lombok.Data;

/**
 * DTO for {@link Informacionejercicio}
 */
@Data
public class InformacionejercicioDTO {
    Integer id;
    String evaluacion;
    EjerciciosesionDTO ejerciciosesion;
    InformacionsesionDTO informacionsesion;
}