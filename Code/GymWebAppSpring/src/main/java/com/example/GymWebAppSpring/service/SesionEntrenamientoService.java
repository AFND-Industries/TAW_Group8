package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.RutinaRepository;
import com.example.GymWebAppSpring.dao.SesionEntrenamientoRepository;
import com.example.GymWebAppSpring.dto.SesionentrenamientoDTO;
import com.example.GymWebAppSpring.entity.Sesionentrenamiento;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SesionEntrenamientoService extends DTOService<SesionentrenamientoDTO, Sesionentrenamiento> {
    
    @Autowired
    protected SesionEntrenamientoRepository sesionEntrenamientoRepository;

    @Autowired
    protected RutinaRepository rutinaRepository;

    public List<SesionentrenamientoDTO> findAll() {
        List<Sesionentrenamiento> lista = this.sesionEntrenamientoRepository.findAll();
        return this.entidadesADTO(lista);
    }

    public List<SesionentrenamientoDTO> findByRutina(Integer rutinaId) {
        List<Sesionentrenamiento> lista = this.sesionEntrenamientoRepository.findSesionesByRutina(rutinaId);
        return this.entidadesADTO(lista);
    }

    public SesionentrenamientoDTO findById(Integer sesionentrenamientoId) {
        Sesionentrenamiento sesionentrenamiento = this.sesionEntrenamientoRepository.findById(sesionentrenamientoId).orElse(null);
        return sesionentrenamiento == null ? null : sesionentrenamiento.toDTO();
    }

    public void save(SesionentrenamientoDTO sesionentrenamientoDTO) {
        Sesionentrenamiento sesionentrenamiento = this.sesionEntrenamientoRepository.findById(sesionentrenamientoDTO.getId()).orElse(new Sesionentrenamiento());
        sesionentrenamiento.setNombre(sesionentrenamientoDTO.getNombre());
        sesionentrenamiento.setDia(sesionentrenamientoDTO.getDia());
        sesionentrenamiento.setDescripcion(sesionentrenamientoDTO.getDescripcion());
        sesionentrenamiento.setRutina(this.rutinaRepository.findById(sesionentrenamientoDTO.getRutina().getId()).orElse(null));
        this.sesionEntrenamientoRepository.save(sesionentrenamiento);
    }

    public void delete(Integer sesionentrenamientoId) {
        this.sesionEntrenamientoRepository.deleteById(sesionentrenamientoId);
    }

    public void deleteAll(List<Integer> sesiones) {
        this.sesionEntrenamientoRepository.deleteAllById(sesiones);
    }
}
