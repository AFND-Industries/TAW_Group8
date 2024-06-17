package com.example.GymWebAppSpring.dto;

import lombok.Data;

/**
 * DTO for {@link Categoria}
 */
@Data
public class CategoriaDTO {
    Integer id;
    String nombre;
    String descripcion;
    String tiposBase;
    String icono;
}