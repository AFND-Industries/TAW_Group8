<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 23/04/2024
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Rutina> rutinas = (List<Rutina>) request.getAttribute("rutinas");
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    int[] sesiones = (int[]) request.getAttribute("numSesiones");
%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="/header.js"></script>
</head>
<body>
    <%@include file="../../components/header.jsp" %>
    <div class="container">
        <div class="row mb-3">
            <h1> Rutinas de <%= usuario.getNombre()%> <%= usuario.getApellidos() %> </h1>
        </div>
        <div class="row">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Sesiones</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int i = 0;
                    for (Rutina rutina : rutinas) {
                %>
                <tr>
                    <td><%= rutina.getNombre() %></td>
                    <td>0 / <%= sesiones[i] %></td>
                    <td>
                        <a><i class="bi bi-pencil-square me-3"></i></a>
                        <a><i class="bi bi-trash3 me-3"></i></a>
                    </td>
                </tr>

                <%
                        i++;
                    }
                %>
                </tbody>
            </table>
    </div>
</body>
</html>
