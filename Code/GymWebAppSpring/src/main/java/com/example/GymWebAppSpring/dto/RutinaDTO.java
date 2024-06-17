package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Rutina;
import lombok.Data;

import java.time.LocalDate;

/**
 * DTO for {@link Rutina}
 */
@Data
public class RutinaDTO {
    Integer id;
    String nombre;
    String descripcion;
    DificultadDTO dificultad;
    LocalDate fechaCreacion;
    UsuarioDTO entrenador;
}