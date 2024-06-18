package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.InformacionSesionRepository;
import com.example.GymWebAppSpring.dao.SesionEntrenamientoRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.dto.InformacionsesionDTO;
import com.example.GymWebAppSpring.entity.Informacionsesion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InformacionsesionService extends DTOService<InformacionsesionDTO, Informacionsesion> {

    @Autowired
    private InformacionSesionRepository informacionSesionRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private SesionEntrenamientoRepository sesionEntrenamientoRepository;


    public List<InformacionsesionDTO> findAll() {
        return entidadesADTO(informacionSesionRepository.findAll());
    }

    public InformacionsesionDTO findById(Integer id) {
        Informacionsesion informacionsesion = informacionSesionRepository.findById(id).orElse(null);
        return informacionsesion != null ? informacionsesion.toDTO() : null;
    }

    public InformacionsesionDTO findByUsuarioAndSesion(Integer usuarioId, Integer sesionId) {
        Informacionsesion informacionsesion = informacionSesionRepository.findByUsuarioAndSesion(usuarioId, sesionId);
        return (informacionsesion != null) ? informacionsesion.toDTO() : null;
    }

    public void save(InformacionsesionDTO informacionsesionDTO) {
        Informacionsesion informacionsesion;
        if (informacionsesionDTO.getId() == null) {
            informacionsesion = new Informacionsesion();
        } else {
            informacionsesion = informacionSesionRepository.findById(informacionsesionDTO.getId()).orElse(new Informacionsesion());
        }

        informacionsesion.setFechaFin(informacionsesionDTO.getFechaFin());
        informacionsesion.setComentario(informacionsesionDTO.getComentario());
        informacionsesion.setValoracion(informacionsesionDTO.getValoracion());
        informacionsesion.setUsuario(usuarioRepository.findById(informacionsesionDTO.getUsuario().getId()).orElse(null));
        informacionsesion.setSesionentrenamiento(sesionEntrenamientoRepository.findById(informacionsesionDTO.getSesionentrenamiento().getId()).orElse(null));
        informacionSesionRepository.save(informacionsesion);
    }

    public void delete(InformacionsesionDTO informacionsesionDTO) {
        informacionSesionRepository.deleteById(informacionsesionDTO.getId());
    }
}
