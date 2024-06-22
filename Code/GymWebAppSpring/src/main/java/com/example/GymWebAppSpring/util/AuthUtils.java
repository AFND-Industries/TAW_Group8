package com.example.GymWebAppSpring.util;

import com.example.GymWebAppSpring.dto.UsuarioDTO;
import jakarta.servlet.http.HttpSession;

public class AuthUtils {
    /**
     * Devuelve un booleano si un usuario tiene la sesión iniciada
     * @param session Sesión HTTP activa
     * @return True si existe una sesión active, False en caso contrario
     */
    public static boolean isLogged(HttpSession session){
        return session.getAttribute("user") != null;
    }

    /**
     * Devuelve un booleano si un usuario es administrador
     * @param session Sesión HTTP activa
     * @return True si el usuario está loggeado y es administrador, False en caso contrario
     */
    public static boolean isAdmin(HttpSession session){
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        return user != null && user.getTipo().getNombre().equals("Administrador");
    }


    /**
     * Devuelve un booleano si un usuario es un cliente
     * @param session Sesión HTTP activa
     * @return True si el usuario está loggeado y es un cliente, False en caso contrario
     */

    public static boolean isClient(HttpSession session){
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        return user != null && user.getTipo().getNombre().equals("Cliente");
    }

    /**
     * Devuelve un booleano si un usuario es entrenador
     * @param session Sesión HTTP activa
     * @return True si el usuario está loggeado y es entrenador, False en caso contrario
     */
    public static boolean isTrainer(HttpSession session){
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        return user != null && (user.getTipo().getNombre().contains("Entrenador"));
    }

    /**
     * Devuelve un booleano si un usuario es entrenador de fuerza
     * @param session Sesión HTTP activa
     * @return True si el usuario está loggeado y es entrenador, False en caso contrario
     */
    public static boolean isStrengthTrainer(HttpSession session){
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        return user != null && user.getTipo().getNombre().equals("Entrenador de Fuerza");
    }

    /**
     * Devuelve un booleano si un usuario es entrenador de fuerza
     * @param session Sesión HTTP activa
     * @return True si el usuario está loggeado y es entrenador, False en caso contrario
     */
    public static boolean isCrossfitTrainer(HttpSession session){
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
        return user != null && user.getTipo().getNombre().equals("Entrenador de Crossfit");
    }

    /**
     * Devuelve la entidad del usuario que está loggeado
     * @param session Sesión HTTP activa
     * @return Devuelve la entidad del usuario o un valor null si no está loggeado
     */
    public static UsuarioDTO getUser(HttpSession session){
        return (UsuarioDTO) session.getAttribute("user");
    }
}
