package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.MusculoRepository;
import com.example.GymWebAppSpring.dto.MusculoDTO;
import com.example.GymWebAppSpring.entity.Musculo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MusculoService extends DTOService<MusculoDTO, Musculo> {

    @Autowired
    private MusculoRepository musculoRepository;

    public List<MusculoDTO> findAll() {
        return entidadesADTO(musculoRepository.findAll());
    }

    public MusculoDTO findById(Integer id) {
        Musculo musculo = musculoRepository.findById(id == null ? -1 : id).orElse(null);
        return musculo != null ? musculo.toDTO() : null;
    }

    public void save(MusculoDTO musculoDTO) {
        Musculo musculo = musculoRepository.findById(musculoDTO.getId()).orElse(new Musculo());
        musculo.setNombre(musculoDTO.getNombre());
        musculo.setDescripcion(musculoDTO.getDescripcion());
        musculo.setImagen(musculoDTO.getImagen());
        musculoRepository.save(musculo);
    }

    public void delete(Integer id) {
        musculoRepository.deleteById(id);
    }
}
