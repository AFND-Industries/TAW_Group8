package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.*;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.iu.FiltroArgument;
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
    private RutinaUsuarioRepository rutinaUsuarioRepository;

    @Autowired
    private EntrenadorAsignadoRepository entrenadorAsignadoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;


    @Autowired
    private RutinaClienteReporsitory rutinaClienteReporsitory;

    @Autowired
    private RutinaRepository rutinaRepository;

    @Autowired
    private EjercicioSesionRepository ejercicioSesionRepository;


    @Autowired
    private InformacionSesionRepository informacionSesionRepository;

    @Autowired
    private InformacionEjercicioRepository informacionEjercicioRepository;

    @Autowired
    private SesionEntrenamientoRepository sesionentrenamientoRepository;

    @Autowired
    private DificultadRepository dificultadRepository;

    @GetMapping("")
    public String entrenadorClientes(Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        if (session.getAttribute("cliente") != null)
            session.removeAttribute("cliente");

        List<Usuario> clientesAsignados = entrenadorAsignadoRepository.findClientsByEntrenadorID(AuthUtils.getUser(session));
        model.addAttribute("clientes", clientesAsignados);
        return "/entrenador/clientes/clientes_entrenador";
    }

    @GetMapping("/rutinas")
    public String doListarRutinas(@RequestParam("id") Usuario usuario, Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        if (session.getAttribute("sesionesEjercicios") != null)
            session.removeAttribute("sesionesEjercicios");
        if (session.getAttribute("rutina") != null)
            session.removeAttribute("rutina");

        session.setAttribute("cliente", usuario);

        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaById(usuario.getId());
        Map<Rutina, LocalDate> map = new HashMap<>();
        int[] numSesiones = new int[rutinas.size()];
        for (Rutina rutina : rutinas) {
            map.put(rutina, rutinaClienteReporsitory.findFechaInicioByRutinaAndUsuario(rutina, usuario));
            numSesiones[rutinas.indexOf(rutina)] = sesionentrenamientoRepository.findSesionesByRutina(rutina).size();
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
        Usuario cliente = (Usuario) session.getAttribute("cliente");
        List<Rutinacliente> rutinasCliente = rutinaClienteReporsitory.findByUsuario(cliente);
        List<Rutina> rutinasEntrenador = getRutinasEntrenador(filtro, session);
        Map<Rutina, List<Sesionentrenamiento>> mapSesiones = new HashMap<>();


        if (rutinasEntrenador == null) {
            return "redirect:/entrenador/clientes/rutinas/anyadirRutina";
        } else {
            for (Rutina rutina : rutinasEntrenador) {
                List<Sesionentrenamiento> sesiones = sesionentrenamientoRepository.findSesionesByRutina(rutina);
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


    private List<Rutina> getRutinasEntrenador(FiltroArgument filtro, HttpSession session) {
        if (filtro.getIntegerSesionNum() == -1 || filtro.getSesionMode() == -1) {
            filtro.setSesionMode(-1);
            filtro.setSesionNum("");
        }

        if (filtro.estaVacio()) {
            return rutinaRepository.findRutinaByEntrenadorId(AuthUtils.getUser(session));
        }

        Dificultad dificultad = dificultadRepository.findById(filtro.getDificultad()).orElse(null);
        Integer sesionMode = filtro.getSesionMode();
        Integer limiteBajo = sesionMode == 3 || sesionMode == -1 ? 0 : filtro.getIntegerSesionNum();
        Integer limiteAlto = sesionMode == 2 || sesionMode == -1 ? 7 : filtro.getIntegerSesionNum();

        List<Rutina> rutinasEntrenador = rutinaRepository.findRutinaByEntrenadorWithFilter(AuthUtils.getUser(session),
                filtro.getNombre(), limiteBajo, limiteAlto, dificultad);

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
    public String doGuardarRutina(@RequestParam("rutinas") List<Rutina> rutinas,
                                  @RequestParam Map<String, String> datId,
                                  Model model,
                                  HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        Usuario usuario = (Usuario) session.getAttribute("cliente");
        List<Rutina> rutinasCliente = rutinaUsuarioRepository.findRutinaById(usuario.getId());

        for (Rutina rutina : rutinas) {
            LocalDate date;
            try {
                date = LocalDate.parse(datId.get("dateId_" + rutina.getId()));
            } catch (Exception e) {
                return getString(model, session, new FiltroArgument(), "Por favor, Seleccione una fecha válida");
            }

            if (!rutinasCliente.contains(rutina)) {
                Rutinacliente rutinaCliente = new Rutinacliente();
                rutinaCliente.setRutina(rutina);
                rutinaCliente.setUsuario(usuario);
                rutinaCliente.setFechaInicio(date);
                RutinaclienteId rutinaclienteId = new RutinaclienteId();
                rutinaclienteId.setRutinaId(rutina.getId());
                rutinaclienteId.setUsuarioId(usuario.getId());
                rutinaCliente.setId(rutinaclienteId);
                rutinaClienteReporsitory.save(rutinaCliente);
            }
        }


        return "redirect:/entrenador/clientes/rutinas?id=" + usuario.getId();

    }

    @GetMapping("/rutinas/eliminarRutina")
    public String doEliminarRutina(@RequestParam("idRutina") Rutina rutina,
                                   HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";
        Usuario cliente = (Usuario) session.getAttribute("cliente");
        RutinaclienteId rutinaclienteId = new RutinaclienteId();
        rutinaclienteId.setRutinaId(rutina.getId());
        rutinaclienteId.setUsuarioId(cliente.getId());
        Rutinacliente rutinaCliente = rutinaClienteReporsitory.findById(rutinaclienteId).orElse(null);
        rutinaClienteReporsitory.delete(rutinaCliente);
        return "redirect:/entrenador/clientes/rutinas?id=" + cliente.getId();
    }

    @GetMapping("/rutinas/verRutina")
    public String doVerRutina(@RequestParam("idRutina") Rutina rutina,
                              Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        Usuario cliente = (Usuario) session.getAttribute("cliente");
        List<Sesionentrenamiento> sesiones = sesionentrenamientoRepository.findSesionesByRutina(rutina);
        List<Ejerciciosesion> ejercicios = new ArrayList<>();
        Informacionsesion informacionSesion = new Informacionsesion();
        Gson gson = new Gson();
        List<Integer> porcentaje = new ArrayList<>();
        List<Integer> sesionesEjercicios = new ArrayList<>();
        int i = 0;
        int total = 0;

        for (Sesionentrenamiento sesion : sesiones) {
            ejercicios = ejercicioSesionRepository.findEjerciciosBySesion(sesion);
            informacionSesion = informacionSesionRepository.findByUsuarioAndSesion(cliente, sesion);
            if (informacionSesion == null) {
                porcentaje.add(0);
                for (int n = 0; n < ejercicios.size(); n++) {
                    sesionesEjercicios.add(0);
                }
            } else {
                for (Ejerciciosesion ejercicio : ejercicios) {
                    String string = ejercicio.getEjercicio().getCategoria().getTiposBase();
                    String tipoCantidad = gson.fromJson(string, JsonArray.class).get(0).getAsString();
                    total += Integer.parseInt(gson.fromJson(ejercicio.getEspecificaciones(), JsonObject.class).get(tipoCantidad).getAsString());
                    Informacionejercicio info = informacionEjercicioRepository.findByEjerciciosesionAndInformacionsesion(ejercicio, informacionSesion );
                    if (info != null) {
                        sesionesEjercicios.add(Integer.parseInt(gson.fromJson(info.getEvaluacion(), JsonObject.class).get(tipoCantidad).getAsString()));
                        i += Integer.parseInt(gson.fromJson(info.getEvaluacion(), JsonObject.class).get(tipoCantidad).getAsString());
                    } else {
                        sesionesEjercicios.add(0);
                    }
                }
                porcentaje.add((i * 100) / total);
                i = 0;
                total = 0;
            }
        }

        session.setAttribute("rutina", rutina);
        model.addAttribute("sesiones", sesiones);
        model.addAttribute("porcentaje", porcentaje);
        session.setAttribute("sesionesEjercicios", sesionesEjercicios);

        return "/entrenador/clientes/ver_rutina_cliente";
    }

    @GetMapping("/rutinas/verSesion")
    public String doVerSesion(@RequestParam("idSesion") Sesionentrenamiento sesion,
                              Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        Usuario cliente = (Usuario) session.getAttribute("cliente");
        List<Ejerciciosesion> ejercicios = ejercicioSesionRepository.findEjerciciosBySesion(sesion);
        Informacionsesion informacionSesion = informacionSesionRepository.findByUsuarioAndSesion(cliente, sesion);

        model.addAttribute("sesion", sesion);
        model.addAttribute("ejercicios", ejercicios);
        model.addAttribute("informacionSesion", informacionSesion);


        return "/entrenador/clientes/ver_sesion_cliente";
    }

    @GetMapping("/verSesion/verDesempeno")
    public String doVerDesempeno(@RequestParam("idEjercicio") Ejerciciosesion ejercicio,
                                 @RequestParam("idInfo") Informacionsesion informacionSesion,
                                 @RequestParam("idSesion") Sesionentrenamiento sesion,
                                 Model model, HttpSession session) {
        if (!AuthUtils.isTrainer(session))
            return "redirect:/";

        Informacionejercicio informacionEjercicio = informacionEjercicioRepository.findByEjerciciosesionAndInformacionsesion(ejercicio,informacionSesion);

        model.addAttribute("ejercicio", ejercicio.getEjercicio());
        model.addAttribute("informacionEjercicio", informacionEjercicio);
        model.addAttribute("sesion", sesion);

        Gson gson = new Gson();
        String repeticiones = gson.fromJson(ejercicio.getEspecificaciones(), JsonObject.class).get("repeticiones").getAsString();
        model.addAttribute("repeticionesTotales", repeticiones);

        return "(LEGACY)ver_desempeno";
    }
}
