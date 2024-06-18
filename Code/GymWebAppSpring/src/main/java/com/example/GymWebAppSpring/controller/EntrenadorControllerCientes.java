package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dto.*;
import com.example.GymWebAppSpring.iu.FiltroArgument;
import com.example.GymWebAppSpring.service.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/entrenador/clientes")
public class EntrenadorControllerCientes {


    @Autowired
    private EntrenadorAsignadoService entrenadorAsignadoService;


    @Autowired
    private RutinaclienteService rutinaClienteService;

    @Autowired
    private RutinaService rutinaService;

    @Autowired
    private EjerciciosesionService ejercicioSesionService;


    @Autowired
    private InformacionsesionService informacionSesionService;

    @Autowired
    private InformacionejercicioService informacionEjercicioService;

    @Autowired
    private SesionEntrenamientoService sesionentrenamientoService;

    @Autowired
    private DificultadService dificultadService;

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("")
    public String entrenadorClientes(Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        if (session.getAttribute("cliente") != null)
            session.removeAttribute("cliente");

        UsuarioDTO usuario = AuthUtils.getUser(session);

        List<UsuarioDTO> clientesAsignados = entrenadorAsignadoService.findClientsByEntrenadorID(usuario);
        model.addAttribute("clientes", clientesAsignados);
        return "/entrenador/clientes/clientes_entrenador";
    }

    @GetMapping("/rutinas")
    public String doListarRutinas(@RequestParam("id") Integer usuarioId, Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        if (session.getAttribute("sesionesEjercicios") != null)
            session.removeAttribute("sesionesEjercicios");
        if (session.getAttribute("rutina") != null)
            session.removeAttribute("rutina");

        UsuarioDTO usuario = usuarioService.findById(usuarioId);
        session.setAttribute("cliente", usuario);

        List<RutinaDTO> rutinas = rutinaService.findRutinaByUsuarioID(usuarioId);
        Map<RutinaDTO, LocalDate> map = new HashMap<>();
        int[] numSesiones = new int[rutinas.size()];
        for (RutinaDTO rutina : rutinas) {
            map.put(rutina, rutinaClienteService.findFechaInicioByRutinaAndUsuario(rutina.getId(), usuarioId));
            numSesiones[rutinas.indexOf(rutina)] = sesionentrenamientoService.findByRutina(rutina.getId()).size();
        }
        model.addAttribute("numSesiones", numSesiones);
        model.addAttribute("rutinas", rutinas);
        model.addAttribute("fechas", map);
        return "/entrenador/clientes/rutinas_clientes_entrenador";
    }

