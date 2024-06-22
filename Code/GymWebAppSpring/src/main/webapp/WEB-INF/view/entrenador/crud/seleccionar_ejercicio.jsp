<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.dto.EjercicioDTO" %>
<%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<EjercicioDTO> ejerciciosBase = (List<EjercicioDTO>) request.getAttribute("ejerciciosBase");
%>

<html>
<head>
    <title>Tus rutinas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
        let watch = false;
    </script>
</head>
<body>
<jsp:include page="../../components/header.jsp"/>

<div id="select" class="container" style="display: block">
    <div class="row mb-3">
        <div class="col-4">
            <h1>Ejercicios</h1>
        </div>
        <div class="col-8 d-flex justify-content-end align-items-center">
            <button class="btn btn-primary" onClick="goEditarSesion()">Volver</button>
        </div>
    </div>
    <%
        for (EjercicioDTO ejercicioBase : ejerciciosBase) {
    %>
    <div class="row">
        <div class="col-8 d-flex align-items-center" style="height:75px; text-decoration: none; cursor: pointer;"
           onClick="goCrearEjercicio(<%=ejercicioBase.getId()%>)">
            <img src="<%=ejercicioBase.getCategoria().getIcono()%>" alt="Categoria" style="width:50px; height:50px">
            <div class="ms-3">
                <span class="h2" style="color: black;"><%=ejercicioBase.getNombre()%></span><br>
                <span class="h5 text-secondary"><%=ejercicioBase.getDescripcion()%></span>
            </div>
        </div>
        <div class="col-4 d-flex justify-content-end align-items-center">
            <a style="cursor: pointer;" onClick="setEjercicioInfo(
                '<%=ejercicioBase.getLogo()%>',
                '<%=ejercicioBase.getNombre()%>',
                '<%=ejercicioBase.getMusculo().getNombre()%>',
                '<%=ejercicioBase.getDescripcion()%>',
                '<%=ejercicioBase.getEquipamiento()%>',
                '<%=ejercicioBase.getTipofuerza().getNombre()%>',
                '<%=ejercicioBase.getMusculoSecundario() != null ? ejercicioBase.getMusculoSecundario().getNombre() : "No especificado"%>',
                '<%=ejercicioBase.getCategoria().getNombre()%>',
                '<%=ejercicioBase.getVideo()%>')">
                <img src="/svg/eye.svg" alt="Ver" style="width:50px; height:50px">
            </a>
        </div>
    </div>


    <hr>
    <%
        }
    %>
</div>

<div id="watch" class="container" style="display: none">
    <div class="row mb-3">
        <div class="col-8">
            <h1>Información del ejercicio</h1>
        </div>
        <div class="col-4 d-flex justify-content-end align-items-center">
            <button class="btn btn-primary" onClick="changeWatch()">Volver</button>
        </div>
    </div>
    <div class="row mb-5">
        <div class="col-md-6">
            <img id="logo" src="/svg/question-square.svg" alt="Logo" style="max-width: 100%; height: auto;">
        </div>
    </div>
    <div class="row mb-5">
        <div class="col-6">
            <span class="h2">Nombre</span><br/>
            <span class="h3 text-secondary" id="nombre">Press</span>
        </div>
        <div class="col-6">
            <span class="h2">Músculo</span><br/>
            <span class="h3 text-secondary" id="musculo">Pectorales</span>
        </div>
    </div>
    <div class="row mb-5">
        <div class="col-12">
            <span class="h2">Descripción</span><br/>
            <span class="h3 text-secondary" id="descripcion">Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
                Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
                Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem</span>
        </div>
    </div>
    <div class="row mb-5">
        <div class="col-6">
            <span class="h2">Equipamiento</span><br/>
            <span class="h3 text-secondary" id="equipamiento">Equipamiento #1</span>
        </div>
        <div class="col-6">
            <span class="h2">Tipo de fuerza</span><br/>
            <span class="h3 text-secondary" id="tipoFuerza">Push</span>
        </div>
    </div>
    <div class="row mb-5">
        <div class="col-6">
            <span class="h2">Musculo secundario</span><br/>
            <span class="h3 text-secondary" id="musculoSecundario">Biceps</span>
        </div>
        <div class="col-6">
            <span class="h2">Categoría</span><br/>
            <span class="h3 text-secondary" id="categoria">Categoría #1</span>
        </div>
    </div>
    <div class="row mb-2">
        <div class="col-12">
            <span class="h1">Vídeo</span><br/>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div style="position: relative; width: 100%; padding-bottom: 56.25%;">
                <iframe
                        id="video"
                        src=""
                        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"
                        allowfullscreen>
                </iframe>
            </div>
        </div>
    </div>
</div>
<script>
    function goEditarSesion() {
        window.location.href = "/entrenador/rutinas/sesion/editar";
    }

    function goCrearEjercicio(ejbase) {
        window.location.href = "/entrenador/rutinas/ejercicio/crear?ejbase=" + ejbase;
    }

    function changeWatch() {
        watch = !watch;
        if(!watch)
            document.getElementById('video').src = "";

        const selectDiv = document.getElementById('select');
        const watchDiv = document.getElementById('watch');

        selectDiv.style.display = watch ? 'none' : 'block';
        watchDiv.style.display = watch ? 'block' : 'none';
    }

    function setEjercicioInfo(logo, nombre, musculo, descripcion, equipamiento, tipoFuerza, musculoSecundario, categoria, video) {
        document.getElementById('logo').src = logo;
        document.getElementById('nombre').innerHTML = nombre;
        document.getElementById('musculo').innerHTML = musculo;
        document.getElementById('descripcion').innerHTML = descripcion;
        document.getElementById('equipamiento').innerHTML = equipamiento;
        document.getElementById('tipoFuerza').innerHTML = tipoFuerza;
        document.getElementById('musculoSecundario').innerHTML = musculoSecundario;
        document.getElementById('categoria').innerHTML = categoria;
        document.getElementById('video').src = video;

        changeWatch();
    }
</script>
</body>
</html>
