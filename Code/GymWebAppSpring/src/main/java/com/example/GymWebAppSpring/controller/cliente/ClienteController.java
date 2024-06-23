package com.example.GymWebAppSpring.controller.cliente;

import com.example.GymWebAppSpring.dto.*;
import com.example.GymWebAppSpring.iu.FiltroRendimientoArgument;
import com.example.GymWebAppSpring.service.*;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.lang3.tuple.Triple;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping("/client")
public class ClienteController {

    @Autowired
    protected InformacionejercicioService informacionejercicioService;
    @Autowired
    protected InformacionsesionService informacionsesionService;
    @Autowired
    protected RutinaclienteService rutinaclienteService;
    @Autowired
    protected EjerciciosesionService ejerciciosesionService;
    @Autowired
    protected SesionEntrenamientoService sesionEntrenamientoService;
    @Autowired
    protected TipoFuerzaService tipoFuerzaService;


    @GetMapping("")
    public String doVerClientSspace(HttpSession sesion, Model modelo) {

        UsuarioDTO user = (UsuarioDTO) sesion.getAttribute("user");

        List<RutinaclienteDTO> rutinas = rutinaclienteService.findByUsuario(user.getId());

        modelo.addAttribute("usuario", user);
        modelo.addAttribute("rutinas", rutinas);

        return "client/clientePersonalSpace";
    }

    @GetMapping("/rutina")
    public String doVerRutina(@RequestParam("rutinaElegida") Integer rutinaId,
                              HttpSession session, Model modelo) {

        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        RutinaDTO rutina = rutinaclienteService.findById(rutinaId, user.getId()).getRutina();

        List<Triple<SesionentrenamientoDTO, Integer, Integer>> listaSesionesEjerciciosInfo = new ArrayList<>();
        List<SesionentrenamientoDTO> sesionesEntrenamiento = sesionEntrenamientoService.findByRutina(rutina.getId());

        for (SesionentrenamientoDTO sesion : sesionesEntrenamiento) {
            List<EjerciciosesionDTO> ejercicos = ejerciciosesionService.findBySesion(sesion.getId());
            List<InformacionejercicioDTO> informacionEjercicios = informacionejercicioService.findBySesionentrenamiento(sesion.getId());
            int numEjercicios = ejercicos.size();
            int numEjerciciosCompletados = informacionEjercicios.size();

            listaSesionesEjerciciosInfo.add(Triple.of(sesion, numEjercicios, numEjerciciosCompletados));
        }
        modelo.addAttribute("rutina", rutina);
        modelo.addAttribute("sesionesEjercicios", listaSesionesEjerciciosInfo);

        return "client/verRutina";
    }

    @GetMapping("rutina/sesion/ejercicio")
    public String doVerEjercicio(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                 @RequestParam(value = "ejercicioIndex", required = false, defaultValue = "0") Integer ejercicioIndex,
                                 Model modelo) {

        ejercicioIndex = Math.max(ejercicioIndex, 0);

        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        if (sesionEntrenamiento == null)
            return "redirect:/client";

        List<EjerciciosesionDTO> ejercicios = ejerciciosesionService.findBySesion(sesionEntrenamiento.getId());

        int numEjercicios = ejercicios.size();

        if (ejercicioIndex >= numEjercicios) {
            // Ya ha acabado los ejercicios, por lo que hay que valorarlos
            return "redirect:/client/rutina/sesion/valorarEntrenamiento?sesionEntrenamiento=" + sesionEntrenamiento.getId();
        }

        if (ejercicioIndex == 0) {
            // Obtenemos el índice del siguiente ejercicio al último evaluado
            ejercicioIndex = informacionejercicioService.getLastExerciseIndex(sesionEntrenamiento.getId());
        }

        EjerciciosesionDTO ejercicioSesion = ejerciciosesionService.findBySesionAndIndexOrdered(sesionEntrenamiento.getId(), ejercicioIndex);
        if (ejercicioSesion == null) {
            return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();
        }

        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        modelo.addAttribute("ejercicioSesion", ejercicioSesion);
        modelo.addAttribute("ejercicioIndex", ejercicioIndex);

        return "client/verEjercicio";
    }

