<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.example.GymWebAppSpring.entity.Dificultad" %>
<%@ page import="com.example.GymWebAppSpring.iu.FiltroArgument" %><%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Rutina> rutinas = (List<Rutina>) request.getAttribute("rutinas");
    List<Dificultad> dificultades = (List<Dificultad>) request.getAttribute("dificultades");
    FiltroArgument filtro = (FiltroArgument) request.getAttribute("filtro");
    boolean isFiltering = !filtro.estaVacio();
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
                <form:form action="/entrenador/rutinas/filtrar" method="get" modelAttribute="filtro">
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-3 d-flex align-items-center">
                                <label for="nombre-rutina" class="form-label">Nombre de la rutina</label>
                            </div>
                            <div class="col-9 d-flex align-items-center">
                                <form:input path="nombre" type="text" class="form-control" id="nombre-rutina" placeholder="Nombre de la rutina"/>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-3 d-flex align-items-center">
                                <label for="num-sesiones" class="form-label">Número de sesiones</label>
                            </div>
                            <div class="col-4 d-flex align-items-center">
                                <form:select path="sesionMode" class="form-select" id="num-sesiones">
                                    <form:option value="-1">No seleccionado</form:option>
                                    <form:option value="1">Igual</form:option>
                                    <form:option value="2">Mayor o igual</form:option>
                                    <form:option value="3">Menor o igual</form:option>
                                </form:select>
                            </div>
                            <div class="col-1 d-flex justify-content-center align-items-center">
                                <span>a</span>
                            </div>
                            <div class="col-4 d-flex align-items-center">
                                <form:input path="sesionNum" type="text" class="form-control" id="num-sesiones-valor" placeholder="Número"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-3 d-flex align-items-center">
                                <label for="dificultad" class="form-label">Dificultad</label>
                            </div>
                            <div class="col-9 d-flex align-items-center">
                                <form:select path="dificultad" class="form-select" id="dificultad">
                                    <form:option value="-1">No seleccionado</form:option>
                                    <%for(Dificultad dificultad : dificultades) {%>
                                    <form:option value="<%=dificultad.getId()%>"><%=dificultad.getNombre()%></form:option>
                                    <%}%>
                                </form:select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <form:button class="btn btn-primary">Aplicar</form:button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>


    <div class="container">
        <div class="row">
            <div class="col-4">
                <div class="d-flex align-items-center">
                    <h1 class="me-3">Tus rutinas</h1>
                </div>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#filter-modal" >Filtros de búsqueda</button>
                    <a class="btn btn-primary" href="/entrenador/rutinas/crear">Crear nueva rutina</a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12 d-flex align-items-center">
                <%if (isFiltering) {
                    if (!filtro.getNombre().isEmpty()) {%>
                    <span class="border border-secondary rounded me-2"
                          style="padding: 6px 12px">Nombre: <%=filtro.getNombre()%></span>
                    <%}
                    if (!filtro.getSesionNum().isEmpty()) {
                    String simbolo = filtro.getSesionMode() == 0 ? "=" : (filtro.getSesionMode() == 1 ? "<=" : "=>");%>
                    <span class="border border-secondary rounded me-2"
                          style="padding: 6px 12px">Nºsesiones <%=simbolo%> <%=filtro.getIntegerSesionNum()%></span>
                    <%}
                    if (filtro.getDificultad() != -1) {%>
                    <span class="border border-secondary rounded me-2"
                          style="padding: 6px 12px">Dificultad: ${dificultades.get(filtro.dificultad - 1).nombre}</span>
                    <%}%>
                <a href="/entrenador/rutinas" class="btn btn-outline-danger">
                    <i class="bi bi-x-lg me-2"></i>
                    <span class="d-sm-inline d-none">Eliminar filtros</span>
                </a>
                <%}%>
            </div>
        </div>
        <%
            if (rutinas.isEmpty()) {%>
                <div class="d-flex justify-content-center align-items-center mt-3">
                    <h3 class="alert alert-danger">
                        <%=isFiltering
                            ? "No se encontró ningun resultado. Prueba a cambiar el filtro..."
                            : "Vaya, parece que aún no has creado ninguna rutina... ¿A qué esperas?"%>
                    </h3>
                </div>
        <%}

            for (Rutina rutina : rutinas) {
        %>
            <div class="row">
                <a class="col-9 d-flex align-items-center" style="height:75px; text-decoration: none; cursor: pointer;"
                     href="/entrenador/rutinas/ver?id=<%= rutina.getId() %>">
                    <img src="<%=rutina.getDificultad().getLogo()%>" alt="Dificultad" style="width:50px; height:50px">
                    <div class="ms-3">
                        <span class="h2" style="color: black;"><%=rutina.getNombre()%></span><br>
                        <span class="h5 text-secondary"><%=rutina.getDescripcion()%></span>
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
