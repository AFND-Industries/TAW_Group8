<%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 15/05/2024
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <title>Ver ejercicio</title>
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
    <h1>Ver ${ejericicio.nombre}</h1>
    <div class="row g-3">
        <div class="col-md-6 col-12">
            <div class="card py-1">
                <span class="text-secondary">Nombre</span>
                <span class="fw-bold fs-3">${ejericicio.nombre}</span>
            </div>
        </div>
        <div class="col-md-6 col-12">
            <div class="card py-1">
                <span class="text-secondary">Categoría</span>
                <span class="fw-bold fs-3">${ejericicio.categoria.nombre}</span>
            </div>
        </div>
        <div class="col-12">
            <div class="card py-1">
                <span class="text-secondary">Descripción</span>
                <span class="fs-4">${ejericicio.descripcion}</span>
            </div>
        </div>
        <div class="col-md-6 col-12">
            <div class="card py-1">
                <span class="text-secondary">Músculo</span>
                <span class="fw-bold fs-3">${ejericicio.musculo.nombre}</span>
            </div>
        </div>
        <div class="col-md-6 col-12">
            <div class="card py-1">
                <span class="text-secondary">Músculo Secundario</span>
                <span class="fw-bold fs-3">${ejericicio.musculo.nombre}</span>
            </div>
        </div>
        <div class="col-md-6 col-12">
            <div class="card py-1">
                <span class="text-secondary">Equipamiento</span>
                <span class="fw-bold fs-3">${ejericicio.equipamiento}</span>
            </div>
        </div>
        <div class="col-md-6 col-12">
            <div class="card py-1">
                <span class="text-secondary">Tipo de fuerza</span>
                <span class="fw-bold fs-3">${ejericicio.tipofuerza.nombre}</span>
            </div>
        </div>
    </div>
        <a href="/admin/exercises/" class="btn btn-outline-secondary mt-3 mb-2 w-100">
            Volver atrás
        </a>
</div>
<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
