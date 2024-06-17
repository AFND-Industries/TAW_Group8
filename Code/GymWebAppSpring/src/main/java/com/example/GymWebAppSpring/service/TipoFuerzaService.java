package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.TipoFuerzaRepository;
import com.example.GymWebAppSpring.dto.TipofuerzaDTO;
import com.example.GymWebAppSpring.entity.Tipofuerza;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TipoFuerzaService extends DTOService<TipofuerzaDTO, Tipofuerza>{

    @Autowired
    private TipoFuerzaRepository tipoFuerzaRepository;

    public List<TipofuerzaDTO> findAll(){
        return entidadesADTO(tipoFuerzaRepository.findAll());
    }

    public TipofuerzaDTO findById(Integer id){
        Tipofuerza tipofuerza = tipoFuerzaRepository.findById(id).orElse(null);
        return tipofuerza != null ? tipofuerza.toDTO() : null;
    }

    public void save(TipofuerzaDTO tipofuerzaDTO){
        Tipofuerza tipofuerza = tipoFuerzaRepository.findById(tipofuerzaDTO.getId()).orElse(new Tipofuerza());
        tipofuerza.setNombre(tipofuerzaDTO.getNombre());
        tipofuerza.setDescripcion(tipofuerzaDTO.getDescripcion());
        tipoFuerzaRepository.save(tipofuerza);
    }

    public void delete(Integer id){
        tipoFuerzaRepository.deleteById(id);
    }

}
