package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.iu.RutinaArgument;
import com.example.GymWebAppSpring.iu.SesionArgument;
import lombok.Data;

@Data
public class EntrenadorCRUDContext {
    private RutinaArgument cache;
    private SesionArgument oldSesion;
    private Integer sesionPos;
}
