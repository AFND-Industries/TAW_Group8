<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Ejercicio" %>
<%@ page import="com.google.gson.Gson" %><%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Gson gson = new Gson();
    String cache = (String) request.getAttribute("cache");
    Integer sesionPos = (Integer) request.getAttribute("sesionPos");
    Integer ejercicioPos = (Integer) request.getAttribute("ejercicioPos");
    Ejercicio ejercicioBase = (Ejercicio) request.getAttribute("ejercicioBase");

    List<String> tiposBase = gson.fromJson(ejercicioBase.getCategoria().getTiposBase(), ArrayList.class);

    String oldSesion = (String) request.getAttribute("oldSesion");
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
        const cache = <%=cache%>;
        const oldSesion = <%=oldSesion%>;
    </script>
</head>
<body>
<jsp:include page="../../components/header.jsp"/>

    <div class="container">
        <div class="row mb-3">
            <div class="col-4">
                <h1>Añadir ejercicio</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <button class="btn btn-primary" onClick="enviarJSON('/entrenador/rutinas/crear/ejercicio/seleccionar', save=false)">Volver</button>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-6">
                <span class="h3 text-dark">Ejercicio X (Categoría X)</span><br/>
            </div>
        </div>
        <%for (String tipoBase : tiposBase) {%>
            <div class="row mb-3 d-flex align-items-center">
                <div class="col-4">
                    <span id="<%=tipoBase%>" class="h4 text-secondary"><%=tipoBase%></span><br/>
                </div>
                <div class="col-3">
                    <input type="text" class="form-control mt-2">
                </div>
            </div>
        <%}%>

        <div class="row">
            <div class="col-12 d-flex justify-content-end">
                <button class="btn btn-primary"
                onClick="enviarJson('/entrenador/rutinas/crear/sesion')">Añadir</button>
            </div>
        </div>
    </div>
<script>
    console.log(cache);

    function enviarJSON(action, save=true, additionalParams="") {
        if (save) {
            cache.sesiones[<%=sesionPos%>],ejercicios[<%=ejercicioPos%>] = {
                "ejercicio": <%=ejercicioBase.getId()%>,
                "especificaciones": {
                    <%for(String tipoBase : tiposBase) {%>
                    "<%=tipoBase%>": document.getElementById("<%=tipoBase%>").value,
                    <%}%>
                }
            };
        }

        const cacheString = encodeURIComponent(JSON.stringify(cache));

        window.location.href =
            action + "?cache=" + cacheString + "&oldSesion=" + encodeURIComponent(oldSesion) + "&pos=<%=sesionPos%>"
            + (additionalParams.length > 0 ? "&" : "") + additionalParams;
    }
</script>
</body>
</html>
