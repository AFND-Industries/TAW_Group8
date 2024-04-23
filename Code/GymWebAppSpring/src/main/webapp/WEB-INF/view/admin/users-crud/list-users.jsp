<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 22/04/2024
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("users");
%>
<html>
<head>
    <title>Listado de usuarios</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<%@include file="../../components/header.jsp"%>
<div class="container">
    <h1 class="text-center mb-2">Listado de usuarios</h1>
    <table class="table table-striped">
        <thead>
        <th>ID</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Genero</th>
        <th>Edad</th>
        <th>DNI</th>
        <th colspan="2">Tipo usuario</th>
        </thead>
        <tbody>
        <%
            for(Usuario usuario : usuarios) {
        %>
        <tr>
            <td><%= usuario.getId() %></td>
            <td><%= usuario.getNombre() %></td>
            <td><%= usuario.getApellidos() %></td>
            <td><%= usuario.getGenero() %></td>
            <td><%= usuario.getEdad() %></td>
            <td><%= usuario.getDni() %></td>
            <td><%= usuario.getTipo().getNombre() %></td>
            <td>
                <a href="/admin/edit?id=<%=usuario.getId()%>"><i class="bi bi-pencil-square me-3"></i></a>
                <a href="/admin/delete?id=<%=usuario.getId()%>"><i class="bi bi-trash3 me-3"></i></a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <div class="text-center">
        <a class="btn btn-outline-secondary px-2" href="/admin/register">
            <i class="bi bi-plus-circle me-1"></i> Añadir usuario
        </a>
    </div>
</div>
<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>

