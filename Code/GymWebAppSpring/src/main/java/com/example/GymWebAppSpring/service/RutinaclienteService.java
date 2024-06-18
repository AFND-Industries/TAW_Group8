package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.RutinaClienteReporsitory;
import com.example.GymWebAppSpring.dao.RutinaRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.dto.RutinaDTO;
import com.example.GymWebAppSpring.dto.RutinaclienteDTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.entity.Rutina;
import com.example.GymWebAppSpring.entity.Rutinacliente;
import com.example.GymWebAppSpring.entity.RutinaclienteId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class RutinaclienteService extends DTOService<RutinaclienteDTO, Rutinacliente> {

    @Autowired
    private RutinaClienteReporsitory rutinaclienteRepository;

    @Autowired
    private RutinaRepository rutinaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    public List<RutinaclienteDTO> findAll() {
        return entidadesADTO(rutinaclienteRepository.findAll());
    }

    public RutinaclienteDTO findById(Integer RutinaId, Integer UsuarioId) {
        RutinaclienteId id = new RutinaclienteId();
        id.setRutinaId(RutinaId);
        id.setUsuarioId(UsuarioId);
        Rutinacliente rutinacliente = rutinaclienteRepository.findById(id).orElse(null);
        return rutinacliente != null ? rutinacliente.toDTO() : null;
    }

    public LocalDate findFechaInicioByRutinaAndUsuario(Integer rutinaId, Integer usuarioId) {
        return rutinaclienteRepository.findFechaInicioByRutinaAndUsuario(rutinaId, usuarioId);
    }

    public List<RutinaclienteDTO> findByUsuario(Integer usuarioId) {
        return this.entidadesADTO(rutinaclienteRepository.findByUsuario(usuarioId));
    }

    public void save(RutinaclienteDTO rutinaclienteDTO) {
        RutinaclienteId id = new RutinaclienteId();
        id.setRutinaId(rutinaclienteDTO.getId().getRutinaId());
        id.setUsuarioId(rutinaclienteDTO.getId().getUsuarioId());
        Rutinacliente rutinacliente = rutinaclienteRepository.findById(id).orElse(new Rutinacliente());
        rutinacliente.setRutina(rutinaRepository.findById(rutinaclienteDTO.getRutina().getId()).orElse(null));
        rutinacliente.setFechaInicio(rutinaclienteDTO.getFechaInicio());
        rutinacliente.setUsuario(usuarioRepository.findById(rutinaclienteDTO.getUsuario().getId()).orElse(null));
        rutinaclienteRepository.save(rutinacliente);
    }

    public void delete(Integer RutinaId, Integer UsuarioId) {
        RutinaclienteId id = new RutinaclienteId();
        id.setRutinaId(RutinaId);
        id.setUsuarioId(UsuarioId);
        rutinaclienteRepository.deleteById(id);
    }




}
