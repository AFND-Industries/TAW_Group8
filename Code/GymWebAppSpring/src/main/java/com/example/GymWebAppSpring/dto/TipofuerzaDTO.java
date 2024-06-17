package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Tipofuerza;
import lombok.Data;

/**
 * DTO for {@link Tipofuerza}
 */
@Data
public class TipofuerzaDTO {
    Integer id;
    String nombre;
    String descripcion;
}