package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dto.*;
import com.example.GymWebAppSpring.iu.FiltroArgument;
import com.example.GymWebAppSpring.iu.FiltroRendimientoArgument;
import com.example.GymWebAppSpring.service.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.google.gson.Gson;
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
    public String doClient(HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        UsuarioDTO user = (UsuarioDTO) sesion.getAttribute("user");
        List<RutinaclienteDTO> rutinas = rutinaclienteService.findByUsuario(user.getId());
        modelo.addAttribute("usuario", user);
        modelo.addAttribute("rutinas", rutinas);
        return "client/clientePersonalSpace";


    }

    @GetMapping("/rutina")
    public String doVerRutina(@RequestParam("rutinaElegida") Integer rutinaId, HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        RutinaDTO rutina = rutinaclienteService.findById(rutinaId, user.getId()).getRutina();
        List<Triple<SesionentrenamientoDTO, Integer, Integer>> sesionesEjercicios = new ArrayList<>();
        List<SesionentrenamientoDTO> sesionesEntrenamiento = sesionEntrenamientoService.findByRutina(rutina.getId());


        for (SesionentrenamientoDTO sesion : sesionesEntrenamiento) {
            List<EjerciciosesionDTO> ejercicos = ejerciciosesionService.findBySesion(sesion.getId());
            List<InformacionejercicioDTO> informacionEjercicios = informacionejercicioService.findBySesionentrenamiento(sesion.getId());
            int numEjercicios = ejercicos.size();
            int numEjerciciosCompletados = informacionEjercicios.size();
            sesionesEjercicios.add(Triple.of(sesion, numEjercicios, numEjerciciosCompletados));
        }
        modelo.addAttribute("rutina", rutina);
        modelo.addAttribute("sesionesEjercicios", sesionesEjercicios);


        return "client/verRutina";


    }

    @GetMapping("rutina/sesion/ejercicio")
    public String doVerEjercicio(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                 @RequestParam(value = "ejercicioIndex", required = false, defaultValue = "0") Integer ejercicioIndex,
                                 HttpSession session, Model modelo) {

        if (!AuthUtils.isClient(session))
            return "redirect:/";

        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        ejercicioIndex = (ejercicioIndex < 0) ? 0 : ejercicioIndex;

        List<EjerciciosesionDTO> ejercicios = ejerciciosesionService.findBySesion(sesionEntrenamiento.getId());

        if (ejercicioIndex >= ejercicios.size()) //Ya ha acabado los ejercicos por lo que hay que valorarlos
            return "redirect:/client/rutina/sesion/valorarEntrenamiento?sesionEntrenamiento=" + sesionEntrenamiento.getId();

        if (ejercicioIndex == 0) { //Comprobar si ya ha hecho algun ejercicio
            List<InformacionejercicioDTO> informacionEjercicios = informacionejercicioService.findBySesionentrenamiento(sesionEntrenamiento.getId());
            if (informacionEjercicios != null && !informacionEjercicios.isEmpty()) {
                int lastExer = informacionEjercicios.indexOf(informacionEjercicios.getFirst());
                ejercicioIndex = lastExer + 1;
            }
        }
        Gson gson = new Gson();
        EjerciciosesionDTO ejercicioSesion = ejercicios.get(ejercicioIndex);
        HashMap<String, String> especificaciones = gson.fromJson(ejercicioSesion.getEspecificaciones(), HashMap.class);


        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        modelo.addAttribute("ejercicioSesion", ejercicios.get(ejercicioIndex));
        modelo.addAttribute("ejercicioIndex", ejercicioIndex);

        return "client/verEjercicio";
    }

    @PostMapping("rutina/sesion/ejercicio/guardar")
    public String doGuardarEjercicio(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                     @RequestParam("resultados") String resultados,
                                     @RequestParam("ejercicioIndex") Integer ejercicioIndex,
                                     HttpSession session) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");

        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());
        if (informacionSesion == null) {
            informacionSesion = new InformacionsesionDTO();
            informacionSesion.setComentario("NaN");
            informacionSesion.setValoracion(0);
            informacionSesion.setSesionentrenamiento(sesionEntrenamiento);
            informacionSesion.setUsuario(user);
            informacionsesionService.save(informacionSesion);
        }
        List<InformacionejercicioDTO> informacionEjercicioLista = informacionejercicioService.findBySesionentrenamiento(sesionEntrenamiento.getId());
        InformacionejercicioDTO informacionEjercicio;
        if (informacionEjercicioLista.size() <= ejercicioIndex) {
            informacionEjercicio = new InformacionejercicioDTO();
            informacionEjercicio.setEjerciciosesion(ejerciciosesionService.findBySesion(sesionEntrenamiento.getId()).get(ejercicioIndex));
            informacionEjercicio.setInformacionsesion(informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId()));
        } else {
            informacionEjercicio = informacionEjercicioLista.get(ejercicioIndex);
        }
        informacionEjercicio.setEvaluacion(resultados);
        informacionejercicioService.save(informacionEjercicio);


        return "redirect:/client/rutina/sesion/ejercicio?sesionEntrenamiento=" + sesionEntrenamiento.getId() + "&ejercicioIndex=" + (ejercicioIndex + 1);


    }

    @PostMapping("rutina/sesion/ejercicio/modificar")
    public String doModificarEjercicio(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                       @RequestParam("resultados") String resultados,
                                       @RequestParam(value = "ejercicioSesion") Integer ejerciciosesionId,
                                       HttpSession session) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        EjerciciosesionDTO ejerciciosesion = ejerciciosesionService.findById(ejerciciosesionId);

        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());
        InformacionejercicioDTO informacionEjercicio = informacionejercicioService.findByEjerciciosesionAndInformacionsesion(ejerciciosesion.getId(), informacionSesion.getId());
        informacionEjercicio.setEvaluacion(resultados);
        informacionejercicioService.save(informacionEjercicio);
        return "redirect:/client/rutina/sesion/desempenyo?sesionEntrenamiento=" + sesionEntrenamiento.getId();


    }


    @GetMapping("rutina/sesion/valorarEntrenamiento")
    public String doValorarEntrenamiento(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                         @RequestParam(value = "informacionSesion", required = false) Integer informacionSesionModifId,
                                         HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";
        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        InformacionsesionDTO informacionSesionModif = informacionSesionModifId != null ? informacionsesionService.findById(informacionSesionModifId) : null;

        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        InformacionsesionDTO informacionSesion;
        if (informacionSesionModif == null) {
            informacionSesion = informacionsesionService.findByUsuarioAndSesion(user.getId(), sesionEntrenamiento.getId());
        } else {
            informacionSesion = informacionSesionModif;
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
        if (!AuthUtils.isClient(session))
            return "redirect:/";
        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
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
    public String doDesempenyo(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                               HttpSession session, Model modelo) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";

        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("user");
        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(usuario.getId(), sesionEntrenamiento.getId());
        if (informacionSesion == null)
            return "redirect:/client";
        List<TipofuerzaDTO> tiposFuerza = tipoFuerzaService.findAll();

        modelo.addAttribute("tiposFuerza", tiposFuerza);
        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        modelo.addAttribute("informacionSesion", informacionSesion);
        modelo.addAttribute("filtro", new FiltroRendimientoArgument());


        HashMap<EjerciciosesionDTO, InformacionejercicioDTO> ejercicios = new HashMap<>();
        List<EjerciciosesionDTO> ejerciciosSesion = ejerciciosesionService.findBySesion(sesionEntrenamiento.getId());
        for (EjerciciosesionDTO e : ejerciciosSesion) {
            InformacionejercicioDTO informacionEjercicio = informacionejercicioService.findByEjerciciosesionAndInformacionsesion(e.getId(), informacionSesion.getId());
            ejercicios.put(e, informacionEjercicio);
        }
        modelo.addAttribute("ejercicios", ejercicios);
        return "client/verDesempenyo";
    }

    @PostMapping("/rutina/sesion/desempenyo/borrar")
    public String doBorrarDesempenyo(@RequestParam("sesionEntrenamiento") Integer sesionEntrenamientoId,
                                     HttpSession session) {
        if (!AuthUtils.isClient(session))
            return "redirect:/";
        SesionentrenamientoDTO sesionEntrenamiento = sesionEntrenamientoService.findById(sesionEntrenamientoId);

        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("user");
        InformacionsesionDTO informacionSesion = informacionsesionService.findByUsuarioAndSesion(usuario.getId(), sesionEntrenamiento.getId());
        List<InformacionejercicioDTO> informacionEjercicios = informacionejercicioService.findBySesionentrenamiento(sesionEntrenamiento.getId());
        if (informacionSesion == null)
            return "redirect:/client";
        informacionejercicioService.deleteAll(informacionEjercicios);
        informacionsesionService.delete(informacionSesion);


        return "redirect:/client/rutina?rutinaElegida=" + sesionEntrenamiento.getRutina().getId();
    }

    @GetMapping("/rutina/sesion/desempenyo/fitrar")
    public String doFiltar(@ModelAttribute("filtro") FiltroRendimientoArgument filtro,
                           Model model, HttpSession session) {
        if(!AuthUtils.isClient(session))
            return "redirect:/";

        if(filtro.getObjetivosMode() == -1 || filtro.getIntegerObjetivosNum() == -1){
            filtro.setObjetivosMode(-1);
            filtro.setObejetivosNum("");
        }

        if(filtro.getObjetivosSuperadosMode() == -1 || filtro.getIntegerObjetivosSuperadosNum() == -1){
            filtro.setObjetivosSuperadosMode(-1);
            filtro.setObjetivosSuperadosNum("");
        }

        if(filtro.estaVacio()){
            return "redirect:/client";
        }
        Integer sesionentrenamientoId = filtro.getSesionEntrenamientoId();
        HashMap<EjerciciosesionDTO, InformacionejercicioDTO> ejercicios = new HashMap<>();
        List<InformacionejercicioDTO> informacionejercicios = informacionejercicioService.filtrarEjercicios(filtro, sesionentrenamientoId);
        for(InformacionejercicioDTO ie : informacionejercicios){
            ejercicios.put(ie.getEjerciciosesion(), ie);
        }
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("user");
        model.addAttribute("informacionSesion",informacionsesionService.findByUsuarioAndSesion(usuario.getId(), sesionentrenamientoId));
        model.addAttribute("tiposFuerza", tipoFuerzaService.findAll());
        model.addAttribute("sesionEntrenamiento", sesionEntrenamientoService.findById(sesionentrenamientoId));
        model.addAttribute("ejercicios", ejercicios);
        return  "client/verDesempenyo";
    }


//    public String doFiltrar(@ModelAttribute("filtro") FiltroArgument filtro,
//                            Model model, HttpSession session) {
//        if (!AuthUtils.isTrainer(session)) {
//            return "redirect:/";
//        }
//
//        // Si se ignora uno de los dos campos, el otro también, pues van de la mano
//        if (filtro.getIntegerSesionNum() == -1 || filtro.getSesionMode() == -1) {
//            filtro.setSesionMode(-1);
//            filtro.setSesionNum("");
//        }
//
//        if (filtro.estaVacio()) {
//            return "redirect:/entrenador/rutinas";
//        }
//
//        UsuarioDTO entrenador = AuthUtils.getUser(session);
//        List<RutinaDTO> rutinas = rutinaService.filtrarRutinas(filtro, entrenador.getId());
//
//        model.addAttribute("rutinas", rutinas);
//        model.addAttribute("dificultades", dificultadService.findAll());
//        model.addAttribute("filtro", filtro);
//
//        return "/entrenador/crud/rutinas";
//    }


}
