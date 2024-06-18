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
        Categoria categoria = categoriaRepository.findById(id == null ? -1 : id).orElse(null);
        return categoria != null ? categoria.toDTO() : null;
    }

    public List<CategoriaDTO> findByNombre(String nombre){
        return entidadesADTO(categoriaRepository.findByNombre(nombre));
    }

    public void save(CategoriaDTO categoriaDTO){
        Integer id = categoriaDTO.getId();
        Categoria categoria = categoriaRepository.findById(id == null ? -1 : id).orElse(new Categoria());
        categoria.setTiposBase(categoriaDTO.getTiposBase());
        categoria.setDescripcion(categoriaDTO.getDescripcion());
        categoria.setNombre(categoriaDTO.getNombre());
        categoria.setIcono(categoriaDTO.getIcono());
        categoriaRepository.save(categoria);
    }

    public void delete(Integer id){
        categoriaRepository.deleteById(id);
    }

}
