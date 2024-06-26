package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.EjercicioRepository;
import com.example.GymWebAppSpring.dao.EjercicioSesionRepository;
import com.example.GymWebAppSpring.dao.SesionEntrenamientoRepository;
import com.example.GymWebAppSpring.dto.EjerciciosesionDTO;
import com.example.GymWebAppSpring.dto.SesionentrenamientoDTO;
import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EjerciciosesionService extends DTOService<EjerciciosesionDTO, Ejerciciosesion> {

    @Autowired
    protected EjercicioSesionRepository ejercicioSesionRepository;

    @Autowired
    protected EjercicioRepository ejercicioRepository;

    @Autowired
    protected SesionEntrenamientoRepository sesionEntrenamientoRepository;

    public List<EjerciciosesionDTO> findAll() {
        List<Ejerciciosesion> lista = this.ejercicioSesionRepository.findAll();
        return this.entidadesADTO(lista);
    }

    public List<EjerciciosesionDTO> findBySesion(Integer sesionId) {
        List<Ejerciciosesion> lista = this.ejercicioSesionRepository.findEjerciciosBySesion(sesionId);
        return this.entidadesADTO(lista);
    }

    public EjerciciosesionDTO findById(Integer ejerciciosesionId) {
        Ejerciciosesion ejerciciosesion = this.ejercicioSesionRepository.findById(ejerciciosesionId).orElse(null);
        return ejerciciosesion == null ? null : ejerciciosesion.toDTO();
    }

    public void save(EjerciciosesionDTO ejerciciosesionDTO) {
        int ejerciciosesionId = ejerciciosesionDTO.getId() == null ? -1 : ejerciciosesionDTO.getId();
        Ejerciciosesion ejerciciosesion = this.ejercicioSesionRepository.findById(ejerciciosesionId).orElse(new Ejerciciosesion());
        ejerciciosesion.setEjercicio(ejercicioRepository.findById(ejerciciosesionDTO.getEjercicio().getId()).orElse(null));
        ejerciciosesion.setOrden(ejerciciosesionDTO.getOrden());
        ejerciciosesion.setEspecificaciones(ejerciciosesionDTO.getEspecificaciones());
        ejerciciosesion.setSesionentrenamiento(sesionEntrenamientoRepository.findById(ejerciciosesionDTO.getSesionentrenamiento().getId()).orElse(null));
        this.ejercicioSesionRepository.save(ejerciciosesion);
    }

    public void delete(Integer ejercicioSesionid) {
        this.ejercicioSesionRepository.deleteById(ejercicioSesionid);
    }

    public void deleteAllById(List<Integer> ejerciciosSesion) {
        ejercicioSesionRepository.deleteAllById(ejerciciosSesion);
    }

    public void deleteAll(List<EjerciciosesionDTO> ejerciciosSesion) {
        List<Integer> ids = new ArrayList<>();
        for (EjerciciosesionDTO ejercicio : ejerciciosSesion)
            ids.add(ejercicio.getId());

        deleteAllById(ids);
    }

    public List<EjerciciosesionDTO> findBySesionOrdered(Integer sesionId) {
        List<Ejerciciosesion> ejerciciosesion = this.ejercicioSesionRepository.findBySesionOrdered(sesionId);
        return this.entidadesADTO(ejerciciosesion);
    }

    public EjerciciosesionDTO findBySesionAndIndexOrdered(Integer sesionId, Integer index) {
        List<Ejerciciosesion> ejerciciosesion = this.ejercicioSesionRepository.findBySesionOrdered(sesionId);
        return ejerciciosesion == null ? null : ejerciciosesion.get(index).toDTO();
    }


}
