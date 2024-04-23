<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Tus rutinas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="/header.js"></script>
</head>
<body>
    <div id="header"></div>
    <script> createHeader("rutinas");</script>

    <div class="container">
        <div class="row mb-3">
            <div class="col-4">
                <h1>Añadir ejercicio</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <a class="btn btn-primary" href="/entrenador/rutinas/crear/sesion">Volver</a>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-6">
                <span class="h3 text-dark">Ejercicio X (Categoría X)</span><br/>
            </div>
            <div class="col-6 d-flex justify-content-end">
                <a class="btn btn-primary">Seleccionar ejercicio</a>
            </div>
        </div>
        <div class="row mb-3 d-flex align-items-center">
            <div class="col-4">
                <span class="h4 text-secondary">Repeticiones</span><br/>
            </div>
            <div class="col-3">
                <input type="text" class="form-control mt-2">
            </div>
        </div>
        <div class="row mb-3 d-flex align-items-center">
            <div class="col-4">
                <span class="h4 text-secondary">Series</span><br/>
            </div>
            <div class="col-3">
                <input type="text" class="form-control mt-2">
            </div>
        </div>
        <div class="row mb-3 d-flex align-items-center">
            <div class="col-4">
                <span class="h4 text-secondary">Duración (en segundos)</span><br/>
            </div>
            <div class="col-3">
                <input type="text" class="form-control mt-2">
            </div>
        </div>
        <div class="row mb-3 d-flex align-items-center">
            <div class="col-4">
                <span class="h4 text-secondary">Descanso entre series (en segundos)</span><br/>
            </div>
            <div class="col-3">
                <input type="text" class="form-control mt-2">
            </div>
        </div>

        <div class="row">
            <div class="col-12 d-flex justify-content-end">
                <a class="btn btn-primary" href="/entrenador/rutinas/crear/sesion">Añadir</a>
            </div>
        </div>
    </div>
</body>
</html>
