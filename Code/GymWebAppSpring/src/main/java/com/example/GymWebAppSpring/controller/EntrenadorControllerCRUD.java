package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dto.*;
import com.example.GymWebAppSpring.iu.*;
import com.example.GymWebAppSpring.service.*;
import com.example.GymWebAppSpring.util.AuthUtils;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/entrenador/rutinas")
public class EntrenadorControllerCRUD {
    // cambiar la bd tiposbase muchos mas caracteres, la descripcion igual
    // RECUPERAR LO QUE ESTABAS HACIENDO SESION
    // PONER PARA VOLVER UN MODAL PQ SE PIERDEN LOS CAMBIOS SABE

    @Autowired
    protected RutinaService rutinaService;

    @Autowired
    protected DificultadService dificultadService;

    @Autowired
    protected SesionEntrenamientoService sesionEntrenamientoService;

    @Autowired
    protected EjerciciosesionService ejercicioSesionService;

    @Autowired
    protected EjercicioService ejercicioService;

    @GetMapping("")
    public String doRutinas(@RequestParam(value = "changed", required = false) Integer changed,
                            @RequestParam(value = "mode", required = false) Integer mode,
                            Model model, HttpSession session) {
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";

        // Para que siempre que se termine una sesion se borre una cache, aunque haya veces que este vacia ya
        session.removeAttribute("cache");
        session.removeAttribute("sesionPos");
        session.removeAttribute("oldSesion");

        UsuarioDTO entrenador = AuthUtils.getUser(session);
        List<RutinaDTO> rutinas = rutinaService.findRutinaByEntrenadorId(entrenador.getId());

        model.addAttribute("rutinas", rutinas);
        model.addAttribute("dificultades", dificultadService.findAll());
        model.addAttribute("filtro", new FiltroArgument());
        if (changed != null) model.addAttribute("rutinaChanged", rutinaService.findById(changed));
        if (mode != null) model.addAttribute("changeMode", mode);

        return "/entrenador/crud/rutinas";
    }

    @GetMapping("/filtrar")
    public String doFiltrar(@ModelAttribute("filtro") FiltroArgument filtro,
                            Model model, HttpSession session) {
        if(!AuthUtils.isTrainer(session))
            return "redirect:/";

        // Si se ignora uno de los dos campos, el otro también, pues van de la mano
        if (filtro.getIntegerSesionNum() == -1 || filtro.getSesionMode() == -1) {
            filtro.setSesionMode(-1);
            filtro.setSesionNum("");
        }

        if (filtro.estaVacio())
            return "redirect:/entrenador/rutinas";

        String nombre = filtro.getNombre();
        Integer sesionNum = filtro.getIntegerSesionNum();
        Integer sesionMode = filtro.getSesionMode();
        Integer dificultadid = filtro.getDificultad();

        UsuarioDTO entrenador = AuthUtils.getUser(session);
        DificultadDTO dificultad = dificultadService.findById(dificultadid);

        Integer limiteBajo = sesionMode == 3 || sesionMode == -1 ? 0 : sesionNum;
        Integer limiteAlto = sesionMode == 2 || sesionMode == -1 ? 7 : sesionNum;

        List<RutinaDTO> rutinas = rutinaService.findRutinaByEntrenadorWithFilter(
                entrenador.getId(), nombre, limiteBajo, limiteAlto, dificultad.getId());

        model.addAttribute("rutinas", rutinas);
        model.addAttribute("dificultades", dificultadService.findAll());
        model.addAttribute("filtro", filtro);

        return "/entrenador/crud/rutinas";
    }

