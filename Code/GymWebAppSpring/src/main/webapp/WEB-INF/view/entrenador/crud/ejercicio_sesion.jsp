<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Ejercicio" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.example.GymWebAppSpring.iu.RutinaArgument" %>
<%@ page import="com.example.GymWebAppSpring.iu.EjercicioArgument" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.example.GymWebAppSpring.iu.SesionArgument" %><%--
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
    RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);

    Integer sesionPos = (Integer) request.getAttribute("sesionPos");
    Integer ejercicioPos = (Integer) request.getAttribute("ejercicioPos");
    Ejercicio ejercicioBase = (Ejercicio) request.getAttribute("ejercicioBase");
    String oldSesion = (String) request.getAttribute("oldSesion");
    List<String> tiposBase = gson.fromJson(ejercicioBase.getCategoria().getTiposBase(), ArrayList.class);

    boolean ejercicioExists = ejercicioPos >= 0;
    if (!ejercicioExists)
        ejercicioPos = rutina.getSesiones().get(sesionPos).getEjercicios().size() - 1;

    SesionArgument sesion = rutina.getSesiones().get(sesionPos);
    List<EjercicioArgument> ejercicios = sesion.getEjercicios();
    EjercicioArgument ejercicio = ejercicios.get(ejercicioPos);
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
        console.log(<%=sesion.getEjercicios().size()%>);
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
                <button class="btn btn-primary"
                        onClick="enviarJSON('<%=ejercicioExists ? "/entrenador/rutinas/crear/sesion/editar" : "/entrenador/rutinas/crear/ejercicio/seleccionar"%>', save=false)">Volver</button>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-6">
                <span class="h3 text-dark">Ejercicio X (Categoría X)</span><br/>
            </div>
        </div>
        <%for (int i = 0; i < tiposBase.size(); i++) {%>
            <div class="row mb-3 d-flex align-items-center">
                <div class="col-4">
                    <span class="h4 text-secondary"><%=tiposBase.get(i)%></span><br/>
                </div>
                <div class="col-3">
                    <input value="<%=ejercicio.getEspecificaciones().isEmpty() ? "" : ejercicio.getEspecificaciones().get(i)%>"
                           id="especificacion<%=i%>" type="text" class="form-control mt-2">
                </div>
            </div>
        <%}%>

        <div class="row">
            <div class="col-12 d-flex justify-content-end">
                <button class="btn btn-primary"
                onClick="enviarJSON('/entrenador/rutinas/crear/sesion/editar')"><%=ejercicioExists ? "Guardar" : "Añadir"%></button>
            </div>
        </div>
    </div>
<script>
    console.log(cache);

    function enviarJSON(action, save=true, additionalParams="") {
        if (save) {
            cache.sesiones[<%=sesionPos%>].ejercicios[<%=ejercicioPos%>] = {
                "id": <%=ejercicio.getId()%>,
                "ejercicio": <%=ejercicioBase.getId()%>,
                "especificaciones": [
                    <%for(int i = 0; i < tiposBase.size(); i++) {%>
                        document.getElementById("especificacion<%=i%>").value,
                    <%}%>
                ]
            }
        } else {
            if (!<%=ejercicioExists%>) {
                cache.sesiones[<%=sesionPos%>].ejercicios.splice(<%=ejercicioPos == -1 ? rutina.getSesiones().get(sesionPos).getEjercicios().size() - 1 : ejercicioPos%>, 1);
            }
        }

        const cacheString = encodeURIComponent(JSON.stringify(cache));

        console.log(cache);
        window.location.href =
            action + "?cache=" + cacheString + "&oldSesion=" + encodeURIComponent(oldSesion) + "&pos=<%=sesionPos%>"
            + (additionalParams.length > 0 ? "&" : "") + additionalParams;
    }
</script>
</body>
</html>
