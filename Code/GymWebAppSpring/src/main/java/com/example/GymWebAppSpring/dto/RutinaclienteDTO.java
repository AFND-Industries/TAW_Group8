package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Rutinacliente;
import lombok.Data;

import java.time.LocalDate;

/**
 * DTO for {@link Rutinacliente}
 */
@Data
public class RutinaclienteDTO {
    RutinaclienteIdDTO id;
    UsuarioDTO usuario;
    RutinaDTO rutina;
    LocalDate fechaInicio;
}