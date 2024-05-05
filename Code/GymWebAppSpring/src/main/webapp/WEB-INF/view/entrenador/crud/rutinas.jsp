<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %><%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Rutina> rutinas = (List<Rutina>) request.getAttribute("rutinas");
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
                    <h1 class="modal-title fs-5" id="delete-modal-label">Eliminar rutina</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="delete-modal-body">
                    ¿Estás seguro de que quieres eliminar la rutina?
                </div>
                <div class="modal-footer">
                    <button id="delete-modal-button" type="button" class="btn btn-danger">Eliminar</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="filter-modal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Filtros de búsqueda</h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-3 d-flex align-items-center">
                            <label for="nombre-rutina" class="form-label">Nombre de la rutina</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <input type="text" class="form-control" id="nombre-rutina" placeholder="Nombre de la rutina">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-3 d-flex align-items-center">
                            <label for="num-sesiones" class="form-label">Número de sesiones</label>
                        </div>
                        <div class="col-4 d-flex align-items-center">
                            <select class="form-select" id="num-sesiones">
                                <option value="4">No seleccionado</option>
                                <option value="1">Igual</option>
                                <option value="2">Mayor</option>
                                <option value="3">Menor</option>
                            </select>
                        </div>
                        <div class="col-1 d-flex justify-content-center align-items-center">
                            <span>a</span>
                        </div>
                        <div class="col-4 d-flex align-items-center">
                            <input type="text" class="form-control" id="num-sesiones-valor" placeholder="Número">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3 d-flex align-items-center">
                            <label for="dificultad" class="form-label">Dificultad</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <select class="form-select" id="dificultad">
                                <option value="0">No seleccionado</option>
                                <option value="1">Principiante</option>
                                <option value="2">Intermedio</option>
                                <option value="3">Avanzado</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary">Aplicar</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container">
        <div class="row mb-3">
            <div class="col-4">
                <h1>Tus rutinas</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#filter-modal" >Filtros de búsqueda</button>
                    <a class="btn btn-primary" href="/entrenador/rutinas/crear">Crear nueva rutina</a>
                </div>
            </div>
        </div>
        <%
            for (Rutina rutina : rutinas) {
        %>
            <div class="row">
                <a class="col-9 d-flex align-items-center" style="height:75px; text-decoration: none; cursor: pointer;"
                     href="/entrenador/rutinas/ver?id=<%= rutina.getId() %>">
                    <img src="<%=rutina.getDificultad().getLogo()%>" alt="Dificultad" style="width:50px; height:50px">
                    <div>
                        <span class="ms-3 h2 mb-0" style="color: black;"><%=rutina.getNombre()%></span><br>
                        <span class="ms-3 h5 text-secondary"><%=rutina.getDescripcion()%></span>
                    </div>
                </a>
                <div class="col-3 d-flex justify-content-end align-items-center">
                    <a href="/entrenador/rutinas/editar?id=<%= rutina.getId() %>" style="cursor: pointer; text-decoration: none;">
                        <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px;">&nbsp;&nbsp;&nbsp;&nbsp;
                    </a>
                    <div style="cursor: pointer;" onclick="showDeleteModal('<%=rutina.getNombre()%>', '<%=rutina.getId()%>')">
                        <img src="/svg/trash.svg" alt="Borrar" style="width:50px; height:50px">
                    </div>
                </div>
            </div>
            <hr>
        <%
            }
        %>
    </div>
<script>
    function showDeleteModal(nombre, id) {
        const deleteModal = new bootstrap.Modal(document.getElementById('delete-modal'));
        const modalBody = document.getElementById("delete-modal-body");
        const modalButton = document.getElementById("delete-modal-button");

        modalBody.innerHTML = `¿Estás seguro de que quieres eliminar la rutina <b>` + nombre + `</b>?`;
        modalButton.onclick = () => { window.location.href = `/entrenador/rutinas/borrar?id=` + id; };

        deleteModal.show();
    }
</script>
</body>
</html>
