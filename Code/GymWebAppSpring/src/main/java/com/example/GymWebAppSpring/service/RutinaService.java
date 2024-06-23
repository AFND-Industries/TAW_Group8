package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.*;
import com.example.GymWebAppSpring.dto.*;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.iu.EjercicioArgument;
import com.example.GymWebAppSpring.iu.FiltroArgument;
import com.example.GymWebAppSpring.iu.RutinaArgument;
import com.example.GymWebAppSpring.iu.SesionArgument;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class RutinaService extends DTOService<RutinaDTO, Rutina> {

    @Autowired
    protected RutinaRepository rutinaRepository;

    @Autowired
    protected DificultadRepository dificultadRepository;

    @Autowired
    protected UsuarioRepository usuarioRepository;

    @Autowired
    protected SesionEntrenamientoRepository sesionEntrenamientoRepository;

    @Autowired
    protected EjercicioSesionRepository ejercicioSesionRepository;

    @Autowired
    protected EjercicioRepository ejercicioRepository;

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

    public List<RutinaDTO> findRutinaByUsuarioID(Integer usuarioId) {
        List<Rutina> lista = this.rutinaRepository.findRutinaByUsuarioID(usuarioId);
        return this.entidadesADTO(lista);
    }

    public List<RutinaDTO> findRutinaByUsuarioIDandEntrenadorID(Integer usuarioId, Integer entrenadorId) {
        List<Rutina> lista = this.rutinaRepository.findRutinaByUsuarioIDandEntrenadorID(usuarioId, entrenadorId);
        return this.entidadesADTO(lista);
    }

    public RutinaDTO findById(Integer rutinaId) {
        Rutina rutina = this.rutinaRepository.findById(rutinaId).orElse(null);
        return rutina == null ? null : rutina.toDTO();
    }

    public void save(RutinaDTO rutinaDTO) {
        int rutinaId = rutinaDTO.getId() == null ? -1 : rutinaDTO.getId();
        Rutina rutina = this.rutinaRepository.findById(rutinaId).orElse(new Rutina());
        rutina.setDificultad(this.dificultadRepository.findById(rutinaDTO.getDificultad().getId()).orElse(null));
        rutina.setDescripcion(rutinaDTO.getDescripcion());
        rutina.setNombre(rutinaDTO.getNombre());
        rutina.setEntrenador(this.usuarioRepository.findById(rutinaDTO.getEntrenador().getId()).orElse(null));
        rutina.setFechaCreacion(rutinaDTO.getFechaCreacion());
        this.rutinaRepository.save(rutina);
    }

    public List<RutinaDTO> filtrarRutinas(FiltroArgument filtro, Integer entrenadorId) {
        String nombre = filtro.getNombre();
        Integer sesionNum = filtro.getIntegerSesionNum();
        Integer sesionMode = filtro.getSesionMode();
        Integer dificultadId = filtro.getDificultad() == -1 ? null : filtro.getDificultad();

        Integer limiteBajo = (sesionMode == 3 || sesionMode == -1) ? 0 : sesionNum;
        Integer limiteAlto = (sesionMode == 2 || sesionMode == -1) ? 7 : sesionNum;

        return this.findRutinaByEntrenadorWithFilter(
                entrenadorId, nombre, limiteBajo, limiteAlto, dificultadId);
    }

    public void updateRutina(RutinaArgument rutinaArgument, UsuarioDTO entrenadorDTO) {
        Rutina rutina = rutinaRepository.findById(rutinaArgument.getId())
                .orElse(null);

        if (rutina == null) {
            rutina = new Rutina();
            rutina.setEntrenador(usuarioRepository.findById(entrenadorDTO.getId()).orElse(null));
            rutina.setFechaCreacion(LocalDate.now());
        }

        rutina.setNombre(rutinaArgument.getNombre());
        rutina.setDificultad(dificultadRepository.findById(rutinaArgument.getDificultad()).orElse(null));
        rutina.setDescripcion(rutinaArgument.getDescripcion());

        rutinaRepository.save(rutina);

        updateSesiones(rutinaArgument.getSesiones(), rutina);
    }

    private void updateSesiones(List<SesionArgument> sesionesArgument, Rutina rutina) {
        List<Integer> sesionesId = sesionesArgument.stream()
                .map(SesionArgument::getId)
                .toList();

        List<Sesionentrenamiento> sesionesRutina = sesionEntrenamientoRepository.findSesionesByRutina(rutina.getId());
        for (Sesionentrenamiento sesion : sesionesRutina) {
            if (!sesionesId.contains(sesion.getId())) {
                List<Ejerciciosesion> ejercicios = ejercicioSesionRepository.findEjerciciosBySesion(sesion.getId());
                ejercicioSesionRepository.deleteAll(ejercicios);
                sesionEntrenamientoRepository.delete(sesion);
            }
        }

        for (SesionArgument sesionArgument : sesionesArgument)
            updateSesion(sesionArgument, sesionesRutina, rutina);
    }

    private void updateSesion(SesionArgument sesionArgument, List<Sesionentrenamiento> sesionesRutina, Rutina rutina) {
        Sesionentrenamiento sesion = sesionesRutina.stream()
                .filter(e -> Objects.equals(e.getId(), sesionArgument.getId()))
                .findFirst()
                .orElse(null);

        if (sesion == null) {
            sesion = new Sesionentrenamiento();
            sesion.setRutina(rutina);
        }

        sesion.setNombre(sesionArgument.getNombre());
        sesion.setDia(Integer.parseInt(sesionArgument.getDia()));
        sesion.setDescripcion(sesionArgument.getDescripcion());

        sesionEntrenamientoRepository.save(sesion);

        updateExercises(sesionArgument.getEjercicios(), sesion);
    }

    private void updateExercises(List<EjercicioArgument> ejercicios, Sesionentrenamiento sesion) {
        List<Integer> ejerciciosId = ejercicios.stream()
                .map(EjercicioArgument::getId)
                .toList();

        List<Ejerciciosesion> ejerciciosSesion = ejercicioSesionRepository.findEjerciciosBySesion(sesion.getId());
        for (Ejerciciosesion ejercicioSesion : ejerciciosSesion) {
            if (!ejerciciosId.contains(ejercicioSesion.getId())) {
                ejercicioSesionRepository.delete(ejercicioSesion);
            }
        }

        for (EjercicioArgument ejercicioArgument : ejercicios)
            updateExercise(ejercicioArgument, ejerciciosSesion, sesion);
    }

    private void updateExercise(EjercicioArgument ejercicioArgument, List<Ejerciciosesion> ejerciciosSesion, Sesionentrenamiento sesion) {
        Ejerciciosesion ejercicioSesion = ejerciciosSesion.stream()
                .filter(e -> Objects.equals(e.getId(), ejercicioArgument.getId()))
                .findFirst()
                .orElse(null);

        if (ejercicioSesion == null) {
            ejercicioSesion = new Ejerciciosesion();
            ejercicioSesion.setSesionentrenamiento(sesion);
        }

        ejercicioSesion.setEjercicio(ejercicioRepository.findById(ejercicioArgument.getEjercicio()).orElse(null));
        ejercicioSesion.setEspecificaciones(new Gson().toJson(ejercicioArgument.getEspecificaciones()));
        ejercicioSesion.setOrden(ejercicioArgument.getOrden());

        ejercicioSesionRepository.save(ejercicioSesion);
    }

    public void delete(Integer rutinaId) {
        this.rutinaRepository.deleteById(rutinaId);
    }
}