    @GetMapping("/ver")
    public String doVerRutina(@RequestParam("id") Integer id,
                              Model model, HttpSession session) {
        RutinaDTO r = rutinaService.findById(id);
        List<SesionentrenamientoDTO> ss = sesionEntrenamientoService.findByRutina(r.getId());;
        List<SesionArgument> sesiones = new ArrayList<>();
        for (SesionentrenamientoDTO s : ss) {
            int sesionId = s.getId();
            List<EjerciciosesionDTO> ee = ejercicioSesionService.findBySesion(sesionId);
            sesiones.add(new SesionArgument(s, ee));
        }
        RutinaArgument rutina = new RutinaArgument(r, sesiones);

        model.addAttribute("readOnly", true);
        session.setAttribute("cache", rutina);

        model.addAttribute("dificultades", dificultadService.findAll());

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/crear")
    public String doCrearRutina(HttpSession session, Model model) {
        RutinaArgument rutina = new RutinaArgument();
        rutina.setId(-1);

        session.setAttribute("cache", rutina);

        model.addAttribute("dificultades", dificultadService.findAll());

        return "/entrenador/crud/rutina";
    }


    @GetMapping("/editar")
    public String doEditarRutina(@RequestParam(value = "id", required = false) Integer id,
                                 HttpSession session, Model model) {
        RutinaArgument rutina;
        if (session.getAttribute("cache") != null) {
            rutina = (RutinaArgument) session.getAttribute("cache");
        } else {
            RutinaDTO r = rutinaService.findById(id);
            List<SesionentrenamientoDTO> ss = sesionEntrenamientoService.findByRutina(r.getId());;
            List<SesionArgument> sesiones = new ArrayList<>();
            for (SesionentrenamientoDTO s : ss) {
                List<EjerciciosesionDTO> ee = ejercicioSesionService.findBySesion(s.getId());
                sesiones.add(new SesionArgument(s, ee));
            }
            rutina = new RutinaArgument(r, sesiones);
        }

        session.setAttribute("cache", rutina);

        model.addAttribute("dificultades", dificultadService.findAll());

        return "/entrenador/crud/rutina";
    }

    @GetMapping("/guardar") // 0 = CREAR, 1 = EDITAR
    public String doGuardarRutina(@RequestParam("nombre") String nombre,
                                  @RequestParam("dificultad") Integer dificultad,
                                  @RequestParam("descripcion") String descripcion,
                                  HttpSession session, Model model) {
        // Las modificaciones de rutina antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");

        rutina.setNombre(nombre);
        rutina.setDificultad(dificultad);
        rutina.setDescripcion(descripcion);

        List<String> errorList = new ArrayList<>();
        if (nombre.trim().isEmpty())
            errorList.add("No puedes crear una rutina sin nombre");

        if (descripcion.trim().isEmpty())
            errorList.add("No puedes tener una descripción vacía");

        if (rutina.getSesiones().isEmpty())
            errorList.add("No puedes crear una rutina sin sesiones");

        if (!errorList.isEmpty()) {
            model.addAttribute("errorList", errorList);

            return doEditarRutina(rutina.getId(), session, model);
        }

        // RUTINA
        // CREAR O MODIFICAR DATOS RUTINA
        RutinaDTO r = rutinaService.findById(rutina.getId());

        if (r == null) {
            r = new RutinaDTO();

            r.setEntrenador(AuthUtils.getUser(session));
            r.setFechaCreacion(LocalDate.now());
        }

        r.setNombre(rutina.getNombre());
        r.setDificultad(dificultadService.findById(rutina.getDificultad())); // no va a ser null, pero habria que controlarlo
        r.setDescripcion(rutina.getDescripcion()); // problema description too long

        rutinaService.save(r);

        // SESION
        List<SesionArgument> sesiones = rutina.getSesiones();

        // ELIMINAR SESIONES
        List<Integer> sesionesId = new ArrayList<>();
        for (SesionArgument sesion : sesiones)
            sesionesId.add(sesion.getId());

        List<SesionentrenamientoDTO> sesionesRutina = sesionEntrenamientoService.findByRutina(r.getId());
        for (SesionentrenamientoDTO sesion : sesionesRutina) {
            if (!sesionesId.contains(sesion.getId())) {
                // SI LA SESION TENIA EJERCICIOS
                List<EjerciciosesionDTO> ejercicios = ejercicioSesionService.findBySesion(sesion.getId());
                List<Integer> ids = new ArrayList<>();
                for (EjerciciosesionDTO ejercicio : ejercicios)
                    ids.add(ejercicio.getId());
                ejercicioSesionService.deleteAll(ids);

                sesionEntrenamientoService.delete(sesion.getId());
            }
        }

        // CREAR O EDITAR SESIONES
        for (int i = 0; i < sesiones.size(); i++) {
            SesionArgument sesion = sesiones.get(i);
            SesionentrenamientoDTO s = sesionEntrenamientoService.findById(sesion.getId());

            if (s == null) {
                s = new SesionentrenamientoDTO();

                s.setRutina(r);
            }

            s.setNombre(sesion.getNombre());
            s.setDia(Integer.parseInt(sesion.getDia()));
            s.setDescripcion(sesion.getDescripcion());

            sesionEntrenamientoService.save(s);

            // EJERCICIOS
            List<EjercicioArgument> ejercicios = sesion.getEjercicios();

            // ELIMINAR EJERCICIOS
            List<Integer> ejerciciosId = new ArrayList<>();
            for (EjercicioArgument ejercicio : ejercicios)
                ejerciciosId.add(ejercicio.getId());

            List<EjerciciosesionDTO> ejerciciossesion = ejercicioSesionService.findBySesion(s.getId());
            for (EjerciciosesionDTO ejerciciosesion : ejerciciossesion) {
                if (!ejerciciosId.contains(ejerciciosesion.getId()))
                    ejercicioSesionService.delete(ejerciciosesion.getId());
            }

            // CREAR O EDITAR EJERCICIOS
            for (int j = 0; j < ejercicios.size(); j++) {
                EjercicioArgument ejercicio = ejercicios.get(j);
                EjerciciosesionDTO es = ejercicioSesionService.findById(ejercicio.getId());

                if (es == null) {
                    es = new EjerciciosesionDTO();

                    es.setSesionentrenamiento(s);
                }

                es.setEjercicio(ejercicioService.findById(ejercicio.getEjercicio()));
                es.setEspecificaciones(new Gson().toJson(ejercicio.getEspecificaciones()));
                es.setOrden(j + 1);
                es.setSesionentrenamiento(s);

                ejercicioSesionService.save(es);
            }
        }

        return "redirect:/entrenador/rutinas?changed=" + r.getId() + "&mode=" + (rutina.getId() < 0 ? 0 : 1);
    }

    @GetMapping("/borrar")
    public String doBorrarRutina(@RequestParam("id") Integer id) {
        RutinaDTO rutina = rutinaService.findById(id); // no deberia ser nunca null pero se puede probar
        List<SesionentrenamientoDTO> sesiones = sesionEntrenamientoService.findByRutina(rutina.getId());
        for (SesionentrenamientoDTO sesion : sesiones) {
            List<EjerciciosesionDTO> ejerciciossesion = ejercicioSesionService.findBySesion(sesion.getId());
            List<Integer> ids = new ArrayList<>();
            for (EjerciciosesionDTO ejercicio : ejerciciossesion)
                ids.add(ejercicio.getId());
            ejercicioSesionService.deleteAll(ids);
        }
        List<Integer> ids = new ArrayList<>();
        for (SesionentrenamientoDTO sesion : sesiones)
            ids.add(sesion.getId());
        sesionEntrenamientoService.deleteAll(ids);
        rutinaService.delete(rutina.getId());

        // PONER UN TOAST DE RUTINA BORRADA

        return "redirect:/entrenador/rutinas";
    }

    /*
        SESIONES DE ENTRENAMIENTO
     */
    @GetMapping("/crear/sesion/volver")
    public String doVolverFromSesion(HttpSession session) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int sesionPos = (int) session.getAttribute("sesionPos");
        SesionArgument oldSesion = (SesionArgument) session.getAttribute("oldSesion");

        if (oldSesion.getId() < -1) rutina.getSesiones().remove(sesionPos);
        else rutina.getSesiones().set(sesionPos, oldSesion);

        session.removeAttribute("sesionPos");
        session.removeAttribute("oldSesion");

        return "redirect:/entrenador/rutinas/editar";
    }

