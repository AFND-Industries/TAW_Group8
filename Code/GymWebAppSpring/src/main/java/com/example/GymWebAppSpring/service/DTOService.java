package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dto.DTO;

import java.util.ArrayList;
import java.util.List;

public abstract class DTOService<DTOClass, EntityClass> {

    protected List<DTOClass> entidadesADTO (List<EntityClass> entidades) {
        // lapply
        return entidades.stream().map((entity) -> ((DTO<DTOClass>) entity).toDTO()).toList();
    }

}
