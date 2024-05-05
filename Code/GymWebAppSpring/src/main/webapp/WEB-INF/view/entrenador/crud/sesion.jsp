<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.iu.SesionArgument" %>
<%@ page import="com.example.GymWebAppSpring.iu.RutinaArgument" %>
<%@ page import="com.google.gson.Gson" %>
<%--
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
    boolean sesionExists = sesionPos >= 0;

    Object readOnlyObject = request.getAttribute("readOnly");
    boolean readOnly = readOnlyObject != null && ((Boolean) readOnlyObject);

    SesionArgument sesion;
    if (sesionExists)  sesion = rutina.getSesiones().get(sesionPos);
    else {
        sesion = new SesionArgument();
        sesion.setId(-1);

        sesionPos = rutina.getSesiones().size();
    }
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
<script>
    const cache = <%=cache%>;
</script>
<body>
<jsp:include page="../../components/header.jsp"/>
    <div class="modal fade" id="delete-modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="delete-modal-label">Eliminar ejercicio</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="delete-modal-body">
                    ¿Estás seguro de que quieres eliminar el ejercicio?
                </div>
                <div class="modal-footer">
                    <button id="delete-modal-button" type="button" class="btn btn-danger" data-bs-dismiss="modal">Eliminar</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <input id="sesionId" type="hidden" name="id" value="<%=sesion.getId()%>"/>
        <div class="row mb-3">
            <div class="col-8">
                <h1>Añadir sesión de entrenamiento</h1>
            </div>
            <div class="col-4 d-flex justify-content-end align-items-center">
                <button onClick="enviarJSON('/entrenador/rutinas/' + <%=(readOnly ? "'ver'" : "'crear'")%>, save = false)"
                        class="btn btn-primary">Volver</button>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-12">
                <span class="h4 text-secondary">Nombre de la sesión</span><br/>
            </div>
            <div class="col-12">
                <input id="nombre" type="text" class="form-control mt-2" value="<%=sesion.getNombre()%>" <%=readOnly ? "disabled" : ""%>>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-12">
                <span class="h4 text-secondary">Descripción de la sesión</span><br/>
                <textarea id="descripcion" class="form-control mt-2" style="resize:none;" rows="3" <%=readOnly ? "disabled" : ""%>><%=sesion.getDescripcion()%></textarea>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-6">
                <span class="h4 text-secondary">Ejercicios</span><br/>
            </div>
            <%if (!readOnly) {%>
                <div class="col-6 d-flex justify-content-end">
                    <a class="btn btn-primary" href="/entrenador/rutinas/crear/ejercicio/seleccionar">Añadir ejercicio</a>
                </div>
            <%}%>
        </div>
        <%
            for (Integer ejercicio : new ArrayList<Integer>()) {
        %>
            <div class="row">
                <div class="col-9 d-flex align-items-center" style="height:75px">
                    <img src="/svg/question-square.svg" alt="Borrar" style="width:50px; height:50px">
                    <div>
                        <span class="ms-3 h2">Ejercicio <%=ejercicio%></span></br>
                        <span class="ms-3 h5 text-secondary">Repeticiones: X. Series: X. Descanso: X....</span>
                    </div>
                </div>
                <%if (!readOnly) {%>
                    <div class="col-3 d-flex justify-content-end align-items-center">
                        <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px">&nbsp;&nbsp;&nbsp;&nbsp;
                        <div data-bs-toggle="modal" data-bs-target="#delete-modal" style="cursor: pointer;">
                            <img src="/svg/trash.svg" alt="Borrar" style="width:50px; height:50px">
                        </div>
                    </div>
                <%}%>
            </div>
            <hr>
        <%
            }
        %>

        <%if (!readOnly) {%>
            <div class="row">
                <div class="col-12 d-flex justify-content-end">
                    <button onClick="enviarJSON('/entrenador/rutinas/crear')" type="submit" class="btn btn-primary"><%=sesionExists ? "Guardar" : "Crear"%></button>
                </div>
            </div>
        <%}%>
    </div>
<script>
    console.log(cache);
    function enviarJSON(action, save=true, additionalParams="") {
        if (save) {
            const sesionJSON = {
                "id": document.getElementById("sesionId").value,
                "nombre": document.getElementById("nombre").value,
                "descripcion": document.getElementById("descripcion").value
            }
            cache.sesiones[<%=sesionPos%>] = sesionJSON;
        }

        const cacheString = encodeURIComponent(JSON.stringify(cache));

        window.location.href =
            action + "?cache=" + cacheString + (additionalParams.length > 0 ? "&" : "") + additionalParams;
    }
</script>
</body>
</html>
