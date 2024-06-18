package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.TipoUsuarioRepository;
import com.example.GymWebAppSpring.dto.TipousuarioDTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.entity.Tipousuario;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TipoUsuarioService extends DTOService<TipousuarioDTO, Tipousuario> {

    @Autowired
    private TipoUsuarioRepository tipoUsuarioRepository;

    public List<TipousuarioDTO> findAll(){
        return entidadesADTO(tipoUsuarioRepository.findAll());
    }

    public TipousuarioDTO findById(Integer id){
        Tipousuario tipousuario = tipoUsuarioRepository.findById(id == null ? -1 : id).orElse(null);
        return tipousuario != null ? tipousuario.toDTO() : null;
    }

    public TipousuarioDTO findByName(String name){
        Tipousuario tipousuario = tipoUsuarioRepository.findByName(name);
        return tipousuario != null ? tipousuario.toDTO() : null;
    }

    public void save(TipousuarioDTO tipousuarioDTO){
        Integer id = tipousuarioDTO.getId();
        Tipousuario tipousuario = tipoUsuarioRepository.findById(id == null ? -1 : id).orElse(new Tipousuario());
        tipousuario.setNombre(tipousuarioDTO.getNombre());
        tipoUsuarioRepository.save(tipousuario);
    }

    public void delete(Integer id){
        tipoUsuarioRepository.deleteById(id);
    }
}
