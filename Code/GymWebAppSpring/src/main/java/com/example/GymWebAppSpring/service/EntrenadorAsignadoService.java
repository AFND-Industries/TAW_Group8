package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.EntrenadorAsignadoRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.dto.EntrenadorasignadoDTO;
import com.example.GymWebAppSpring.dto.EntrenadorasignadoIdDTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.entity.Entrenadorasignado;
import com.example.GymWebAppSpring.entity.EntrenadorasignadoId;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EntrenadorAsignadoService extends DTOService<EntrenadorasignadoDTO, Entrenadorasignado>{

    @Autowired
    private EntrenadorAsignadoRepository entrenadorAsignadoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    public List<EntrenadorasignadoDTO> findAll(){
        return entidadesADTO(entrenadorAsignadoRepository.findAll());
    }

    public EntrenadorasignadoDTO findById(EntrenadorasignadoIdDTO idDTO){
        EntrenadorasignadoId id = new EntrenadorasignadoId();
        id.setEntrenador(idDTO.getEntrenador());
        id.setCliente(idDTO.getCliente());
        Entrenadorasignado entrenador = entrenadorAsignadoRepository.findById(id).orElse(null);
        return entrenador != null ? entrenador.toDTO() : null;
    }

    public List<UsuarioDTO> findClientsByEntrenadorID(UsuarioDTO entrenador){
        return entrenadorAsignadoRepository.findClientsByEntrenadorID(entrenador.getId()).stream().map(usuario -> usuario.toDTO()).toList();
    }

    public List<UsuarioDTO> findEntrenadoresByClientID(UsuarioDTO client){
        return entrenadorAsignadoRepository.findEntrenadoresByClientID(client.getId()).stream().map(usuario -> usuario.toDTO()).toList();
    }

    public List<EntrenadorasignadoDTO> findByCliente(UsuarioDTO client){
        return entidadesADTO(entrenadorAsignadoRepository.findByCliente(client.getId()));
    }

    public void save(EntrenadorasignadoDTO entrenadorasignadoDTO){
        EntrenadorasignadoId id = new EntrenadorasignadoId(){{
            setCliente(entrenadorasignadoDTO.getId().getCliente());
            setEntrenador(entrenadorasignadoDTO.getId().getEntrenador());
        }};
        Entrenadorasignado entrenadorasignado = entrenadorAsignadoRepository.findById(id).orElse(new Entrenadorasignado());
        entrenadorasignado.setId(id);
        entrenadorasignado.setEntrenador(usuarioRepository.findById(entrenadorasignadoDTO.getEntrenador().getId()).orElse(null));
        entrenadorasignado.setCliente(usuarioRepository.findById(entrenadorasignadoDTO.getCliente().getId()).orElse(null));
        entrenadorAsignadoRepository.save(entrenadorasignado);
    }

    public void delete(EntrenadorasignadoIdDTO idDTO){
        EntrenadorasignadoId id = new EntrenadorasignadoId(){{
            setCliente(idDTO.getCliente());
            setEntrenador(idDTO.getEntrenador());
        }};
        entrenadorAsignadoRepository.deleteById(id);
    }

    public void deleteAll(List<EntrenadorasignadoIdDTO> list) {
        for (EntrenadorasignadoIdDTO e : list) delete(e);
    }

    public void saveAll(List<EntrenadorasignadoDTO> list) {
        for (EntrenadorasignadoDTO e : list) save(e);
    }
}
