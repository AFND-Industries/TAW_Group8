<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 22/04/2024
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Usuario> clientes = (List<Usuario>) request.getAttribute("clientes");
%>
<html>
<head>
    <title>Tus Clientes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <%@include file="../../components/header.jsp"%>
    <div class="container">
        <div class="row mb-4">
            <div class="col-4">
                <h1>Tus clientes</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#filter-modal" >Filtros de búsqueda</button>
                </div>
            </div>
        </div>
        <%
            for(Usuario cliente : clientes){
        %>
        <div class="row">
                <div class="col-8 d-flex align-items-center">
                    <i class="bi bi-person-square" style="font-size: 40px"></i>
                    <a class="btn ms-3" style="font-size: 20px; border: transparent" href="/entrenador/clientes/rutinas?id=<%= cliente.getId()%>"> <%= cliente.getNombre() %> <%= cliente.getApellidos() %></a>
                </div>
        </div>
        <hr>
        <%
            }
        %>
    </div>
    <!-- Bootstrap Javascript Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
