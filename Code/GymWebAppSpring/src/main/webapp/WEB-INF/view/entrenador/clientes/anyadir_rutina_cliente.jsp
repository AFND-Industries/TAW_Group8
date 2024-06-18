<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="java.util.List" %>

<%@ page import="com.example.GymWebAppSpring.iu.FiltroArgument" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionentrenamiento" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonElement" %>
<%@ page import="java.io.Reader" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.example.GymWebAppSpring.util.LocalDateAdapter" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutinacliente" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.GymWebAppSpring.dto.RutinaclienteDTO" %>
<%@ page import="com.example.GymWebAppSpring.dto.RutinaDTO" %>
<%@ page import="com.example.GymWebAppSpring.dto.SesionentrenamientoDTO" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 24/04/2024
  Time: 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<RutinaclienteDTO> rutinasClienteObject = (List<RutinaclienteDTO>) request.getAttribute("rutinasCliente");
    List<RutinaDTO> rutinasCliente = new ArrayList<>();
    for (RutinaclienteDTO rutinacliente : rutinasClienteObject) {
        rutinasCliente.add(rutinacliente.getRutina());
    }
    List<RutinaDTO> rutinas = (List<RutinaDTO>) request.getAttribute("rutinasEntrenador");
    UsuarioDTO cliente = (UsuarioDTO) session.getAttribute("cliente");
    FiltroArgument filtro = (FiltroArgument) request.getAttribute("filtro");
    Map<RutinaDTO, List<SesionentrenamientoDTO>> mapSesiones = (Map<RutinaDTO, List<SesionentrenamientoDTO>>) request.getAttribute("mapSesiones");
    if (filtro == null) {
        filtro = new FiltroArgument();
    }
    String error = (String) request.getAttribute("error");
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
            <form:form method="post" action="/entrenador/clientes/rutinas/anyadirRutinaFilter" modelAttribute="filtro">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-3 d-flex align-items-center">
                            <label for="nombre-rutina" class="form-label">Nombre de la rutina</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <form:input path="nombre" class="form-control" id="nombre-rutina" name="nombreRutina"
                                        placeholder="Nombre de la rutina"/>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-3 d-flex align-items-center">
                            <label for="num-sesiones" class="form-label">Número de sesiones</label>
                        </div>
                        <div class="col-4 d-flex align-items-center">
                            <form:select path="sesionMode" class="form-select" id="num-sesiones" name="numSesiones">
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
                            <form:input path="sesionNum" type="text" class="form-control" id="num-sesiones-valor"
                                        name="numSesionesValor"
                                        placeholder="Número"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3 d-flex align-items-center">
                            <label for="dificultad" class="form-label">Dificultad</label>
                        </div>
                        <div class="col-9 d-flex align-items-center">
                            <form:select path="dificultad" class="form-select" id="dificultad" name="dificultad">
                                <form:option value="0">No seleccionado</form:option>
                                <form:option value="1">Principiante</form:option>
                                <form:option value="2">Intermedio</form:option>
                                <form:option value="3">Avanzado</form:option>
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

