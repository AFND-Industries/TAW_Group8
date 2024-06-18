package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.EjercicioSesionRepository;
import com.example.GymWebAppSpring.dao.InformacionEjercicioRepository;
import com.example.GymWebAppSpring.dao.InformacionSesionRepository;
import com.example.GymWebAppSpring.dto.InformacionejercicioDTO;
import com.example.GymWebAppSpring.entity.Informacionejercicio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InformacionejercicioService extends DTOService<InformacionejercicioDTO, Informacionejercicio> {

    @Autowired
    private InformacionEjercicioRepository informacionejercicioRepository;

    @Autowired
    private EjercicioSesionRepository ejercicioSesionRepository;

    @Autowired
    private InformacionSesionRepository informacionSesionRepository;

    public List<InformacionejercicioDTO> findAll() {
        return entidadesADTO(informacionejercicioRepository.findAll());
    }

    public InformacionejercicioDTO findById(Integer id) {
        Informacionejercicio informacionejercicio = informacionejercicioRepository.findById(id).orElse(null);
        return informacionejercicio != null ? informacionejercicio.toDTO() : null;
    }

    public InformacionejercicioDTO findByEjerciciosesionAndInformacionsesion(Integer ejerciciosesionId, Integer informacionsesionId) {
        return informacionejercicioRepository.findByEjerciciosesionAndInformacionsesion(ejerciciosesionId, informacionsesionId).toDTO();
    }

    public void save(InformacionejercicioDTO informacionejercicioDTO) {
        Informacionejercicio informacionejercicio;
        if (informacionejercicioDTO.getId() == null) {
            informacionejercicio = new Informacionejercicio();
        } else {
            informacionejercicio = informacionejercicioRepository.findById(informacionejercicioDTO.getId()).orElse(new Informacionejercicio());
        }
        informacionejercicio.setEvaluacion(informacionejercicioDTO.getEvaluacion());
        informacionejercicio.setEjerciciosesion(ejercicioSesionRepository.findById(informacionejercicioDTO.getEjerciciosesion().getId()).orElse(null));
        informacionejercicio.setInformacionsesion(informacionSesionRepository.findById(informacionejercicioDTO.getInformacionsesion().getId()).orElse(null));
        informacionejercicioRepository.save(informacionejercicio);
    }

    public void delete(InformacionejercicioDTO informacionejercicioDTO) {
        informacionejercicioRepository.deleteById(informacionejercicioDTO.getId());
    }

    public  void deleteAll(List<InformacionejercicioDTO> informacionejercicioDTOList){
        for (InformacionejercicioDTO informacionejercicioDTO : informacionejercicioDTOList) {
            informacionejercicioRepository.deleteById(informacionejercicioDTO.getId());
        }
    }

    public List<InformacionejercicioDTO> findBySesionentrenamiento(Integer sesionentrenamientoId) {
        return this.entidadesADTO(informacionejercicioRepository.findBySesionentrenamiento(sesionentrenamientoId));
    }

}
