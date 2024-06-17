package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Dificultad;
import lombok.Data;

/**
 * DTO for {@link Dificultad}
 */
@Data
public class DificultadDTO {
    Integer id;
    String nombre;
    String logo;
}