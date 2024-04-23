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
    <title>Tus rutinas</title
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
    <%@ include file="../../components/header.jsp" %>

    <div class="container">
        <div class="row mb-3">
            <div class="col-4">
                <h1>Press de banca</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <a class="btn btn-primary" href="/entrenador/rutinas/crear/ejercicio/seleccionar">Volver</a>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-12">
                <img src="/svg/question-square.svg" alt="Ver" style="width:200px; height:200px">
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-6">
                <span class="h2">Nombre</span><br/>
                <span class="h3 text-secondary">Press</span>
            </div>
            <div class="col-6">
                <span class="h2">Músculo</span><br/>
                <span class="h3 text-secondary">Pectorales</span>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-12">
                <span class="h2">Descripción</span><br/>
                <span class="h3 text-secondary">Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
                Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
                Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem</span>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-6">
                <span class="h2">Equipamiento</span><br/>
                <span class="h3 text-secondary">Equipamiento #1</span>
            </div>
            <div class="col-6">
                <span class="h2">Tipo de fuerza</span><br/>
                <span class="h3 text-secondary">Push</span>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-6">
                <span class="h2">Dificultad</span><br/>
                <span class="h3 text-secondary">Normal</span>
            </div>
            <div class="col-6">
                <span class="h2">Categoría</span><br/>
                <span class="h3 text-secondary">Categoría #1</span>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-6">
                <span class="h2">Músculo secundario</span><br/>
            </div>
            <div class="col-6">
                <span class="h3 text-secondary">Bíceps</span>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-12">
                <span class="h2">Vídeo</span><br/>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <img src="/svg/question-square.svg" alt="Ver" style="width:200px; height:200px">
            </div>
        </div>
</body>
</html>
