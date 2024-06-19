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

    public int saveOrCreateFullRutina(RutinaArgument rutina, UsuarioDTO entrenador) {
        // RUTINA
        // CREAR O MODIFICAR DATOS RUTINA
        Rutina r = rutinaRepository.findById(rutina.getId()).orElse(null);

        if (r == null) {
            r = new Rutina();

            r.setEntrenador(usuarioRepository.findById(entrenador.getId()).orElse(null));
            r.setFechaCreacion(LocalDate.now());
        }

        r.setNombre(rutina.getNombre());
        r.setDificultad(dificultadRepository.findById(rutina.getDificultad()).orElse(null)); // no va a ser null, pero habria que controlarlo
        r.setDescripcion(rutina.getDescripcion()); // problema description too long

        rutinaRepository.save(r);

        // SESION
        List<SesionArgument> sesiones = rutina.getSesiones();

        // ELIMINAR SESIONES
        List<Integer> sesionesId = new ArrayList<>();
        for (SesionArgument sesion : sesiones)
            sesionesId.add(sesion.getId());

        List<Sesionentrenamiento> sesionesRutina = sesionEntrenamientoRepository.findSesionesByRutina(r.getId());
        for (Sesionentrenamiento sesion : sesionesRutina) {
            if (!sesionesId.contains(sesion.getId())) {
                // SI LA SESION TENIA EJERCICIOS
                List<Ejerciciosesion> ejercicios = ejercicioSesionRepository.findEjerciciosBySesion(sesion.getId());
                ejercicioSesionRepository.deleteAll(ejercicios);

                sesionEntrenamientoRepository.delete(sesion);
            }
        }

        // CREAR O EDITAR SESIONES
        for (int i = 0; i < sesiones.size(); i++) {
            SesionArgument sesion = sesiones.get(i);
            Sesionentrenamiento s = sesionEntrenamientoRepository.findById(sesion.getId()).orElse(null);

            if (s == null) {
                s = new Sesionentrenamiento();

                s.setRutina(r);
            }

            s.setNombre(sesion.getNombre());
            s.setDia(Integer.parseInt(sesion.getDia()));
            s.setDescripcion(sesion.getDescripcion());

            sesionEntrenamientoRepository.save(s);

            // EJERCICIOS
            List<EjercicioArgument> ejercicios = sesion.getEjercicios();

            // ELIMINAR EJERCICIOS
            List<Integer> ejerciciosId = new ArrayList<>();
            for (EjercicioArgument ejercicio : ejercicios)
                ejerciciosId.add(ejercicio.getId());

            List<Ejerciciosesion> ejerciciossesion = ejercicioSesionRepository.findEjerciciosBySesion(s.getId());
            for (Ejerciciosesion ejerciciosesion : ejerciciossesion) {
                if (!ejerciciosId.contains(ejerciciosesion.getId()))
                    ejercicioSesionRepository.delete(ejerciciosesion);
            }

            // CREAR O EDITAR EJERCICIOS
            for (int j = 0; j < ejercicios.size(); j++) {
                EjercicioArgument ejercicio = ejercicios.get(j);
                Ejerciciosesion es = ejercicioSesionRepository.findById(ejercicio.getId()).orElse(null);

                if (es == null) {
                    es = new Ejerciciosesion();

                    es.setSesionentrenamiento(s);
                }

                es.setEjercicio(ejercicioRepository.findById(ejercicio.getEjercicio()).orElse(null));
                es.setEspecificaciones(new Gson().toJson(ejercicio.getEspecificaciones()));
                es.setOrden(j + 1);
                es.setSesionentrenamiento(s);

                ejercicioSesionRepository.save(es);
            }
        }

        return r.getId();
    }

    public void delete(Integer rutinaId) {
        this.rutinaRepository.deleteById(rutinaId);
    }
}
