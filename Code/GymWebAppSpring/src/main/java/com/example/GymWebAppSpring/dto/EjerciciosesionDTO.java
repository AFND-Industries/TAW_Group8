package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import lombok.Data;

/**
 * DTO for {@link Ejerciciosesion}
 */
@Data
public class EjerciciosesionDTO {
    Integer id;
    Integer orden;
    String especificaciones;
    SesionentrenamientoDTO sesionentrenamiento;
    EjercicioDTO ejercicio;
}