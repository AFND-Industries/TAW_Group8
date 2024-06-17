package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.CategoriaRepository;
import com.example.GymWebAppSpring.dto.CategoriaDTO;
import com.example.GymWebAppSpring.entity.Categoria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoriaService extends DTOService<CategoriaDTO, Categoria>{

    @Autowired
    private CategoriaRepository categoriaRepository;

    public List<CategoriaDTO> findAll(){
        return entidadesADTO(categoriaRepository.findAll());
    }

    public CategoriaDTO findById(Integer id){
        Categoria categoria = categoriaRepository.findById(id).orElse(null);
        return categoria != null ? categoria.toDTO() : null;
    }

    public void save(CategoriaDTO categoriaDTO){
        Categoria categoria = categoriaRepository.findById(categoriaDTO.getId()).orElse(new Categoria());
        categoria.setTiposBase(categoriaDTO.getTiposBase());
        categoria.setDescripcion(categoriaDTO.getDescripcion());
        categoria.setNombre(categoriaDTO.getNombre());
        categoria.setIcono(categoriaDTO.getIcono());
        categoriaRepository.save(categoria);
    }

    public void delete(CategoriaDTO categoriaDTO){
        categoriaRepository.deleteById(categoriaDTO.getId());
    }

}
