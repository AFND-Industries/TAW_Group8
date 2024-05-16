package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.*;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/client")
public class ClienteController {


    @Autowired
    protected InformacionEjercicioRepository informacionEjercicioRepository;

    @Autowired
    protected RutinaUsuarioRepository rutinaUsuarioRepository;

    @Autowired
    protected SesionentrenamientoRepository sesionentrenamientoRepository;

    @Autowired
    protected EjercicioSesionRepository ejerciciosesionRepository;

    @Autowired
    protected InformacionSesionRepository informacionSesionRepository;

    @GetMapping("")
    public String doClient(HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        Usuario user = (Usuario) sesion.getAttribute("user");
        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaByUsuario(user);
        modelo.addAttribute("usuario", user);
        modelo.addAttribute("rutinas", rutinas);
        return "client/clientePersonalSpace";


    }

    @PostMapping("/verrutina")
    public String doVerRutina(@RequestParam("rutinaElegida") Rutina rutina, HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        sesion.removeAttribute("sesionEntrenamiento");
        Map<Sesionentrenamiento, List<Ejerciciosesion>> sesionesEjercicios = new LinkedHashMap<>();
        Usuario user = (Usuario) sesion.getAttribute("user");
        modelo.addAttribute("usuario", user);
        modelo.addAttribute("rutina", rutina);
        List<Sesionentrenamiento> sesionesEntrenamiento = sesionentrenamientoRepository.findSesionesByRutina(rutina);
        for (Sesionentrenamiento s : sesionesEntrenamiento) {
            List<Ejerciciosesion> ejercicos = ejerciciosesionRepository.findEjerciciosBySesion(s);
            sesionesEjercicios.put(s, ejercicos);
        }

        modelo.addAttribute("sesionesEjercicios", sesionesEjercicios);


        return "client/verrutina";


    }

    @GetMapping("/sesioninfo")
    public String doVerSesion(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento, HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";

        sesion.setAttribute("sesionEntrenamiento", sesionEntrenamiento);


        Usuario user = (Usuario) sesion.getAttribute("user");

        List<Ejerciciosesion> ejercicios = ejerciciosesionRepository.findEjerciciosBySesion(sesionEntrenamiento);
        modelo.addAttribute("usuario", user);
        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        modelo.addAttribute("ejercicios", ejercicios);
        return "client/verSesion";
    }

    @PostMapping("/valorarEntrenamiento")
    public String doValorarEntrenamiento(@RequestParam("datosEntrenamiento") String datos, HttpSession session) {
        ObjectMapper objectMapper = new ObjectMapper();
        Gson gson = new Gson();
        List<Ejerciciosesion> ejercicios = (List<Ejerciciosesion>) session.getAttribute("listaEjercicos");


//        List<Ejerciciosesion> ejerciciosesions = (List<Ejerciciosesion>) ejercicios;
        // Convertir el JSON en un árbol de nodos
        try {
            // Crear una instancia de Gson


            // Convertir la cadena de texto JSON a un array de arrays de cadenas
            String[][] resultados = gson.fromJson(datos, String[][].class);

            // Array para almacenar las cadenas JSON resultantes
            Informacionsesion resultadoSesion = new Informacionsesion();
            resultadoSesion.setComentario("");
            resultadoSesion.setFechaFin(LocalDate.now());
            resultadoSesion.setValoracion(0);
            resultadoSesion.setSesionentrenamiento((Sesionentrenamiento) session.getAttribute("sesionEntrenamiento"));
            resultadoSesion.setUsuario((Usuario) session.getAttribute("user"));
            informacionSesionRepository.save(resultadoSesion);
            int i = 0;
            for (String[] fila : resultados) {

                for (int j = 0; j < fila.length; j++) {
                    fila[j] = fila[j].replaceAll("\\\\", "");
                }

                String concatenatedString = "[" + String.join(", ", fila) + "]";


                Informacionejercicio resultadosEjercicios = new Informacionejercicio();
                resultadosEjercicios.setInformacionsesion(resultadoSesion);
                resultadosEjercicios.setEjerciciosesion(ejercicios.get(i));
                resultadosEjercicios.setEvaluacion(concatenatedString);
                i++;


                informacionEjercicioRepository.save(resultadosEjercicios);
            }
        } catch (Exception e) {
            System.err.println("Error al insertar: " + e.getMessage());
        }


        return "redirect:/";
    }
}
