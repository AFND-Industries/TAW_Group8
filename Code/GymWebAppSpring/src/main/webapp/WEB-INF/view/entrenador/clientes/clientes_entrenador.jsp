<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.GymWebAppSpring.dto.UsuarioDTO" %>
<%@ page import="com.example.GymWebAppSpring.iu.FiltroClientesEntrenadorArgument" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 22/04/2024
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<UsuarioDTO> clientes = (List<UsuarioDTO>) request.getAttribute("clientes");
    FiltroClientesEntrenadorArgument filtro = (FiltroClientesEntrenadorArgument) request.getAttribute("filtro");
%>
<html>
<head>
    <title>Tus Clientes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .demo-preview {
            padding-top: 60px;
            padding-bottom: 10px;
            margin: auto;
            text-align: center;
        }

        .demo-preview .badge {
            margin-right: 10px;
        }

        .badge {
            display: inline-block;
            font-size: 11px;
            font-weight: 600;
            padding: 3px 6px;
            border: 1px solid transparent;
            min-width: 10px;
            line-height: 1;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            border-radius: 99999px
        }

        .badge.badge-default {
            background-color: #B0BEC5
        }

        .badge.badge-primary {
            background-color: #2196F3
        }

        .badge.badge-secondary {
            background-color: #323a45
        }

        .badge.badge-success {
            background-color: #64DD17
        }

        .badge.badge-warning {
            background-color: #FFD600
        }

        .badge.badge-info {
            background-color: #29B6F6
        }

        .badge.badge-danger {
            background-color: #ef1c1c
        }

        .badge.badge-outlined {
            background-color: transparent
        }

        .badge.badge-outlined.badge-default {
            border-color: #B0BEC5;
            color: #B0BEC5
        }

        .badge.badge-outlined.badge-primary {
            border-color: #2196F3;
            color: #2196F3
        }

        .badge.badge-outlined.badge-secondary {
            border-color: #323a45;
            color: #323a45
        }

        .badge.badge-outlined.badge-success {
            border-color: #64DD17;
            color: #64DD17
        }

        .badge.badge-outlined.badge-warning {
            border-color: #FFD600;
            color: #FFD600
        }

        .badge.badge-outlined.badge-info {
            border-color: #29B6F6;
            color: #29B6F6
        }

        .badge.badge-outlined.badge-danger {
            border-color: #ef1c1c;
            color: #ef1c1c
        }

        .btn-close::after {
            background-color: #2196F3; /* Color de la cruz */
        }
    </style>
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
<div class="modal fade" id="filter-modal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Filtros de búsqueda</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form:form method="post" action="/entrenador/clientes/rutinas/clientesFilter" modelAttribute="filtro">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-3 d-flex align-items-center">
                            <label for="nombre-cliente" class="form-label">Nombre del cliente</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <form:input path="nombre" class="form-control" id="nombre-cliente" name="nombreCliente"
                                        placeholder="Nombre del cliente"/>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-3 d-flex align-items-center">
                            <label for="apellidos-cliente" class="form-label">Apellidos del cliente</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <form:input path="apellidos" class="form-control" id="apellidos-cliente"
                                        name="apellidosCliente"
                                        placeholder="Apellidos del cliente"/>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-3 d-flex align-items-center">
                            <label for="edad" class="form-label">Edad</label>
                        </div>
                        <div class="col-4 d-flex align-items-center">
                            <form:select path="edadMode" class="form-select" id="edad" name="edad">
                                <form:option value="4">No seleccionado</form:option>
                                <form:option value="1">Igual</form:option>
                                <form:option value="2">Mayor</form:option>
                                <form:option value="3">Menor</form:option>
                            </form:select>
                        </div>
                        <div class="col-1 d-flex justify-content-center align-items-center">
                            <span>a</span>
                        </div>
                        <div class="col-4 d-flex align-items-center">
                            <form:input path="edad" type="text" class="form-control" id="num-edad"
                                        name="numEdad"
                                        placeholder="Número"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3 d-flex align-items-center">
                            <label for="genero" class="form-label">Genero</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <form:select path="genero" class="form-select" id="genero" name="genero">
                                <form:option value="N">No seleccionado</form:option>
                                <form:option value="M">Masculino</form:option>
                                <form:option value="F">Femenino</form:option>
                            </form:select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <form:button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</form:button>
                    <form:button type="submit" class="btn btn-primary">Aplicar</form:button>
                </div>
            </form:form>
        </div>
    </div>
