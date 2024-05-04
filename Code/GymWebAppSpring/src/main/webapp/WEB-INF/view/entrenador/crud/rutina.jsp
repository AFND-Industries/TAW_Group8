<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="com.example.GymWebAppSpring.entity.Dificultad" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionentrenamiento" %><%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%
    Rutina rutina = (Rutina) request.getAttribute("rutina");
    Object readOnlyObject = request.getAttribute("readOnly");
    boolean rutinaExists = rutina.getId() >= 0;
    boolean readOnly = readOnlyObject != null && ((Boolean) readOnlyObject) && rutinaExists;

    String nombre = "";
    String descripcion = "";
    Dificultad dificultad = null;
    List<Sesionentrenamiento> sesiones = new ArrayList<>();
    if (rutinaExists) {
        nombre = rutina.getNombre();
        descripcion = rutina.getDescripcion();
        dificultad = rutina.getDificultad();
        sesiones = (List<Sesionentrenamiento>) request.getAttribute("sesiones");
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
<body>
<jsp:include page="../../components/header.jsp"/>
    <div class="modal fade" id="delete-modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="delete-modal-label">Eliminar sesión</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Estás seguro de que quieres eliminar la sesión?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Eliminar</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <form action="/entrenador/rutinas/guardar" method="get">
            <input type="hidden" name="id" value="<%=rutina.getId()%>"/>
             <div class="row mb-3">
                <div class="col-4">
                    <h1>Crear nueva rutina</h1>
                </div>
                <div class="col-8 d-flex justify-content-end align-items-center">
                    <a class="btn btn-primary" href="/entrenador/rutinas">Volver</a>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-6">
                    <span class="h4 text-secondary">Nombre de la rutina</span><br/>
                    <input name="nombre" value="<%=nombre%>" type="text" class="form-control mt-2" <%=readOnly ? "disabled" : ""%>>
                </div>
                <div class="col-6">
                    <span class="h4 text-secondary">Dificultad</span><br/>
                    <select name="dificultad" class="form-select mt-2" id="dificultad" <%=readOnly ? "disabled" : ""%>>
                        <option <%=rutinaExists && dificultad.getId() == 1 ? "selected" : ""%> value="1">Principiante</option>
                        <option <%=rutinaExists && dificultad.getId() == 2 ? "selected" : ""%> value="2">Intermedio</option>
                        <option <%=rutinaExists && dificultad.getId() == 3 ? "selected" : ""%> value="3">Avanzado</option>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-12">
                    <span class="h4 text-secondary">Descripción de la rutina</span><br/>
                    <textarea name="descripcion" class="form-control mt-2" style="resize:none;" rows="3" <%=readOnly ? "disabled" : ""%>><%=descripcion%></textarea>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-6">
                    <span class="h4 text-secondary">Sesiones de entrenamiento</span><br/>
                </div>
                <%if (!readOnly) {%>
                    <div class="col-6 d-flex justify-content-end">
                        <a class="btn btn-primary" href="/entrenador/rutinas/crear/sesion">Añadir sesión de entrenamiento</a>
                    </div>
                <%}%>
            </div>
            <%
                for (Sesionentrenamiento sesion : sesiones) {
            %>
                <div class="row">
                    <a class="col-9 d-flex align-items-center" style="height:75px; text-decoration: none; cursor: pointer;"
                         href="/entrenador/rutinas/crear/sesion/ver?id=<%= sesion.getId() %>">
                        <img src="/svg/question-square.svg" alt="Borrar" style="width:50px; height:50px">
                        <span class="ms-3 h2 mb-0" style="color: black;"><%=sesion.getNombre()%></span>
                    </a>
                    <%if (!readOnly) {%>
                        <div class="col-3 d-flex justify-content-end align-items-center">
                            <a href="/entrenador/rutinas/crear/sesion/editar?id=<%= sesion.getId() %>" style="cursor: pointer; text-decoration: none;">
                                <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px;">&nbsp;&nbsp;&nbsp;&nbsp;
                            </a>
                            <div style="cursor: pointer;" onclick="showDeleteModal('<%=sesion.getNombre()%>', '<%=sesion.getId()%>')">
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
                        <input type="submit" class="btn btn-primary" value="<%=rutinaExists ? "Guardar" : "Crear"%>">
                    </div>
                </div>
            <%}%>
        </form>
    </div>
<script>
    function submitForm(action) {
        document.getElementById('rutinaForm').action = action;
        document.getElementById('rutinaForm').submit();
    }

    function showDeleteModal(nombre, id) {
        const deleteModal = new bootstrap.Modal(document.getElementById('delete-modal'));
        const modalBody = document.getElementById("delete-modal-body");
        const modalButton = document.getElementById("delete-modal-button");

        modalBody.innerHTML = `¿Estás seguro de que quieres eliminar la sesión <b>` + nombre + `</b>?`;
        modalButton.onclick = () => { window.location.href = `/entrenador/rutinas/crear/sesion/borrar?id=` + id; };

        deleteModal.show();
    }
</script>
</body>
</html>