    @PostMapping("rutina/sesion/ejercicio/guardar")
    public String doGuardarEjercicio(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                     @RequestParam("resultados") String resultados,
                                     @RequestParam("ejercicioIndex") Integer ejercicioIndex,
                                     HttpSession session) {

        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());

        if (informacionSesion == null) { //Crear la sesionInfo si no existe
            informacionSesion = new InformacionsesionDTO();
            informacionSesion.setComentario("NaN");
            informacionSesion.setValoracion(0);
            informacionSesion.setSesionentrenamiento(sesionEntrenamiento);
            informacionSesion.setUsuario(user);
            informacionsesionService.save(informacionSesion);
        }

        InformacionejercicioDTO informacionEjercicio = informacionejercicioService.findBySesionentrenamientoAndIndex(sesionEntrenamiento.getId(), ejercicioIndex);
        if (informacionEjercicio == null) {
            informacionEjercicio = new InformacionejercicioDTO();
            informacionEjercicio.setEjerciciosesion(ejerciciosesionService.findBySesionOrdered(sesionEntrenamiento.getId()).get(ejercicioIndex));
            informacionEjercicio.setInformacionsesion(informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId()));
        }
        informacionEjercicio.setEvaluacion(resultados);
        informacionejercicioService.save(informacionEjercicio);

        return "redirect:/client/rutina/sesion/ejercicio?sesionEntrenamiento=" + sesionEntrenamiento.getId() + "&ejercicioIndex=" + (ejercicioIndex + 1);
    }

    @PostMapping("rutina/sesion/ejercicio/modificar")
    public String doModificarEjercicio(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                       @RequestParam("resultados") String resultados,
                                       @RequestParam("ejercicioSesion") Integer ejerciciosesionId,
                                       HttpSession session) {

        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        EjerciciosesionDTO ejerciciosesion = ejerciciosesionService.findById(ejerciciosesionId);

        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamientoId);
        InformacionejercicioDTO informacionEjercicio = informacionejercicioService.findByEjerciciosesionAndInformacionsesion(ejerciciosesion.getId(), informacionSesion.getId());

        informacionEjercicio.setEvaluacion(resultados);
        informacionejercicioService.save(informacionEjercicio);

        return "redirect:/client/rutina/sesion/desempenyo?sesionEntrenamiento=" + sesionEntrenamientoId;


    }

    @GetMapping("rutina/sesion/valorarEntrenamiento")
    public String doValorarEntrenamiento(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                         @RequestParam(value = "informacionSesion", required = false) Integer informacionSesionModifId,
                                         HttpSession session, Model modelo) {

        InformacionsesionDTO informacionSesion;
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);

        if (informacionSesionModifId != null) {
            informacionSesion = informacionsesionService.findById(informacionSesionModifId);
        } else {
            informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());
        }

        if (informacionSesion == null)
            return "redirect:/client";

        modelo.addAttribute("informacionSesion", informacionSesion);
        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);

        return "client/verValorarSesion";
    }

    @PostMapping("rutina/sesion/valorarEntrenamiento/guardar")
    public String doGuardarValoracionSesion(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                            @RequestParam("comentario") String comentario,
                                            @RequestParam("rating") String rating,
                                            HttpSession session) {

        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());

        if (informacionSesion == null)
            return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();

        informacionSesion.setComentario(comentario);
        informacionSesion.setValoracion(Integer.parseInt(rating));
        informacionSesion.setFechaFin(LocalDate.now());
        informacionsesionService.save(informacionSesion);


        return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();
    }

    @GetMapping("/rutina/sesion/desempenyo")
    public String mostrarDesempenyo(
            @RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
            HttpSession session,
            Model modelo) {

        // Obtener usuario autenticado
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("user");

        // Buscar sesión de entrenamiento por ID
        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        if (sesionEntrenamiento == null) {
            return "redirect:/client";
        }

        // Buscar información de sesión para el usuario y la sesión de entrenamiento
        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(usuario.getId(), sesionEntrenamiento.getId());
        if (informacionSesion == null) {
            return "redirect:/client";
        }

        // Obtener tipos de fuerza disponibles para el filtro
        List<TipofuerzaDTO> tiposFuerza = tipoFuerzaService.findAll();

        // Obtener ejercicios de la sesión y su información asociada
        Map<EjerciciosesionDTO, InformacionejercicioDTO> ejercicios = new LinkedHashMap<>();
        List<EjerciciosesionDTO> ejerciciosSesion = ejerciciosesionService.findBySesionOrdered(sesionEntrenamiento.getId());
        for (EjerciciosesionDTO ejercicio : ejerciciosSesion) {
            InformacionejercicioDTO informacionEjercicio = informacionejercicioService.findByEjerciciosesionAndInformacionsesion(ejercicio.getId(), informacionSesion.getId());
            ejercicios.put(ejercicio, informacionEjercicio);
        }

        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        modelo.addAttribute("informacionSesion", informacionSesion);
        modelo.addAttribute("tiposFuerza", tiposFuerza);
        modelo.addAttribute("ejercicios", ejercicios);
        modelo.addAttribute("filtro", new FiltroRendimientoArgument());

        return "client/verDesempenyo";
    }

    @PostMapping("/rutina/sesion/desempenyo/borrar")
    public String doBorrarDesempenyo(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                     HttpSession session) {

        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("user");

        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        if (sesionEntrenamiento == null)
            return "redirect:/client";

        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(usuario.getId(), sesionEntrenamiento.getId());
        if (informacionSesion == null)
            return "redirect:/client";

        List<InformacionejercicioDTO> informacionEjercicios = informacionejercicioService.findBySesionentrenamiento(sesionEntrenamiento.getId());
        if (informacionEjercicios != null)
            informacionejercicioService.deleteAll(informacionEjercicios);

        informacionsesionService.delete(informacionSesion);


        return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();
    }

    @GetMapping("/rutina/sesion/desempenyo/fitrar")
    public String doFiltar(@ModelAttribute("filtro") FiltroRendimientoArgument filtro,
                           Model model, HttpSession session) {

        if (filtro.getObjetivosMode() == -1 || filtro.getIntegerObjetivosNum() == -1) {
            filtro.setObjetivosMode(-1);
            filtro.setObejetivosNum("");
        }

        if (filtro.getObjetivosSuperadosMode() == -1 || filtro.getIntegerObjetivosSuperadosNum() == -1) {
            filtro.setObjetivosSuperadosMode(-1);
            filtro.setObjetivosSuperadosNum("");
        }

        if (filtro.estaVacio()) {
            return "redirect:/client/rutina/sesion/desempenyo?sesionEntrenamiento=" + filtro.getSesionEntrenamientoId();
        }

        int sesionentrenamientoId = filtro.getSesionEntrenamientoId();

        Map<EjerciciosesionDTO, InformacionejercicioDTO> ejercicios = new LinkedHashMap<>();
        List<InformacionejercicioDTO> informacionejercicios = informacionejercicioService.filtrarEjercicios(filtro, sesionentrenamientoId);
        for (InformacionejercicioDTO ie : informacionejercicios) {
            ejercicios.put(ie.getEjerciciosesion(), ie);
        }

        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("user");

        model.addAttribute("informacionSesion", informacionsesionService.findByUsuarioAndSesion(usuario.getId(), sesionentrenamientoId));
        model.addAttribute("tiposFuerza", tipoFuerzaService.findAll());
        model.addAttribute("sesionEntrenamiento", sesionEntrenamientoService.findById(sesionentrenamientoId));
        model.addAttribute("ejercicios", ejercicios);

        return "client/verDesempenyo";
    }
}
