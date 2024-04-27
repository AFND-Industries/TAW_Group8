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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
    <div class="container">
        <div class="row mb-3">
            <h1> Rutinas de <%= usuario.getNombre()%> <%= usuario.getApellidos() %> </h1>
        </div>
        <div class="row mb-3">
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
                        <a href="/entrenador/clientes/rutinas/eliminarRutina?idRutina=<%= rutina.getId()%>&idCliente=<%= usuario.getId()%>"><i class="bi bi-trash3 me-3"></i></a>                    </td>
                </tr>

                <%
                        i++;
                    }
                %>
                </tbody>
            </table>
        </div>
        <div class="row d-flex justify-content-center">
            <a href="/entrenador/clientes/rutinas/anyadirRutina?id=<%= usuario.getId() %>" class="btn btn-primary" style="width: 15%">Nueva Rutina</a>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
