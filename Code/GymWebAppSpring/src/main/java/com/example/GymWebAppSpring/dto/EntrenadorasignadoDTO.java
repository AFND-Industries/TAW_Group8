package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Entrenadorasignado;
import lombok.Data;

/**
 * DTO for {@link Entrenadorasignado}
 */
@Data
public class EntrenadorasignadoDTO {
    EntrenadorasignadoIdDTO id;
    UsuarioDTO entrenador;
    UsuarioDTO cliente;
}