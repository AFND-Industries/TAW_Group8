package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Musculo;
import lombok.Data;

/**
 * DTO for {@link Musculo}
 */
@Data
public class MusculoDTO {
    Integer id;
    String nombre;
    String descripcion;
    String imagen;
}