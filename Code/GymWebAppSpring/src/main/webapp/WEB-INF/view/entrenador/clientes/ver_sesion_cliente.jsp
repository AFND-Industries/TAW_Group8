<%@ page import="com.example.GymWebAppSpring.entity.Ejerciciosesion" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionentrenamiento" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 29/04/2024
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Ejerciciosesion> ejercicios = (List<Ejerciciosesion>) request.getAttribute("ejercicios");
    Sesionentrenamiento sesion = (Sesionentrenamiento) request.getAttribute("sesion");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%= sesion.getNombre()%>
<%
    for(Ejerciciosesion ejercicio : ejercicios) {
        System.out.println(ejercicio.getEjercicio().getNombre());
%>
    <%= ejercicio.getEjercicio().getNombre()%>
<%
    }
%>
</body>
</html>
