package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Informacionsesion;
import lombok.Data;

import java.time.LocalDate;

/**
 * DTO for {@link Informacionsesion}
 */
@Data
public class InformacionsesionDTO {
    Integer id;
    Integer valoracion;
    String comentario;
    LocalDate fechaFin;
    SesionentrenamientoDTO sesionentrenamiento;
    UsuarioDTO usuario;
}