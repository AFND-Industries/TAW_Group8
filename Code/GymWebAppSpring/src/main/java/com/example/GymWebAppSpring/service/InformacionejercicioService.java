package com.example.GymWebAppSpring.service;

import com.example.GymWebAppSpring.dao.EjercicioSesionRepository;
import com.example.GymWebAppSpring.dao.InformacionEjercicioRepository;
import com.example.GymWebAppSpring.dao.InformacionSesionRepository;
import com.example.GymWebAppSpring.dto.EjerciciosesionDTO;
import com.example.GymWebAppSpring.dto.InformacionejercicioDTO;
import com.example.GymWebAppSpring.entity.Ejerciciosesion;
import com.example.GymWebAppSpring.entity.Informacionejercicio;
import com.example.GymWebAppSpring.iu.FiltroRendimientoArgument;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class InformacionejercicioService extends DTOService<InformacionejercicioDTO, Informacionejercicio> {

    @Autowired
    private InformacionEjercicioRepository informacionejercicioRepository;

    @Autowired
    private EjercicioSesionRepository ejercicioSesionRepository;

    @Autowired
    private InformacionSesionRepository informacionSesionRepository;

    public List<InformacionejercicioDTO> findAll() {
        return entidadesADTO(informacionejercicioRepository.findAll());
    }

    public InformacionejercicioDTO findById(Integer id) {
        Informacionejercicio informacionejercicio = informacionejercicioRepository.findById(id).orElse(null);
        return informacionejercicio != null ? informacionejercicio.toDTO() : null;
    }

    public InformacionejercicioDTO findBySesionentrenamientoAndIndex(Integer sesionentrenamientoId, Integer index) {
        List<Informacionejercicio> informacionejercicios = informacionejercicioRepository.findBySesionentrenamiento(sesionentrenamientoId);
        if (informacionejercicios == null || index >= informacionejercicios.size() || index < 0) return null;
        return informacionejercicios.get(index) == null ? null : informacionejercicios.get(index).toDTO();
    }

    public InformacionejercicioDTO findByEjerciciosesionAndInformacionsesion(Integer ejerciciosesionId, Integer informacionsesionId) {
        Informacionejercicio informacionejercicio = informacionejercicioRepository.findByEjerciciosesionAndInformacionsesion(ejerciciosesionId, informacionsesionId);
        return informacionejercicio != null ? informacionejercicio.toDTO() : null;
    }

    public void save(InformacionejercicioDTO informacionejercicioDTO) {
        Informacionejercicio informacionejercicio;
        if (informacionejercicioDTO.getId() == null) {
            informacionejercicio = new Informacionejercicio();
        } else {
            informacionejercicio = informacionejercicioRepository.findById(informacionejercicioDTO.getId()).orElse(new Informacionejercicio());
        }
        informacionejercicio.setEvaluacion(informacionejercicioDTO.getEvaluacion());
        informacionejercicio.setEjerciciosesion(ejercicioSesionRepository.findById(informacionejercicioDTO.getEjerciciosesion().getId()).orElse(null));
        informacionejercicio.setInformacionsesion(informacionSesionRepository.findById(informacionejercicioDTO.getInformacionsesion().getId()).orElse(null));
        informacionejercicioRepository.save(informacionejercicio);
    }

    public void delete(InformacionejercicioDTO informacionejercicioDTO) {
        informacionejercicioRepository.deleteById(informacionejercicioDTO.getId());
    }

    public void deleteAll(List<InformacionejercicioDTO> informacionejercicioDTOList) {
        for (InformacionejercicioDTO informacionejercicioDTO : informacionejercicioDTOList) {
            informacionejercicioRepository.deleteById(informacionejercicioDTO.getId());
        }
    }

    public List<InformacionejercicioDTO> findBySesionentrenamiento(Integer sesionentrenamientoId) {
        return this.entidadesADTO(informacionejercicioRepository.findBySesionentrenamiento(sesionentrenamientoId));
    }

    public int getLastExerciseIndex(Integer sesionentrenamientoId) {
        List<Informacionejercicio> ejerciciosesion = this.informacionejercicioRepository.findBySesionentrenamiento(sesionentrenamientoId);
        return ejerciciosesion.size();
    }

    public List<InformacionejercicioDTO> filtrarEjercicios(FiltroRendimientoArgument filtro, Integer sesionentrenamientoId) {
        Gson gson = new Gson();
        String nombre = filtro.getNombre();
        Integer objetivosMode = filtro.getObjetivosMode();
        Integer objetivosNum = filtro.getIntegerObjetivosNum();
        Integer objetivosSuperadosMode = filtro.getObjetivosSuperadosMode();
        Integer objetivosSuperadosNum = filtro.getIntegerObjetivosSuperadosNum();
        Integer tipofuerza = filtro.getTipoEjercicio();

        int limiteBajoObj = (objetivosMode == 3 || objetivosMode == -1) ? 0 : objetivosNum;
        int limiteAltoObj = (objetivosMode == 2 || objetivosMode == -1) ? Integer.MAX_VALUE : objetivosNum;

        int limiteBajoRes = (objetivosSuperadosMode == 3 || objetivosSuperadosMode == -1) ? 0 : objetivosSuperadosNum;
        int limiteAltoRes = (objetivosSuperadosMode == 2 || objetivosSuperadosMode == -1) ? Integer.MAX_VALUE : objetivosSuperadosNum;

        List<Informacionejercicio> ejerciciosesion = this.informacionejercicioRepository.filter(sesionentrenamientoId,
                nombre, tipofuerza);
        List<Informacionejercicio> ejerciciosesionCopy = List.copyOf(ejerciciosesion);
        if (objetivosMode != -1) {
            for (Informacionejercicio info : ejerciciosesionCopy) {
                HashMap<String, String> especificaciones = gson.fromJson(info.getEjerciciosesion().getEspecificaciones(), HashMap.class);
                if (especificaciones.size() < limiteBajoObj || especificaciones.size() > limiteAltoObj) {
                    ejerciciosesion.remove(info);
                }
            }
        }
        ejerciciosesionCopy = List.copyOf(ejerciciosesion);
        if (objetivosSuperadosMode != -1) {
            for (Informacionejercicio info : ejerciciosesionCopy) {
                int cont = 0;
                HashMap<String, String> especificaciones = gson.fromJson(info.getEjerciciosesion().getEspecificaciones(), HashMap.class);
                HashMap<String, String> resultados = gson.fromJson(info.getEvaluacion(), HashMap.class);
                for (Map.Entry<String, String> objetivo : especificaciones.entrySet()) {
                    int obtenido = Integer.parseInt(resultados.get(objetivo.getKey()));
                    if (obtenido >= Integer.parseInt(objetivo.getValue())) {
                        cont++;
                    }
                }
                if (cont < limiteBajoRes || cont > limiteAltoRes) {
                    ejerciciosesion.remove(info);
                }
            }
        }


        return this.entidadesADTO(ejerciciosesion);
    }

}