    @GetMapping("/crear/sesion/ver")
    public String doVerSesion(@RequestParam(value = "id", required = false) Integer id,
                              Model model, HttpSession session) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        List<SesionArgument> sesiones = rutina.getSesiones();

        int i = 0;
        SesionArgument sesion = null;
        while (i < sesiones.size() && sesion == null) {
            if (Objects.equals(sesiones.get(i).getId(), id))
                sesion = sesiones.get(i);
            i++;
        }

        List<Integer> ids = new ArrayList<>();
        for (EjercicioArgument ejerciciosesion : sesion.getEjercicios())
            ids.add(ejerciciosesion.getEjercicio());
        List<EjercicioDTO> ejercicios = ejercicioService.findEjercicioByIds(ids); /////////////////////////////////////////

        model.addAttribute("ejercicios", ejercicios);
        model.addAttribute("readOnly", true);

        session.setAttribute("sesionPos", i - 1);
        session.setAttribute("oldSesion", new SesionArgument());

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/crear/sesion")
    public String doCrearSesion(@RequestParam("nombre") String nombre,
                                @RequestParam("dificultad") Integer dificultad,
                                @RequestParam("descripcion") String descripcion,
                                HttpSession session) {
        // Las modificaciones de rutina antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        rutina.setNombre(nombre);
        rutina.setDificultad(dificultad);
        rutina.setDescripcion(descripcion);

        if (session.getAttribute("oldSesion") == null) { // Para que si recargas la pagina no se cree otra
            SesionArgument sesion = new SesionArgument();

            rutina.getSesiones().add(sesion);

            session.setAttribute("sesionPos", rutina.getSesiones().size() - 1);
            session.setAttribute("oldSesion", sesion); // al crear no hay ninguna antigua, metemos la misma que estamos creando
        }

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/crear/sesion/editar")
    public String doEditarSesion(@RequestParam(value = "nombre", required = false) String nombre,
                                 @RequestParam(value = "dificultad", required = false) Integer dificultad,
                                 @RequestParam(value = "descripcion", required = false) String descripcion,
                                 @RequestParam(value = "pos", required = false) Integer pos,
                                 HttpSession session, Model model) {
        // Las modificaciones de rutina antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        if (nombre != null) rutina.setNombre(nombre);
        if (dificultad != null) rutina.setDificultad(dificultad);
        if (descripcion != null) rutina.setDescripcion(descripcion);

        Object sesionPosObject = session.getAttribute("sesionPos");
        int sesionPos = sesionPosObject != null ? (int) sesionPosObject : pos;

        SesionArgument sesion = rutina.getSesiones().get(sesionPos);

        List<Integer> ids = new ArrayList<>();
        for (EjercicioArgument ejerciciosesion : sesion.getEjercicios())
            ids.add(ejerciciosesion.getEjercicio());
        List<EjercicioDTO> ejercicios = ejercicioService.findAll(); //////////////////////////////////////////////////////////////

        model.addAttribute("ejercicios", ejercicios);

        if (session.getAttribute("oldSesion") == null)
            session.setAttribute("oldSesion", sesion);

        if (session.getAttribute("sesionPos") == null)
            session.setAttribute("sesionPos", sesionPos);

        return "/entrenador/crud/sesion";
    }

    @GetMapping("/crear/sesion/guardar")
    public String doGuardarSesion(@RequestParam("nombre") String nombre,
                                  @RequestParam("dia") String dia,
                                  @RequestParam("descripcion") String descripcion,
                                  HttpSession session, Model model) {
        // Las modificaciones de sesion antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");

        SesionArgument sesion = rutina.getSesiones().get(pos);

        sesion.setNombre(nombre);
        sesion.setDia(dia);
        sesion.setDescripcion(descripcion);

        List<String> errorList = new ArrayList<>();
        if (nombre.trim().isEmpty())
            errorList.add("No puedes crear una sesión sin nombre");

        if (dia.trim().isEmpty())
            errorList.add("Debes especificar un día");

        // si no es numerico

        // si no es mayor que cero y menor o igual que 7

        // si el día está repetido

        if (descripcion.trim().isEmpty())
            errorList.add("No puedes tener una descripción vacía");

        if (sesion.getEjercicios().isEmpty())
            errorList.add("No puedes crear una sesión sin ejercicios");

        if (!errorList.isEmpty()) {
            model.addAttribute("errorList", errorList);

            return doEditarSesion(null, null, null, null, session, model);
        }

        if (sesion.getId() < -1)
            sesion.setId(-1); // para indicar que ha sido guardada y no es una dummy recien creada, se usa en doVolverFromSesion

        session.removeAttribute("sesionPos");
        session.removeAttribute("oldSesion");

        return "redirect:/entrenador/rutinas/editar";
    }

    @GetMapping("/crear/sesion/borrar")
    public String doBorrarSesion(@RequestParam("nombre") String nombre,
                                 @RequestParam("dificultad") Integer dificultad,
                                 @RequestParam("descripcion") String descripcion,
                                 @RequestParam("pos") Integer pos,
                                 HttpSession session) {
        // Las modificaciones de rutina antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        rutina.setNombre(nombre);
        rutina.setDificultad(dificultad);
        rutina.setDescripcion(descripcion);

        rutina.getSesiones().remove((int) pos);

        return "redirect:/entrenador/rutinas/editar";
    }

    /*
        EJERCICIOS
     */
    @GetMapping("/crear/ejercicio/volver")
    public String doVolverFromCrearEjercicio(@RequestParam("ejpos") Integer ejpos,
                                             HttpSession session) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");
        SesionArgument sesion = rutina.getSesiones().get(pos);
        sesion.getEjercicios().remove((int) ejpos);

        return "redirect:/entrenador/rutinas/crear/ejercicio/seleccionar";
    }

