<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.example.GymWebAppSpring.iu.RutinaArgument" %>
<%@ page import="com.example.GymWebAppSpring.iu.EjercicioArgument" %>
<%@ page import="com.example.GymWebAppSpring.iu.SesionArgument" %>
<%@ page import="com.example.GymWebAppSpring.dto.EjercicioDTO" %><%--
  Created by IntelliJ IDEA.
  User: Eulogio Quemada
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // AÑADIR UN OJITO PARA PODER VER EL EJERCICIO BASE SOBRE EL QUE ESTAMOS TRABAJANDO
    RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");

    Integer sesionPos = (Integer) session.getAttribute("sesionPos");
    Integer ejercicioPos = (Integer) request.getAttribute("ejercicioPos");
    EjercicioDTO ejercicioBase = (EjercicioDTO) request.getAttribute("ejercicioBase");
    List<String> tiposBase = new Gson().fromJson(ejercicioBase.getCategoria().getTiposBase(), ArrayList.class);

    Object readOnlyObject = request.getAttribute("readOnly");
    boolean readOnly = readOnlyObject != null && ((Boolean) readOnlyObject);
    boolean ejercicioExists = ejercicioPos >= 0;
    if (!ejercicioExists)
        ejercicioPos = rutina.getSesiones().get(sesionPos).getEjercicios().size() - 1;

    SesionArgument sesion = rutina.getSesiones().get(sesionPos);
    List<EjercicioArgument> ejercicios = sesion.getEjercicios();
    EjercicioArgument ejercicio = ejercicios.get(ejercicioPos);
    ejercicio.setEjercicio(ejercicioBase.getId());

    List<String> errorList = (List<String>) request.getAttribute("errorList");
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
</head>
<body>
<jsp:include page="../../../components/header.jsp"/>

<div class="container mb-5">
    <%if (errorList != null && !errorList.isEmpty()) {%>
    <div class="row-mb-3">
        <%for (String error : errorList) {%>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%=error%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%}%>
    </div>
    <%}%>
    <div class="row mb-3">
        <div class="col-4">
            <h1>Añadir ejercicio</h1>
        </div>
        <div class="col-8 d-flex justify-content-end align-items-center">
            <button class="btn btn-primary"
                    onClick="<%=ejercicioExists ? (readOnly ? "goVolverVerSesion()" : "goVolverEditarSesion()") : "doVolverToSeleccionar()"%>">Volver</button>
        </div>
    </div>

    <div class="row mb-4 d-flex justify-content-center">
        <div class="col-6 d-flex flex-column justify-content-center">
            <span class="h1 text-dark text-center"><%=ejercicioBase.getNombre()%> (<%=ejercicioBase.getCategoria().getNombre()%>)</span>
            <img src="<%=ejercicioBase.getLogo()%>" alt="Logo" style="max-width: 100%; height: auto;">
        </div>
    </div>
    <%for (int i = 0; i < tiposBase.size(); i++) {%>
        <div class="row mb-3 d-flex align-items-center">
            <div class="col-4">
                <span class="h4 text-secondary"><%=tiposBase.get(i)%></span><br/>
            </div>
            <div class="col-3">
                <input <%=readOnly ? "disabled" : ""%>
                        value="<%=ejercicio.getEspecificaciones().isEmpty() ? "" : ejercicio.getEspecificaciones().get(tiposBase.get(i)).getAsString()%>"
                        id="especificacion<%=i%>"
                        type="number"
                        max="999999"
                        autocomplete="off"
                        class="form-control mt-2"/>
            </div>
        </div>
    <%}%>

    <%if (!readOnly) {%>
        <div class="row">
            <div class="col-12 d-flex justify-content-end">
                <button class="btn btn-primary"
                onClick="goGuardarEjercicio()"><%=ejercicioExists ? "Guardar" : "Añadir"%></button>
            </div>
        </div>
    <%}%>
</div>
<script>
    function goVolverEditarSesion() {
        window.location.href = "/entrenador/rutinas/sesion/editar";
    }

    function goVolverVerSesion() {
        window.location.href = "/entrenador/rutinas/sesion/ver?id=<%=sesion.getId()%>";
    }

    function doVolverToSeleccionar() {
        window.location.href = "/entrenador/rutinas/ejercicio/volver?ejpos=<%=ejercicioPos%>";
    }

    function goGuardarEjercicio() {
        const especificaciones = {
            <%for(int i = 0; i < tiposBase.size(); i++) {%>
            '<%=tiposBase.get(i)%>': document.getElementById("especificacion<%=i%>").value,
            <%}%>
        }

        const especificacionesJSON = encodeURIComponent(JSON.stringify(especificaciones));

        window.location.href = "/entrenador/rutinas/ejercicio/guardar?especificaciones="
            + especificacionesJSON + "&ejpos=<%=ejercicioPos%>";
    }
</script>
</body>
</html>