<div class="modal fade" id="view-modal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="rutina_title"></h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3">
                    <div class="col-6 ">
                        <span class="h6 text-black">Nombre:</span>
                        <span class="text-secondary" id="rutina_nombre"></span>
                    </div>
                    <div class="col-6 ">
                        <span class="h6 text-black">Dificultad:</span>
                        <span class="text-secondary" id="rutina_Dificultad"></span>
                    </div>
                </div>
                <div class="row mb-3">
                    <span class="h6 text-black">Descripcion:</span>
                    <span class="text-secondary" id="rutina_desc"></span>
                </div>
                <div class="row mb-3">
                    <div class="col-6 ">
                        <span class="h6 text-black">Sesiones:</span>
                        <span class="text-secondary" id="rutina_sesiones"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
	function mostrarRutina(nombre, dificultad, desc, sesiones) {
		document.getElementById('rutina_title').textContent = nombre;
		document.getElementById('rutina_nombre').textContent = nombre;
		document.getElementById('rutina_Dificultad').textContent = dificultad;
		document.getElementById('rutina_desc').textContent = desc;

		const rutinaSesionesContainer = document.getElementById('rutina_sesiones');
		rutinaSesionesContainer.innerHTML = '';

		sesiones.map((sesion, index) => {
			// Create row div
			const rowDiv = document.createElement('div');
			rowDiv.className = 'row my-3';

			// Create column div
			const colDiv = document.createElement('div');
			colDiv.className = 'col-9 d-flex align-items-center';
			colDiv.style.height = '75px';
			colDiv.style.textDecoration = 'none';
			colDiv.style.cursor = 'pointer';
			colDiv.setAttribute('onClick', `goVerSesion(${sesion.id})`);

			// Create inner div for day display
			const innerDiv = document.createElement('div');
			innerDiv.className = 'd-flex flex-column justify-content-center align-items-center';
			innerDiv.style.width = '50px';
			innerDiv.style.height = '50px';

			const spanDay = document.createElement('span');
			spanDay.className = ' h3 mb-0';
			spanDay.textContent = 'Día';

			const spanDayNumber = document.createElement('span');
			spanDayNumber.className = 'h3 mb-0 text-danger';
			spanDayNumber.textContent = sesion.dia;

			innerDiv.appendChild(spanDay);
			innerDiv.appendChild(spanDayNumber);

			// Create description div
			const descDiv = document.createElement('div');
			descDiv.className = 'ms-3';

			const spanName = document.createElement('span');
			spanName.className = 'h6';
			spanName.style.color = 'black';
			spanName.textContent = sesion.nombre;

			const spanDesc = document.createElement('span');
			spanDesc.className = ' text-secondary';
			spanDesc.textContent = sesion.descripcion;

			descDiv.appendChild(spanName);
			descDiv.appendChild(document.createElement('br'));
			descDiv.appendChild(spanDesc);

			// Append all to the column div
			colDiv.appendChild(innerDiv);
			colDiv.appendChild(descDiv);

			// Append the column div to the row div
			rowDiv.appendChild(colDiv);

			// Append the row div to the main container
			rutinaSesionesContainer.appendChild(rowDiv);
		});
	}

	document.addEventListener("DOMContentLoaded", function () {
		var viewIcon = document.querySelectorAll('.view-icon');

		viewIcon.forEach(function (icon) {
			icon.addEventListener('click', function () {
				var nombre = icon.getAttribute('data-rutina-nombre');
				var dificultad = icon.getAttribute('data-rutina-dificultad');
				var desc = icon.getAttribute('data-rutina-desc');
				var sesiones = icon.getAttribute('data-sesiones');
				var sesionesDecoded = JSON.parse(sesiones);
				mostrarRutina(nombre, dificultad, desc, sesionesDecoded);
			});
		});

	})
</script>

