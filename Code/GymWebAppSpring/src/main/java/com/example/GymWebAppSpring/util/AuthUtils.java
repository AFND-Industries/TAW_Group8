package com.example.GymWebAppSpring.util;

import com.example.GymWebAppSpring.entity.Usuario;
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
        Usuario user = (Usuario) session.getAttribute("user");
        return user != null && user.getTipo().getNombre().equals("Administrador");
    }

    /**
     * Devuelve un booleano si un usuario es un cliente
     * @param session Sesión HTTP activa
     * @return True si el usuario está loggeado y es un cliente, False en caso contrario
     */
    public static boolean isClient(HttpSession session){
        Usuario user = (Usuario) session.getAttribute("user");
        return user != null && user.getTipo().getNombre().equals("Cliente");
    }

    /**
     * Devuelve un booleano si un usuario es entrenador
     * @param session Sesión HTTP activa
     * @return True si el usuario está loggeado y es entrenador, False en caso contrario
     */
    public static boolean isTrainer(HttpSession session){
        Usuario user = (Usuario) session.getAttribute("user");
        return user != null && user.getTipo().getNombre().equals("Entrenador");
    }
}
