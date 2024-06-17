package com.example.GymWebAppSpring.dto;

import com.example.GymWebAppSpring.entity.Ejercicio;
import lombok.Data;

/**
 * DTO for {@link Ejercicio}
 */
@Data
public class EjercicioDTO {
    Integer id;
    String nombre;
    String descripcion;
    MusculoDTO musculo;
    String equipamiento;
    TipofuerzaDTO tipofuerza;
    MusculoDTO musculoSecundario;
    String video;
    String logo;
    CategoriaDTO categoria;
}