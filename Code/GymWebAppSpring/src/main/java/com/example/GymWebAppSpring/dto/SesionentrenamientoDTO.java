package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import lombok.Data;

/**
 * DTO for {@link Sesionentrenamiento}
 */
@Data
public class SesionentrenamientoDTO {
    Integer id;
    String nombre;
    String descripcion;
    Integer dia;
    RutinaDTO rutina;
}