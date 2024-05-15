<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 24/04/2024
  Time: 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Rutina> rutinasCliente = (List<Rutina>) request.getAttribute("rutinasCliente");
    List<Rutina> rutinas = (List<Rutina>) request.getAttribute("rutinasEntrenador");
    Usuario cliente = (Usuario) session.getAttribute("cliente");
%>
<html>
<head>
    <title>Add Rutina</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.css"
          rel="stylesheet"/>
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
</head>
<body>
<%@include file="../../components/header.jsp" %>
<div class="row m-3">
    <div class="col-md-6">
        <a class="btn btn-outline-secondary" href="/entrenador/clientes/rutinas?id=<%=cliente.getId()%>">
            <i class="bi bi-chevron-left me-2"></i>
            <span class="d-sm-inline d-none">Volver</span>
        </a>
    </div>
</div>
<div class="modal fade" id="filter-modal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Filtros de búsqueda</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-3 d-flex align-items-center">
                            <label for="nombre-rutina" class="form-label">Nombre de la rutina</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <input type="text" class="form-control" id="nombre-rutina" name="nombreRutina"
                                   placeholder="Nombre de la rutina">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-3 d-flex align-items-center">
                            <label for="num-sesiones" class="form-label">Número de sesiones</label>
                        </div>
                        <div class="col-4 d-flex align-items-center">
                            <select class="form-select" id="num-sesiones" name="numSesiones">
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
                            <input type="text" class="form-control" id="num-sesiones-valor" name="numSesionesValor"
                                   placeholder="Número">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3 d-flex align-items-center">
                            <label for="dificultad" class="form-label">Dificultad</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <select class="form-select" id="dificultad" name="dificultad">
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
                    <button type="submit" class="btn btn-primary">Aplicar</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="container">
    <div class="row mb-4">
        <div class="col-4">
            <h1>Tus Rutinas</h1>
        </div>
        <div class="col-8 d-flex justify-content-end align-items-center">
            <div data-bs-toggle="modal" data-bs-target="#filter-modal">
                <a class="btn btn-primary">Filtros de
                    búsqueda
                </a>
            </div>
        </div>
    </div>
    <form method="post" action="/entrenador/clientes/rutinas/guardar">
        <%
            for (Rutina rutina : rutinas) {
        %>
        <div class="row mb-3">
            <div class="form-check">
                <div class="row d-flex justify-content-between">
                    <div class="col">
                        <input class="form-check-input" type="checkbox" name="rutinas" value="<%= rutina.getId() %>"
                               id="<%= rutina.getId() %>">
                        <label class="form-check-label" for="<%= rutina.getId() %>" style="font-size: 20px">
                            <%= rutina.getNombre() %>
                        </label>
                    </div>
                    <div class="col">

                        <input name="dateId_<%=rutina.getId()%>" type="date" class="form-control" placeholder=""
                               aria-label="Example text with button addon" aria-describedby="button-addon1">
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <%
            }
        %>
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <button type="submit" class="btn btn-primary">Guardar Rutinas</button>
            </div>
        </div>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
</script>
</body>
</html>
