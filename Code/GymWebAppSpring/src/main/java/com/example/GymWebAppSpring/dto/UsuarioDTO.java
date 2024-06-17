package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Usuario;
import lombok.Data;

/**
 * DTO for {@link Usuario}
 */
@Data
public class UsuarioDTO {
    Integer id;
    String nombre;
    String apellidos;
    Character genero;
    Integer edad;
    String dni;
    String clave;
    TipousuarioDTO tipo;
}