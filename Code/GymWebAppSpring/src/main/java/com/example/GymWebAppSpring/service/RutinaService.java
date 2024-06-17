package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.DificultadRepository;
import com.example.GymWebAppSpring.dao.RutinaRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.entity.Dificultad;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.dto.RutinaDTO;
import com.example.GymWebAppSpring.dto.DificultadDTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RutinaService extends DTOService<RutinaDTO, Rutina>{

    @Autowired
    protected RutinaRepository rutinaRepository;

    @Autowired
    protected DificultadRepository dificultadRepository;

    @Autowired
    protected UsuarioRepository usuarioRepository;

    public List<RutinaDTO> findAll() {
        List<Rutina> lista = this.rutinaRepository.findAll();
        return this.entidadesADTO(lista);
    }

    public List<RutinaDTO> findRutinaByEntrenadorId(Integer entrenadorId) {
        List<Rutina> lista = this.rutinaRepository.findRutinaByEntrenadorId(entrenadorId);
        return this.entidadesADTO(lista);
    }

    public List<RutinaDTO> findRutinaByEntrenadorWithFilter(Integer entrenadorId, String nombre, Integer limiteBajo,
                                              Integer limiteAlto, Integer dificultadId) {
        List<Rutina> lista = this.rutinaRepository.findRutinaByEntrenadorWithFilter(
                entrenadorId, nombre, limiteBajo, limiteAlto, dificultadId);
        return this.entidadesADTO(lista);
    }

    public RutinaDTO findById(Integer rutinaId) {
        Rutina rutina = this.rutinaRepository.findById(rutinaId).orElse(null);
        return rutina == null ? null : rutina.toDTO();
    }

    public void save(RutinaDTO rutinaDTO) {
        Rutina rutina = this.rutinaRepository.findById(rutinaDTO.getId()).orElse(new Rutina());
        rutina.setDificultad(this.dificultadRepository.findById(rutinaDTO.getDificultad().getId()).orElse(null));
        rutina.setDescripcion(rutinaDTO.getDescripcion());
        rutina.setNombre(rutinaDTO.getNombre());
        rutina.setEntrenador(this.usuarioRepository.findById(rutinaDTO.getEntrenador().getId()).orElse(null));
        rutina.setFechaCreacion(rutinaDTO.getFechaCreacion());
        this.rutinaRepository.save(rutina);
    }

    public void delete(Integer rutinaId) {
        this.rutinaRepository.deleteById(rutinaId);
    }
}