</div>
<div class="container">
    <div class="row mb-4">
        <div class="col-4">
            <h1>Tus clientes</h1>
        </div>
        <div class="col-8 d-flex justify-content-end align-items-center">
            <%
                if (!filtro.estaVacio()) {
                    if (!filtro.getNombre().isEmpty()) {
            %>
            <div class="me-3">
                <span class="badge badge-primary badge-outlined d-flex align-items-center">
                    Nombre: <%= filtro.getNombre() %> &nbsp;
                   <div>
                         <form id="remove-nombre-form" action="/entrenador/clientes/rutinas/eliminarFiltroClientes"
                               method="post"
                               style="display: inline">
                         <input type="hidden" name="nombre" value="">
                         <input type="hidden" name="apellidos" value="<%= filtro.getApellidos() %>">
                         <input type="hidden" name="edad" value="<%= filtro.getEdad()%>">
                         <input type="hidden" name="edadMode" value="<%= filtro.getEdadMode()%>">
                         <input type="hidden" name="genero" value="<%= filtro.getGenero()%>">
                         <a class="fs-5" href="javascript:void(0);"
                            onclick="document.getElementById('remove-nombre-form').submit();">
                            <i class="bi bi-x" style="color: #29B6F6"></i>
                         </a>
                     </form>
                     </div>
                </span>

            </div>
            <% }
                if (!filtro.getApellidos().isEmpty()) {
            %>
            <div class="me-3">
                <span class="badge badge-primary badge-outlined d-flex align-items-center">
                    Apellidos: <%= filtro.getApellidos() %> &nbsp;
                   <div>
                         <form id="remove-apellidos-form" action="/entrenador/clientes/rutinas/eliminarFiltroClientes"
                               method="post"
                               style="display: inline">
                         <input type="hidden" name="nombre" value="<%= filtro.getNombre() %>">
                         <input type="hidden" name="apellidos" value="">
                         <input type="hidden" name="edad" value="<%= filtro.getEdad()%>">
                         <input type="hidden" name="edadMode" value="<%= filtro.getEdadMode()%>">
                         <input type="hidden" name="genero" value="<%= filtro.getGenero()%>">
                         <a class="fs-5" href="javascript:void(0);"
                            onclick="document.getElementById('remove-apellidos-form').submit();">
                            <i class="bi bi-x" style="color: #29B6F6"></i>
                         </a>
                     </form>
                     </div>
                </span>

            </div>
            <% }
                if (filtro.getEdadMode() != 4 && !(filtro.getEdad() == -1)) { %>
            <div class="me-3">
                <span class="badge badge-primary badge-outlined d-flex align-items-center">
                    Edad: <%if (filtro.getEdadMode() == 1) {%> Igual a <%} else if (filtro.getEdadMode() == 2) {%> Mayor a <%} else {%> Menor a <%}%> <%= filtro.getEdad() %> &nbsp;
                    <div>
                         <form id="remove-edad-form" action="/entrenador/clientes/rutinas/eliminarFiltroClientes"
                               method="post"
                               style="display: inline">
                         <input type="hidden" name="nombre" value="<%= filtro.getNombre() %>">
                         <input type="hidden" name="apellidos" value="<%= filtro.getApellidos() %>">
                         <input type="hidden" name="edad" value="">
                         <input type="hidden" name="edadMode" value="<%= filtro.getEdadMode()%>">
                         <input type="hidden" name="genero" value="<%= filtro.getGenero()%>">
                         <a class="fs-5" href="javascript:void(0);"
                            onclick="document.getElementById('remove-edad-form').submit();">
                            <i class="bi bi-x" style="color: #29B6F6"></i>
                         </a>
                     </form>
                     </div>
                </span>
            </div>
            <%
                }
                if (filtro.getGenero() != 'N') { %>
            <div class="me-3">
                <span class="badge badge-primary badge-outlined d-flex align-items-center">
                    Genero: <%if (filtro.getGenero() == 'M') {%> Masculino <%} else {%> Femenino <%}%> &nbsp;
                     <div>
                         <form id="remove-genero-form" action="/entrenador/clientes/rutinas/eliminarFiltroClientes"
                               method="post"
                               style="display: inline">
                         <input type="hidden" name="nombre" value="<%= filtro.getNombre() %>">
                         <input type="hidden" name="apellidos" value="<%= filtro.getApellidos() %>">
                         <input type="hidden" name="edad" value="<%= filtro.getEdad() %>">
                         <input type="hidden" name="edadMode" value="<%= filtro.getEdadMode()%>">
                         <input type="hidden" name="genero" value="N">
                         <a class="fs-5" href="javascript:void(0);"
                            onclick="document.getElementById('remove-genero-form').submit();">
                            <i class="bi bi-x" style="color: #29B6F6"></i>
                         </a>
                     </form>
                     </div>
                </span>
            </div>
            <%
                    }
                }
            %>
            <div data-bs-toggle="modal" data-bs-target="#filter-modal">
                <a class="btn btn-primary">Filtros de
                    búsqueda
                </a>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <%
        for (UsuarioDTO cliente : clientes) {
    %>
    <div class="row">
        <div class="col-8 d-flex align-items-center">
            <i class="bi bi-person-square" style="font-size: 40px"></i>
            <a class="btn ms-3" style="font-size: 20px; border: transparent"
               href="/entrenador/clientes/rutinas?id=<%= cliente.getId()%>"><%= cliente.getNombre() %> <%= cliente.getApellidos() %>
            </a>
        </div>
    </div>
    <hr>
    <%
        }
    %>
</div>
<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