    @GetMapping("/crear/ejercicio/seleccionar")
    public String doSeleccionarEjercicio(@RequestParam(value = "nombre", required = false) String nombre,
                                         @RequestParam(value = "dia", required = false) String dia,
                                         @RequestParam(value = "descripcion", required = false) String descripcion,
                                         Model model, HttpSession session) {
        // Las modificaciones de sesion antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");

        SesionArgument sesion = rutina.getSesiones().get(pos);
        if (nombre != null) sesion.setNombre(nombre);
        if (dia != null) sesion.setDia(dia);
        if (descripcion != null) sesion.setDescripcion(descripcion);

        List<EjercicioDTO> ejerciciosBase = AuthUtils.isStrengthTrainer(session) // Si es de fuerza solo fuerza, si no todos
                ? ejercicioService.findAllEjerciciosFuerza() : ejercicioService.findAll();

        model.addAttribute("ejerciciosBase", ejerciciosBase);

        return "/entrenador/crud/seleccionar_ejercicio";
    }

    @GetMapping("/crear/ejercicio/ver")
    public String doVerEjercicio(@RequestParam("id") Integer id,
                                 Model model, HttpSession session) {
        EjerciciosesionDTO ejerciciosesion = ejercicioSesionService.findById(id);
        EjercicioDTO ejercicioBase = ejerciciosesion.getEjercicio();

        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        List<SesionArgument> sesiones = rutina.getSesiones();

        int pos = -1;
        for (SesionArgument sesione : sesiones) {
            List<EjercicioArgument> ejercicios = sesione.getEjercicios();
            for (int j = 0; j < ejercicios.size(); j++) {
                if (ejercicios.get(j).getId().equals(id)) {
                    pos = j;
                    break;
                }
            }
            if (pos != -1)
                break;
        }

        model.addAttribute("readOnly", true);
        model.addAttribute("ejercicioBase", ejercicioBase);
        model.addAttribute("ejercicioPos", pos);

        return "entrenador/crud/ejercicio_sesion";
    }

