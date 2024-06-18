package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.DificultadRepository;
import com.example.GymWebAppSpring.dto.DificultadDTO;
import com.example.GymWebAppSpring.entity.Dificultad;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DificultadService extends DTOService<DificultadDTO, Dificultad>{

    @Autowired
    private DificultadRepository dificultadRepository;

    public List<DificultadDTO> findAll(){
        return entidadesADTO(dificultadRepository.findAll());
    }

    public DificultadDTO findById(Integer id){
        Dificultad dificultad = dificultadRepository.findById(id).orElse(null);
        return dificultad != null ? dificultad.toDTO() : null;
    }

    public void save(DificultadDTO dificultadDTO){
        Integer id = dificultadDTO.getId();
        Dificultad dificultad = dificultadRepository.findById(id == null ? -1 : id).orElse(new Dificultad());
        dificultad.setNombre(dificultadDTO.getNombre());
        dificultad.setLogo(dificultadDTO.getLogo());
        dificultadRepository.save(dificultad);
    }

    public void delete(Integer id){
        dificultadRepository.deleteById(id);
    }

}
