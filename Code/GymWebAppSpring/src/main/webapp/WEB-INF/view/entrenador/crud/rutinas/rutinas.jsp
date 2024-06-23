<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.iu.FiltroArgument" %>
<%@ page import="com.example.GymWebAppSpring.dto.RutinaDTO" %>
<%@ page import="com.example.GymWebAppSpring.dto.DificultadDTO" %>
<%--
  Created by IntelliJ IDEA.
  User: Eulogio Quemada
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<RutinaDTO> rutinas = (List<RutinaDTO>) request.getAttribute("rutinas");
    List<DificultadDTO> dificultades = (List<DificultadDTO>) request.getAttribute("dificultades");

    String changedName = (String) request.getAttribute("changedName");
    Integer changedCase = (Integer) request.getAttribute("changedCase");

    FiltroArgument filtro = (FiltroArgument) request.getAttribute("filtro");
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
        const changedName = '<%=changedName%>';
        const changedCase = <%=changedCase%>;
    </script>
</head>
<body>

<jsp:include page="../../../components/header.jsp"/>
<jsp:include page="./components/recover_modal.jsp"/>
<jsp:include page="./components/modif_toast.jsp"/>

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
                <form action="/entrenador/rutinas/rutina/borrar" method="post">
                    <input id="delete-modal-id" type="hidden" name="id" value=""/>
                    <input type="submit" class="btn btn-danger" value="Eliminar"/>
                </form>
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
                            <form:input path="sesionNum" type="number" class="form-control" id="num-sesiones-valor" placeholder="Número"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3 d-flex align-items-center">
                            <label for="dificultad" class="form-label">Dificultad</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <form:select path="dificultad" class="form-select" id="dificultad">
                                <form:option value="-1">No seleccionado</form:option>
                                <%for(DificultadDTO dificultad : dificultades) {%>
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

<div class="container mb-5">
    <div class="row">
        <div class="col-4">
            <div class="d-flex align-items-center">
                <h1 class="me-3">Tus rutinas</h1>
            </div>
        </div>
        <div class="col-8 d-flex justify-content-end align-items-center">
            <div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#filter-modal" >Filtros de búsqueda</button>
                <a class="btn btn-primary" href="/entrenador/rutinas/rutina/crear">Crear nueva rutina</a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12 d-flex align-items-center">
            <%if (!filtro.estaVacio()) {
                if (!filtro.getNombre().isEmpty()) {%>
                <form action="/entrenador/rutinas/filtrar" class="mb-0">
                    <input type="hidden" name="nombre" value=""/>
                    <input type="hidden" name="sesionMode" value="<%=filtro.getSesionMode()%>"/>
                    <input type="hidden" name="sesionNum" value="<%=filtro.getSesionNum()%>"/>
                    <input type="hidden" name="dificultad" value="<%=filtro.getDificultad()%>"/>
                    <button type="submit" class="btn btn-outline-secondary me-2"
                            style="padding: 6px 12px">
                        <i class="bi bi-x-lg me-2"></i>
                        Nombre: <%=filtro.getNombre()%>
                    </button>
                </form>
                <%}
                if (!filtro.getSesionNum().isEmpty()) {
                String simbolo = filtro.getSesionMode() == 0 ? "=" : (filtro.getSesionMode() == 1 ? "<=" : "=>");%>
                <form action="/entrenador/rutinas/filtrar" class="mb-0">
                    <input type="hidden" name="nombre" value="<%=filtro.getNombre()%>"/>
                    <input type="hidden" name="sesionMode" value="-1"/>
                    <input type="hidden" name="sesionNum" value=""/>
                    <input type="hidden" name="dificultad" value="<%=filtro.getDificultad()%>"/>
                    <button type="submit" class="btn btn-outline-secondary me-2"
                            style="padding: 6px 12px">
                        <i class="bi bi-x-lg me-2"></i>
                        Nºsesiones <%=simbolo%> <%=filtro.getIntegerSesionNum()%>
                    </button>
                </form>
                <%}
                if (filtro.getDificultad() != -1) {%>
                <form action="/entrenador/rutinas/filtrar" class="mb-0">
                    <input type="hidden" name="nombre" value="<%=filtro.getNombre()%>"/>
                    <input type="hidden" name="sesionMode" value="<%=filtro.getSesionMode()%>"/>
                    <input type="hidden" name="sesionNum" value="<%=filtro.getSesionNum()%>"/>
                    <input type="hidden" name="dificultad" value="-1"/>
                    <button type="submit" class="btn btn-outline-secondary me-2"
                           style="padding: 6px 12px">
                        <i class="bi bi-x-lg me-2"></i>
                        Dificultad: ${dificultades.get(filtro.dificultad - 1).nombre}
                    </button>
                </form>
                <%}%>
            <a href="/entrenador/rutinas" class="btn btn-outline-danger">
                <i class="bi bi-x-lg me-2"></i>
                <span class="d-sm-inline d-none">Eliminar todos los filtros</span>
            </a>
            <%}%>
        </div>
    </div>
    <%if (rutinas.isEmpty()) {%>
        <div class="d-flex justify-content-center align-items-center mt-3">
            <h3 class="alert alert-danger">
                <%=!filtro.estaVacio()
                    ? "No se encontró ningun resultado. Prueba a cambiar el filtro..."
                    : "Vaya, parece que aún no has creado ninguna rutina... ¿A qué esperas?"%>
            </h3>
        </div>
    <%}

    for (RutinaDTO rutina : rutinas) { %>
        <jsp:include page="components/rutina_item.jsp" >
            <jsp:param name="id" value="<%=rutina.getId()%>" />
            <jsp:param name="logo" value="<%=rutina.getDificultad().getLogo()%>" />
            <jsp:param name="nombre" value="<%=rutina.getNombre()%>" />
            <jsp:param name="descripcion" value="<%=rutina.getDescripcion()%>" />
        </jsp:include>
    <%}%>
</div>
<script>
    function showDeleteModal(nombre, id) {
        const deleteModal = new bootstrap.Modal(document.getElementById('delete-modal'));
        const modalBody = document.getElementById("delete-modal-body");
        const deleteModalId = document.getElementById("delete-modal-id");

        modalBody.innerHTML = `¿Estás seguro de que quieres eliminar la rutina <b>` + nombre + `</b>?`;
        deleteModalId.value = id;

        deleteModal.show();
    }

    function showToast(titulo, mensaje) {
        const toastTitle = document.getElementById('toast-title');
        const toastBody = document.getElementById('toast-body');
        const toastLiveExample = document.getElementById('liveToast');
        const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)

        toastTitle.innerHTML = titulo;
        toastBody.innerHTML = mensaje;

        toastBootstrap.show();
    }

    function showRecuperarModal() {
        const recoverModalElement = document.getElementById('recover-modal');
        const recoverModal = new bootstrap.Modal(recoverModalElement, {
            backdrop: 'static',
            keyboard: false
        });

        recoverModal.show();
    }

    if (changedCase === 0)
        showToast('Rutina creada correctamente', 'Has <b>creado</b> la rutina <b>' + changedName + '</b> correctamente.');
    else if (changedCase === 1)
        showToast('Rutina editada correctamente', 'Has <b>editado</b> la rutina <b>' + changedName + '</b> correctamente.');
    else if (changedCase === 2)
        showToast('Rutina borrado correctamente', 'Has <b>borrado</b> la rutina <b>' + changedName + '</b> correctamente.');

    if (<%=session.getAttribute("cache") != null && ((boolean) session.getAttribute("recover"))%>)
        showRecuperarModal();
</script>
</body>
</html>
