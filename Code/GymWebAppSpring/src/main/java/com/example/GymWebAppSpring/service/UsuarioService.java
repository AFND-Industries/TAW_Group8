package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.TipoUsuarioRepository;
import com.example.GymWebAppSpring.dao.UsuarioRepository;
import com.example.GymWebAppSpring.dto.TipousuarioDTO;
import com.example.GymWebAppSpring.dto.UsuarioDTO;
import com.example.GymWebAppSpring.entity.Tipousuario;
import com.example.GymWebAppSpring.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UsuarioService extends DTOService<UsuarioDTO, Usuario>{

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private TipoUsuarioRepository tipoUsuarioRepository;

    public List<UsuarioDTO> findAll(){
        return entidadesADTO(usuarioRepository.findAll());
    }

    public List<UsuarioDTO> findUsuarioByTipoUsuario(TipousuarioDTO tipousuarioDTO){
        return entidadesADTO(usuarioRepository.findUsuarioByTipoUsuario(tipousuarioDTO.getId()));
    }

    public List<UsuarioDTO> findUsuarioByDNI(String dni){
        return entidadesADTO(usuarioRepository.findUsuarioByDNI(dni));
    }

    public List<UsuarioDTO> findUsuarioByApellidos(String apellidos){
        return entidadesADTO(usuarioRepository.findUsuarioByApellidos(apellidos));
    }

    public List<UsuarioDTO> findUsuarioByEdad(Integer edad){
        return entidadesADTO(usuarioRepository.findUsuarioByEdad(edad));
    }

    public UsuarioDTO findById(Integer id){
        Usuario usuario = usuarioRepository.findById(id).orElse(null);
        return usuario != null ? usuario.toDTO() : null;
    }

    public UsuarioDTO findUsuarioByDniAndClave(String dni, String clave){
        Usuario usuario = usuarioRepository.findUsuarioByDniAndClave(dni, clave);
        return usuario != null ? usuario.toDTO() : null;
    }

    public void save(UsuarioDTO usuarioDTO){
        Integer id = usuarioDTO.getId();
        Usuario usuario = usuarioRepository.findById(id == null ? -1 : id).orElse(new Usuario());
        Tipousuario tipousuario = tipoUsuarioRepository.findById(usuarioDTO.getTipo().getId()).orElse(null);
        usuario.setNombre(usuarioDTO.getNombre());
        usuario.setApellidos(usuarioDTO.getApellidos());
        usuario.setEdad(usuarioDTO.getEdad());
        usuario.setClave(usuarioDTO.getClave());
        usuario.setTipo(tipousuario);
        usuario.setGenero(usuarioDTO.getGenero());
        usuario.setDni(usuarioDTO.getDni());
        usuarioRepository.save(usuario);
    }

    public void delete(Integer id){
        usuarioRepository.deleteById(id);
    }

}