<div class="container">
    <div class="row mb-4">
        <% if (!error.equals("")) {%>
        <div class="alert alert-danger">
            <%= error %>
        </div>
        <%}%>
        <div class="col-4">
            <h1>Tus Rutinas</h1>
        </div>
        <div class="col-8 d-flex justify-content-end align-items-center">
            <%
                if (!filtro.estaVacio()) {
                    if (!filtro.getNombre().equals("")) {
            %>
            <div class="me-3">
                <span class="badge badge-primary badge-outlined d-flex align-items-center">
                    Nombre: <%= filtro.getNombre() %> &nbsp;
                   <div>
                         <form id="remove-nombre-form" action="/entrenador/clientes/rutinas/eliminarFiltro"
                               method="post"
                               style="display: inline">
                         <input type="hidden" name="nombre" value="">
                         <input type="hidden" name="sesionMode" value="<%= filtro.getSesionMode() %>">
                         <input type="hidden" name="sesionNum" value="<%= filtro.getSesionNum()%>">
                         <input type="hidden" name="dificultad" value="<%= filtro.getDificultad()%>">
                         <a class="fs-5" href="javascript:void(0);"
                            onclick="document.getElementById('remove-nombre-form').submit();">
                            <i class="bi bi-x" style="color: #29B6F6"></i>
                         </a>
                     </form>
                     </div>
                </span>

            </div>
            <% }
                if (filtro.getSesionMode() != 4 && !filtro.getSesionNum().equals("")) { %>
            <div class="me-3">
                <span class="badge badge-primary badge-outlined d-flex align-items-center">
                    Sesiones: <%if (filtro.getSesionMode() == 1) {%> Igual a <%} else if (filtro.getSesionMode() == 2) {%> Mayor a <%} else {%> Menor a <%}%> <%= filtro.getSesionNum() %> &nbsp;
                    <div>
                         <form id="remove-sesiones-form" action="/entrenador/clientes/rutinas/eliminarFiltro"
                               method="post"
                               style="display: inline">
                         <input type="hidden" name="nombre" value="<%= filtro.getNombre() %>">
                         <input type="hidden" name="sesionMode" value="<%= filtro.getSesionMode() %>">
                         <input type="hidden" name="sesionNum" value="-1">
                         <input type="hidden" name="dificultad" value="<%= filtro.getDificultad()%>">
                         <a class="fs-5" href="javascript:void(0);"
                            onclick="document.getElementById('remove-sesiones-form').submit();">
                            <i class="bi bi-x" style="color: #29B6F6"></i>
                         </a>
                     </form>
                     </div>
                </span>
            </div>
            <%
                }
                if (filtro.getDificultad() != 0) { %>
            <div class="me-3">
                <span class="badge badge-primary badge-outlined d-flex align-items-center">
                    Dificultad: <%if (filtro.getDificultad() == 1) {%> Principiante <%} else if (filtro.getDificultad() == 2) {%> Intermedio <%} else {%> Avanzado <%}%> &nbsp;
                     <div>
                         <form id="remove-difficulty-form" action="/entrenador/clientes/rutinas/eliminarFiltro"
                               method="post"
                               style="display: inline">
                         <input type="hidden" name="nombre" value="<%= filtro.getNombre() %>">
                         <input type="hidden" name="sesionMode" value="<%= filtro.getSesionMode() %>">
                         <input type="hidden" name="sesionNum" value="<%= filtro.getSesionNum() %>">
                         <input type="hidden" name="dificultad" value="0">
                         <a class="fs-5" href="javascript:void(0);"
                            onclick="document.getElementById('remove-difficulty-form').submit();">
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
    <form id="rutinaForm" method="post" action="/entrenador/clientes/rutinas/guardar">
        <%
            for
            (
                    RutinaDTO rutina : rutinas
            ) {
                GsonBuilder gsonBuilder = new GsonBuilder();
                gsonBuilder.registerTypeAdapter(LocalDate.class, new LocalDateAdapter());
                Gson gson = gsonBuilder.create();
                List<SesionentrenamientoDTO> sesiones = mapSesiones.get(rutina);
                sesiones.forEach(s -> s.setRutina(null));
                String sesionesString = StringEscapeUtils.escapeHtml4(gson.toJson(sesiones));
        %>
        <div class="row mb-3">
            <div class="form-check">
                <div class="row d-flex justify-content-between">
                    <div class="col">
                        <input class="form-check-input" type="checkbox" name="rutinas" value="<%= rutina.getId() %>"
                               id="<%= rutina.getId() %>" <%= rutinasCliente.contains(rutina) ? "checked disabled" : ""%>>
                        <label class="form-check-label" for="<%= rutina.getId() %>" style="font-size: 20px">
                            <%= rutina.getNombre() %>
                        </label>
                    </div>
                    <div class="col d-flex  align-items-center">
                        <%
                            String fechaInicio = "";
                            for (RutinaclienteDTO rutinacliente : rutinasClienteObject) {
                                if (rutina.equals(rutinacliente.getRutina())) {
                                    fechaInicio = rutinacliente.getFechaInicio().toString();
                                    break;
                                }
                            }
                        %>
                        <input name="dateId_<%=rutina.getId()%>" type="date" class="form-control me-3" placeholder=""
                               aria-label="Example text with button addon"
                               aria-describedby="button-addon1" <%= rutinasCliente.contains(rutina) ? "disabled" : ""%>
                               value="<%= fechaInicio %>"
                        >
                        <div data-bs-toggle="modal" data-bs-target="#view-modal" style="cursor: pointer;">
                            <i class="bi bi-eye view-icon"
                               data-rutina-nombre="<%= rutina.getNombre() %>"
                               data-rutina-dificultad="<%= rutina.getDificultad().getNombre() %>"
                               data-rutina-desc="<%= rutina.getDescripcion() %>"
                               data-sesiones="<%= sesionesString %>"
                            >
                            </i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <%
            }
        %>
        <div class=" row">
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
