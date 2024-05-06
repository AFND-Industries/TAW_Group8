package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.EjercicioSesionRepository;
import com.example.GymWebAppSpring.dao.InformacionSesionRepository;
import com.example.GymWebAppSpring.dao.RutinaUsuarioRepository;
import com.example.GymWebAppSpring.dao.SesionentrenamientoRepository;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/client")
public class ClienteCotroller {


    @Autowired
    private RutinaUsuarioRepository rutinaUsuarioRepository;

    @Autowired
    private SesionentrenamientoRepository sesionentrenamientoRepository;

    @Autowired
    private EjercicioSesionRepository ejerciciosesionRepository;

    @Autowired
    private InformacionSesionRepository informacionSesionRepository;
    @GetMapping("")
    public String doClient(HttpSession sesion, Model modelo) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        Usuario user = (Usuario) sesion.getAttribute("user");
        List<Rutina> rutinas = rutinaUsuarioRepository.findRutinaByUsuario(user);
        modelo.addAttribute("usuario", user);
        modelo.addAttribute( "rutinas", rutinas);
        return "client/clientePersonalSpace";


    }

    @PostMapping("/verrutina")
    public String doVerRutina(@RequestParam("rutinaElegida") Rutina rutina,HttpSession sesion, Model modelo  ) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";

        Map<Sesionentrenamiento, List<Ejerciciosesion>> sesionesEjercicios = new LinkedHashMap<>();
        Usuario user = (Usuario) sesion.getAttribute("user");
        modelo.addAttribute("usuario", user);
        modelo.addAttribute("rutina", rutina);
        List<Sesionentrenamiento> sesionesEntrenamiento = sesionentrenamientoRepository.findSesionesByRutina(rutina);
        for(Sesionentrenamiento s : sesionesEntrenamiento){
            List<Ejerciciosesion> ejercicos = ejerciciosesionRepository.findEjerciciosBySesion(s);
            sesionesEjercicios.put(s, ejercicos);
        }

        modelo.addAttribute("sesionesEjercicios", sesionesEjercicios);


        return "client/verrutina";


    }
    @PostMapping("/sesioninfo")
    public String doVerSesion(@RequestParam("sesionEntrenamiento") Sesionentrenamiento sesionEntrenamiento,HttpSession sesion, Model modelo  ) {
        if (!AuthUtils.isClient(sesion))
            return "redirect:/";
        Usuario user = (Usuario) sesion.getAttribute("user");
        modelo.addAttribute("usuario", user);
        modelo.addAttribute("sesionEntrenamiento", sesionEntrenamiento);
        List<Ejerciciosesion> ejercicios = ejerciciosesionRepository.findEjerciciosBySesion(sesionEntrenamiento);
        modelo.addAttribute("ejercicios", ejercicios);
        modelo.addAttribute("ejercicioElegido",ejercicios.getFirst());
        return "client/verSesion";
    }

    @PostMapping("/valorarEntrenamiento")
    public String doValorarEntrenamiento(@RequestParam("datosEntrenamiento") String datos,@RequestParam("ejercicios") String  ejerciciosJson) {
        ObjectMapper objectMapper = new ObjectMapper();
        Gson gson = new Gson();
        List<Ejerciciosesion> ejercicios = gson.fromJson(ejerciciosJson,new TypeToken<List<Ejerciciosesion>>(){}.getType());


//        List<Ejerciciosesion> ejerciciosesions = (List<Ejerciciosesion>) ejercicios;
        // Convertir el JSON en un árbol de nodos
        try {
            // Crear una instancia de Gson


            // Convertir la cadena de texto JSON a un array de arrays de cadenas
            String[][] resultados = gson.fromJson(datos, String[][].class);

            // Array para almacenar las cadenas JSON resultantes
            String[] resultadosJson = new String[resultados.length];
            Informacionsesion resultadoSesion = new Informacionsesion();
            for (String[] fila : resultados) {
                int i =0;
                Informacionejercicio resultadosEjercicios = new Informacionejercicio();
                resultadosEjercicios.setInformacionsesion(resultadoSesion);
                resultadosEjercicios.setEjerciciosesion(ejercicios.get(i));
                i++;
                resultadosEjercicios.setEvaluacion(fila.toString());
                informacionSesionRepository.save(resultadoSesion);
                for (String json : fila) {
                    // Convertir el JSON a un objeto JsonObject
                    JsonObject jsonObject = JsonParser.parseString(json).getAsJsonObject();

                    // Extraer los valores de repeticiones y mpeso
                    String repeticiones = jsonObject.get("repeticiones").getAsString();
                    String mpeso = jsonObject.get("mpeso").getAsString();

                    // Imprimir los valores extraídos
                    System.out.println("Repeticiones: " + repeticiones + ", Mpeso: " + mpeso);
                }
            }
        } catch (Exception e) {
            System.err.println("Error al procesar el JSON: " + e.getMessage());
        }



        return "redirect:/";
    }
}
