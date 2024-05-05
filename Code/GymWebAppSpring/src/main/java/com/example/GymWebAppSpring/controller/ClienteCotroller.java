package com.example.GymWebAppSpring.controller;

import com.example.GymWebAppSpring.dao.EjercicioSesionRepository;
import com.example.GymWebAppSpring.dao.RutinaUsuarioRepository;
import com.example.GymWebAppSpring.dao.SesionentrenamientoRepository;
import com.example.GymWebAppSpring.entity.*;
import com.example.GymWebAppSpring.util.AuthUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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

//    @PostMapping("/valorarEntrenamiento")
//    public String doValorarEntrenamiento(@RequestParam("datosEntrenamiento") String datos) {
//        ObjectMapper objectMapper = new ObjectMapper();
//
//        // Convertir el JSON en un árbol de nodos
//        try {
//            JsonNode jsonNode = objectMapper.readTree(datos);
//            System.out.println("JSON: " + jsonNode);
//            for(JsonNode nodo : jsonNode){
//                JsonNode repeticionesNode = nodo.get("repeticiones");
//                JsonNode mpesoNode = nodo.get("mpeso");
//
//                // Verifica si los nodos no son nulos antes de llamar a asText()
//                if(repeticionesNode != null && mpesoNode != null) {
//                    String repeticiones = repeticionesNode.asText();
//                    String mpeso = mpesoNode.asText();
//
//                    System.out.println("Nodo:");
//                    System.out.println("Repeticiones: " + repeticiones);
//                    System.out.println("Mpeso: " + mpeso);
//                } else {
//                    System.err.println("Alguno de los nodos es nulo.");
//                }
//            }
//        } catch (JsonProcessingException e) {
//            System.err.println("Error al procesar el JSON: " + e.getMessage());
//        }
//
//
//
//        return "redirect:/";
//    }
}