    @GetMapping("/rutinas/anyadirRutina")
    public String doAnyadirRutina(HttpSession session, Model model) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        return getString(model, session, new FiltroArgument(), "");
    }

    @PostMapping("/rutinas/anyadirRutinaFilter")
    public String doAnyadirRutina(@ModelAttribute("filtro") FiltroArgument filtro,
                                  Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        return getString(model, session, filtro, "");
    }

    private String getString(Model model, HttpSession session, FiltroArgument filtro, String error) {
        UsuarioDTO cliente = (UsuarioDTO) session.getAttribute("cliente");
        List<RutinaclienteDTO> rutinasCliente = rutinaClienteService.findByUsuario(cliente.getId());
        List<RutinaDTO> rutinasEntrenador = getRutinasEntrenador(filtro, session);
        Map<RutinaDTO, List<SesionentrenamientoDTO>> mapSesiones = new HashMap<>();


        if (rutinasEntrenador == null) {
            return "redirect:/entrenador/clientes/rutinas/anyadirRutina";
        } else {
            for (RutinaDTO rutina : rutinasEntrenador) {
                List<SesionentrenamientoDTO> sesiones = sesionentrenamientoService.findByRutina(rutina.getId());
                mapSesiones.put(rutina, sesiones);
            }
        }

        model.addAttribute("rutinasCliente", rutinasCliente);
        model.addAttribute("rutinasEntrenador", rutinasEntrenador);
        model.addAttribute("mapSesiones", mapSesiones);
        model.addAttribute("filtro", filtro);
        model.addAttribute("error", error);

        return "/entrenador/clientes/anyadir_rutina_cliente";
    }


    private List<RutinaDTO> getRutinasEntrenador(FiltroArgument filtro, HttpSession session) {
        if (filtro.getIntegerSesionNum() == -1 || filtro.getSesionMode() == -1) {
            filtro.setSesionMode(-1);
            filtro.setSesionNum("");
        }

        UsuarioDTO usuario = AuthUtils.getUser(session);
        if (filtro.estaVacio()) {
            return rutinaService.findRutinaByEntrenadorId(usuario.getId());
        }

        DificultadDTO dificultad = dificultadService.findById(filtro.getDificultad());
        Integer sesionMode = filtro.getSesionMode();
        Integer limiteBajo = sesionMode == 3 || sesionMode == -1 ? 0 : filtro.getIntegerSesionNum();
        Integer limiteAlto = sesionMode == 2 || sesionMode == -1 ? 7 : filtro.getIntegerSesionNum();

        List<RutinaDTO> rutinasEntrenador = rutinaService.findRutinaByEntrenadorWithFilter(usuario.getId(),
                filtro.getNombre(), limiteBajo, limiteAlto, dificultad.getId());

        return rutinasEntrenador;
    }

    @PostMapping("/rutinas/eliminarFiltro")
    public String doEliminarFiltro(@RequestParam("nombre") String nombre,
                                   @RequestParam("sesionMode") Integer sesionMode,
                                   @RequestParam("sesionNum") String sesionNum,
                                   @RequestParam("dificultad") Integer dificultad,
                                   Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        FiltroArgument filtro = new FiltroArgument();
        filtro.setNombre(nombre);
        filtro.setSesionMode(sesionMode);
        filtro.setSesionNum(sesionNum);
        filtro.setDificultad(dificultad);

        return getString(model, session, filtro, "");
    }


    @PostMapping("/rutinas/guardar")
    public String doGuardarRutina(@RequestParam("rutinas") List<RutinaDTO> rutinas,
                                  @RequestParam Map<String, String> datId,
                                  Model model,
                                  HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("cliente");
        List<RutinaDTO> rutinasCliente = rutinaService.findRutinaByUsuarioID(usuario.getId());

        for (RutinaDTO rutina : rutinas) {
            LocalDate date;
            try {
                date = LocalDate.parse(datId.get("dateId_" + rutina.getId()));
            } catch (Exception e) {
                return getString(model, session, new FiltroArgument(), "Por favor, Seleccione una fecha válida");
            }

            if (!rutinasCliente.contains(rutina)) {
                RutinaclienteDTO rutinaCliente = new RutinaclienteDTO();
                rutinaCliente.setRutina(rutina);
                rutinaCliente.setUsuario(usuario);
                rutinaCliente.setFechaInicio(date);
                RutinaclienteIdDTO rutinaclienteId = new RutinaclienteIdDTO();
                rutinaclienteId.setRutinaId(rutina.getId());
                rutinaclienteId.setUsuarioId(usuario.getId());
                rutinaCliente.setId(rutinaclienteId);
                rutinaClienteService.save(rutinaCliente);
            }
        }


        return "redirect:/entrenador/clientes/rutinas?id=" + usuario.getId();

    }

    @GetMapping("/rutinas/eliminarRutina")
    public String doEliminarRutina(@RequestParam("idRutina") RutinaDTO rutina,
                                   HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        UsuarioDTO cliente = (UsuarioDTO) session.getAttribute("cliente");
        rutinaClienteService.delete(rutina.getId(), cliente.getId());
        return "redirect:/entrenador/clientes/rutinas?id=" + cliente.getId();
    }

    @GetMapping("/rutinas/verRutina")
    public String doVerRutina(@RequestParam("idRutina") RutinaDTO rutina,
                              Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        UsuarioDTO cliente = (UsuarioDTO) session.getAttribute("cliente");
        List<SesionentrenamientoDTO> sesiones = sesionentrenamientoService.findByRutina(rutina.getId());
        List<EjerciciosesionDTO> ejercicios = new ArrayList<>();
        InformacionsesionDTO informacionSesion = new InformacionsesionDTO();
        Gson gson = new Gson();
        List<Integer> porcentaje = new ArrayList<>();
        List<Integer> sesionesEjercicios = new ArrayList<>();
        List<InformacionejercicioDTO> informacionEjercicios = new ArrayList<>();
        int i = 0;
        int total = 0;

        for (SesionentrenamientoDTO sesion : sesiones) {
            ejercicios = ejercicioSesionService.findBySesion(sesion.getId());
            informacionSesion = informacionSesionService.findByUsuarioAndSesion(cliente.getId(), sesion.getId());
            if (informacionSesion == null) {
                porcentaje.add(0);
                for (int n = 0; n < ejercicios.size(); n++) {
                    sesionesEjercicios.add(0);
                }
            } else {
                for (EjerciciosesionDTO ejercicio : ejercicios) {
                    String string = ejercicio.getEjercicio().getCategoria().getTiposBase();
                    String tipoCantidad = gson.fromJson(string, JsonArray.class).get(0).getAsString();
                    total += Integer.parseInt(gson.fromJson(ejercicio.getEspecificaciones(), JsonObject.class).get(tipoCantidad).getAsString());
                    InformacionejercicioDTO info = informacionEjercicioService.findByEjerciciosesionAndInformacionsesion(ejercicio.getId(), informacionSesion.getId());


                    if (info != null) {
                        informacionEjercicios.add(info);
                        sesionesEjercicios.add(Integer.parseInt(gson.fromJson(info.getEvaluacion(), JsonObject.class).get(tipoCantidad).getAsString()));
                        i += Integer.parseInt(gson.fromJson(info.getEvaluacion(), JsonObject.class).get(tipoCantidad).getAsString());
                    } else {
                        sesionesEjercicios.add(0);
                    }
                }
                porcentaje.add(Math.min(((i * 100) / total), 100));
                i = 0;
                total = 0;
            }
        }

        session.setAttribute("rutina", rutina);
        model.addAttribute("sesiones", sesiones);
        model.addAttribute("porcentaje", porcentaje);

        return "/entrenador/clientes/ver_rutina_cliente";
    }

    @GetMapping("/rutinas/verSesion")
    public String doVerSesion(@RequestParam("idSesion") SesionentrenamientoDTO sesion,
                              Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        UsuarioDTO cliente = (UsuarioDTO) session.getAttribute("cliente");
        List<EjerciciosesionDTO> ejercicios = ejercicioSesionService.findBySesion(sesion.getId());
        InformacionsesionDTO informacionSesion = informacionSesionService.findByUsuarioAndSesion(cliente.getId(), sesion.getId());
        List<InformacionejercicioDTO> infos = new ArrayList<>();

        for (EjerciciosesionDTO ejerciciosesion : ejercicios) {
            InformacionejercicioDTO informacionEjercicio = informacionEjercicioService.findByEjerciciosesionAndInformacionsesion(ejerciciosesion.getId(), informacionSesion.getId());
            infos.add(informacionEjercicio);
        }

        model.addAttribute("sesion", sesion);
        model.addAttribute("ejercicios", ejercicios);
        model.addAttribute("informacionSesion", informacionSesion);
        model.addAttribute("informacionEjercicios", infos);


        return "/entrenador/clientes/ver_sesion_cliente";
    }

    @GetMapping("/verSesion/verDesempeno")
    public String doVerDesempeno(@RequestParam("idEjercicio") EjerciciosesionDTO ejercicio,
                                 @RequestParam("idInfo") InformacionsesionDTO informacionSesion,
                                 @RequestParam("idSesion") SesionentrenamientoDTO sesion,
                                 Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        InformacionejercicioDTO informacionEjercicio = informacionEjercicioService.findByEjerciciosesionAndInformacionsesion(ejercicio.getId(), informacionSesion.getId());

        model.addAttribute("ejercicio", ejercicio.getEjercicio());
        model.addAttribute("informacionEjercicio", informacionEjercicio);
        model.addAttribute("sesion", sesion);

        Gson gson = new Gson();
        String repeticiones = gson.fromJson(ejercicio.getEspecificaciones(), JsonObject.class).get("repeticiones").getAsString();
        model.addAttribute("repeticionesTotales", repeticiones);

        return "(LEGACY)ver_desempeno";
    }
}
