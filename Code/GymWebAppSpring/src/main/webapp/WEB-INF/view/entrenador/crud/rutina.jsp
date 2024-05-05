<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="com.example.GymWebAppSpring.entity.Dificultad" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionentrenamiento" %>
<%@ page import="com.example.GymWebAppSpring.iu.RutinaArgument" %>
<%@ page import="com.example.GymWebAppSpring.iu.SesionArgument" %>
<%@ page import="com.google.gson.Gson" %><%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%
    Gson gson = new Gson();
    String cache = (String) request.getAttribute("cache");
    RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);

    Object readOnlyObject = request.getAttribute("readOnly");
    boolean rutinaExists = rutina.getId() >= 0;
    boolean readOnly = readOnlyObject != null && ((Boolean) readOnlyObject) && rutinaExists;

    String nombre = "";
    String descripcion = "";
    Integer dificultad = -1;
    List<SesionArgument> sesiones = new ArrayList<>();
    if (rutinaExists) {
        nombre = rutina.getNombre();
        descripcion = rutina.getDescripcion();
        dificultad = rutina.getDificultad();
        sesiones = rutina.getSesiones();
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
    <script>
        const cache = <%=cache%>;
        console.log(cache);
    </script>
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
    <div class="modal fade" id="delete-modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="delete-modal-label">Eliminar sesión</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="delete-modal-body">
                    ¿Estás seguro de que quieres eliminar la sesion?
                </div>
                <div class="modal-footer">
                    <button id="delete-modal-button" type="button" class="btn btn-danger">Eliminar</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <input id="rutinaId" type="hidden" name="id" value="<%=rutina.getId()%>"/>
         <div class="row mb-3">
            <div class="col-4">
                <h1>Crear nueva rutina</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <a href="/entrenador/rutinas" class="btn btn-primary">Volver</a>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-6">
                <span class="h4 text-secondary">Nombre de la rutina</span><br/>
                <input id="nombre" name="nombre" value="<%=nombre%>" type="text" class="form-control mt-2" <%=readOnly ? "disabled" : ""%>>
            </div>
            <div class="col-6">
                <span class="h4 text-secondary">Dificultad</span><br/>
                <select id="dificultad" name="dificultad" class="form-select mt-2" id="dificultad" <%=readOnly ? "disabled" : ""%>>
                    <option <%=rutinaExists && dificultad == 1 ? "selected" : ""%> value="1">Principiante</option>
                    <option <%=rutinaExists && dificultad == 2 ? "selected" : ""%> value="2">Intermedio</option>
                    <option <%=rutinaExists && dificultad == 3 ? "selected" : ""%> value="3">Avanzado</option>
                </select>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-12">
                <span class="h4 text-secondary">Descripción de la rutina</span><br/>
                <textarea id="descripcion" name="descripcion" class="form-control mt-2" style="resize:none;" rows="3" <%=readOnly ? "disabled" : ""%>><%=descripcion%></textarea>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-6">
                <span class="h4 text-secondary">Sesiones de entrenamiento</span><br/>
            </div>
            <%if (!readOnly) {%>
                <div class="col-6 d-flex justify-content-end">
                    <button class="btn btn-primary" onClick="enviarJSON('/entrenador/rutinas/crear/sesion')">Añadir sesión de entrenamiento</button>
                </div>
            <%}%>
        </div>
        <%
            for (int i = 0 ; i< sesiones.size(); i++) {
        %>
            <div class="row">
                <div class="col-9 d-flex align-items-center" style="height:75px; text-decoration: none; cursor: pointer;"
                     onClick="enviarJSON('/entrenador/rutinas/crear/sesion/ver', 'pos=<%= i %>')">
                    <img src="/svg/question-square.svg" alt="Borrar" style="width:50px; height:50px">
                    <span class="ms-3 h2 mb-0" style="color: black;"><%=sesiones.get(i).getNombre()%></span>
                </div>
                <%if (!readOnly) {%>
                    <div class="col-3 d-flex justify-content-end align-items-center">
                        <div onClick="enviarJSON('/entrenador/rutinas/crear/sesion/editar', 'pos=<%= i %>')" style="cursor: pointer; text-decoration: none;">
                            <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px;">&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                        <div style="cursor: pointer;" onclick="showDeleteModal('<%=sesiones.get(i).getNombre()%>', '<%= i %>')">
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
                    <button onClick="enviarJSON('/entrenador/rutinas/guardar');" class="btn btn-primary"><%=rutinaExists ? "Guardar" : "Crear"%></button>
                </div>
            </div>
        <%}%>
    </div>
<script>
    function enviarJSON(action, additionalParams="") {
        cache.id = document.getElementById("rutinaId").value;
        cache.nombre = document.getElementById("nombre").value;
        cache.dificultad = document.getElementById("dificultad").value;
        cache.descripcion = document.getElementById("descripcion").value;

        var newCache = encodeURIComponent(JSON.stringify(cache));

        window.location.href =
            action + "?cache=" + newCache + (additionalParams.length > 0 ? "&" : "") + additionalParams;
    }

    function showDeleteModal(nombre, pos) {
        const deleteModal = new bootstrap.Modal(document.getElementById('delete-modal'));
        const modalBody = document.getElementById("delete-modal-body");
        const modalButton = document.getElementById("delete-modal-button");

        modalBody.innerHTML = `¿Estás seguro de que quieres eliminar la sesión <b>` + nombre + `</b>?`;
        modalButton.onclick = () => { enviarJSON('/entrenador/rutinas/crear/sesion/borrar', 'pos=' + pos) };

        deleteModal.show();
    }
</script>
</body>
</html>
