package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.CategoriaRepository;
import com.example.GymWebAppSpring.dao.EjercicioRepository;
import com.example.GymWebAppSpring.dao.MusculoRepository;
import com.example.GymWebAppSpring.dao.TipoFuerzaRepository;
import com.example.GymWebAppSpring.dto.EjercicioDTO;
import com.example.GymWebAppSpring.entity.Ejercicio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EjercicioService extends DTOService<EjercicioDTO, Ejercicio>{

    @Autowired
    protected EjercicioRepository ejercicioRepository;

    @Autowired
    protected CategoriaRepository categoriaRepository;

    @Autowired
    protected MusculoRepository musculoRepository;

    @Autowired
    protected TipoFuerzaRepository tipoFuerzaRepository;

    public List<EjercicioDTO> findAll() {
        List<Ejercicio> lista = this.ejercicioRepository.findAll();
        return this.entidadesADTO(lista);
    }

    public List<EjercicioDTO> findEjercicioBySesion(Integer sesionId) {
        List<Ejercicio> lista = this.ejercicioRepository.findEjercicioBySesion(sesionId);
        return this.entidadesADTO(lista);
    }

    public List<EjercicioDTO> findEjercicioByIds(List<Integer> list) {
        List<Ejercicio> lista = this.ejercicioRepository.findEjercicioByIds(list);
        return this.entidadesADTO(lista);
    }

    public List<EjercicioDTO> findAllEjerciciosFuerza() {
        List<Ejercicio> lista = this.ejercicioRepository.findAllEjerciciosFuerza();
        return this.entidadesADTO(lista);
    }

    public List<EjercicioDTO> findAllByCategoria(Integer categoriaId) {
        List<Ejercicio> lista = this.ejercicioRepository.findAllByCategoria(categoriaId);
        return this.entidadesADTO(lista);
    }

    public List<EjercicioDTO> findAllByMusculo(Integer musculoId) {
        List<Ejercicio> lista = this.ejercicioRepository.findAllByMusculo(musculoId);
        return this.entidadesADTO(lista);
    }

    public List<EjercicioDTO> findAllByNombre(String nombre) {
        List<Ejercicio> lista = this.ejercicioRepository.findAllByNombre(nombre);
        return this.entidadesADTO(lista);
    }

    public EjercicioDTO findById(Integer ejercicioId) {
        Ejercicio ejercicio = this.ejercicioRepository.findById(ejercicioId).orElse(null);
        return ejercicio == null ? null : ejercicio.toDTO();
    }

    public void save(EjercicioDTO ejercicioDTO) {
        Ejercicio ejercicio = this.ejercicioRepository.findById(ejercicioDTO.getId()).orElse(new Ejercicio());
        ejercicio.setDescripcion(ejercicioDTO.getDescripcion());
        ejercicio.setCategoria(this.categoriaRepository.findById(ejercicioDTO.getCategoria().getId()).orElse(null));
        ejercicio.setNombre(ejercicioDTO.getNombre());
        ejercicio.setLogo(ejercicioDTO.getLogo());
        ejercicio.setEquipamiento(ejercicioDTO.getEquipamiento());
        ejercicio.setMusculo(this.musculoRepository.findById(ejercicioDTO.getMusculo().getId()).orElse(null));
        ejercicio.setMusculoSecundario(this.musculoRepository.findById(ejercicioDTO.getMusculoSecundario().getId()).orElse(null));
        ejercicio.setTipofuerza(this.tipoFuerzaRepository.findById(ejercicioDTO.getTipofuerza().getId()).orElse(null));
        ejercicio.setVideo(ejercicioDTO.getVideo());
        this.ejercicioRepository.save(ejercicio);
    }

    public void delete(Integer ejercicioId) {
        this.ejercicioRepository.deleteById(ejercicioId);
    }
}
