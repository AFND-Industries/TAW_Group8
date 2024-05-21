<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 15/05/2024
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Usuario user = (Usuario) request.getAttribute("user");
%>
<html>
<head>
    <title>Ver usuario</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp" />
<div class="container text-center">
    <h1>Información del usuario</h1>
    <div class="row g-3">
        <div class="col-md-4 col-12">
            <div class="card py-1">
                <span class="text-secondary">Nombre</span>
                <span class="fw-bold fs-3">${user.nombre}</span>
            </div>
        </div>
        <div class="col-md-4 col-12">
            <div class="card py-1">
                <span class="text-secondary">Apellidos</span>
                <span class="fw-bold fs-3">${user.apellidos}</span>
            </div>
        </div>
        <div class="col-md-4 col-12">
            <div class="card py-1">
                <span class="text-secondary">DNI</span>
                <span class="fw-bold fs-3">${user.dni}</span>
            </div>
        </div>
        <div class="col-md-4 col-12">
            <div class="card py-1">
                <span class="text-secondary">Edad</span>
                <span class="fw-bold fs-3">${user.edad}</span>
            </div>
        </div>
        <div class="col-md-4 col-12">
            <div class="card py-1">
                <span class="text-secondary">Género</span>
                <span class="fw-bold fs-3"><%=user != null && user.getGenero() == 'm' ? "Masculino" : "Femenino"%></span>
            </div>
        </div>
        <div class="col-md-4 col-12">
            <div class="card py-1">
                <span class="text-secondary">Tipo de usuario</span>
                <span class="fw-bold fs-3">${user.tipo.nombre}</span>
            </div>
        </div>
    </div>
    <a href="/admin/users/" class="btn btn-outline-secondary mt-3 mb-2 w-100">
        Volver atrás
    </a>
</div>
<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>

