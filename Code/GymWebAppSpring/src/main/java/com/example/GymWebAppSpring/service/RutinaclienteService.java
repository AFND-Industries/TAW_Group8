package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.RutinaClienteIDRepository;
import com.example.GymWebAppSpring.dao.RutinaClienteReporsitory;
import com.example.GymWebAppSpring.dao.RutinaRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.dto.RutinaclienteDTO;
import com.example.GymWebAppSpring.entity.Rutinacliente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RutinaclienteService extends DTOService<RutinaclienteDTO, Rutinacliente> {

    @Autowired
    private RutinaClienteReporsitory rutinaclienteRepository;

    @Autowired
    private RutinaRepository rutinaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private RutinaClienteIDRepository rutinaClienteIDRepository;

    public List<RutinaclienteDTO> findAll() {
        return entidadesADTO(rutinaclienteRepository.findAll());
    }

    public RutinaclienteDTO findById(Integer id) {
        Rutinacliente rutinacliente = rutinaclienteRepository.findById(id).orElse(null);
        return rutinacliente != null ? rutinacliente.toDTO() : null;
    }

    public void save(RutinaclienteDTO rutinaclienteDTO) {
        Rutinacliente rutinacliente = rutinaclienteRepository.findById(rutinaClienteIDRepository.findById(rutinaclienteDTO.getId().getRutinaId()).orElse(null)).orElse(new Rutinacliente());
        rutinacliente.setRutina(rutinaRepository.findById(rutinaclienteDTO.getRutina().getId()).orElse(null));
        rutinacliente.setFechaInicio(rutinaclienteDTO.getFechaInicio());
        rutinacliente.setUsuario(usuarioRepository.findById(rutinaclienteDTO.getUsuario().getId()).orElse(null));
        rutinaclienteRepository.save(rutinacliente);
    }


}