    @GetMapping("/crear/ejercicio")
    public String doCrearEjercicio(@RequestParam("ejbase") Integer ejbase,
                                   Model model, HttpSession session) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");
        SesionArgument sesion = rutina.getSesiones().get(pos);

        if (sesion.getEjercicios().isEmpty() || sesion.getEjercicios().getLast().getId() >= -1)
            sesion.getEjercicios().add(new EjercicioArgument());

        EjercicioDTO ejercicioBase = ejercicioService.findById(ejbase);
        model.addAttribute("ejercicioPos", -1);
        model.addAttribute("ejercicioBase", ejercicioBase);

        return "entrenador/crud/ejercicio_sesion";
    }

    @GetMapping("/crear/ejercicio/editar")
    public String doEditarEjercicio(@RequestParam(value = "nombre", required = false) String nombre,
                                    @RequestParam(value = "dia", required = false) String dia,
                                    @RequestParam(value = "descripcion", required = false) String descripcion,
                                    @RequestParam("ejPos") Integer ejPos,
                                    HttpSession session, Model model) {
        // Las modificaciones de sesion antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");

        SesionArgument sesion = rutina.getSesiones().get(pos);
        if (nombre != null) sesion.setNombre(nombre);
        if (dia != null) sesion.setDia(dia);
        if (descripcion != null) sesion.setDescripcion(descripcion);

        int ejbase = sesion.getEjercicios().get(ejPos).getEjercicio();
        EjercicioDTO ejercicioBase = ejercicioService.findById(ejbase);
        model.addAttribute("ejercicioBase", ejercicioBase);
        model.addAttribute("ejercicioPos", ejPos);

        return "entrenador/crud/ejercicio_sesion";
    }

    @GetMapping("/crear/ejercicio/guardar")
    public String doGuardarEjercicio(@RequestParam("especificaciones") String especificaciones,
                                     @RequestParam("ejpos") Integer ejpos,
                                     HttpSession session, Model model) {
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");
        SesionArgument sesion = rutina.getSesiones().get(pos);
        EjercicioArgument ejercicioSesion = sesion.getEjercicios().get(ejpos);

        Gson gson = new Gson();
        JsonObject esp = gson.fromJson(especificaciones, JsonObject.class);
        ejercicioSesion.setEspecificaciones(esp);

        List<String> errorList = new ArrayList<>();
        for (String tipoBase : esp.keySet()) {
            String value = esp.get(tipoBase).getAsString();

            if (value.trim().isEmpty())
                errorList.add("No has especificado el atributo " + tipoBase);
        }

        if (!errorList.isEmpty()) {
            model.addAttribute("errorList", errorList);

            return doEditarEjercicio(null, null, null, ejpos, session, model);
        }

        if (ejercicioSesion.getId() < -1)
            ejercicioSesion.setId(-1);

        return "redirect:/entrenador/rutinas/crear/sesion/editar";
    }

    @GetMapping("/crear/ejercicio/borrar")
    public String doBorrarEjercicio(@RequestParam("nombre") String nombre,
                                    @RequestParam("dia") String dia,
                                    @RequestParam("descripcion") String descripcion,
                                    @RequestParam("ejPos") Integer ejPos,
                                    HttpSession session) {
        // Las modificaciones de sesion antes de venir a esta pantalla
        RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
        int pos = (int) session.getAttribute("sesionPos");

        SesionArgument sesion = rutina.getSesiones().get(pos);
        sesion.setNombre(nombre);
        sesion.setDia(dia);
        sesion.setDescripcion(descripcion);

        rutina.getSesiones().get(pos).getEjercicios().remove((int) ejPos);

        return "redirect:/entrenador/rutinas/crear/sesion/editar";
    }
}
