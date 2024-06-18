<%@ page import="java.util.List" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.example.GymWebAppSpring.entity.*" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.example.GymWebAppSpring.dto.SesionentrenamientoDTO" %>
<%@ page import="org.apache.commons.lang3.tuple.Triple" %>
<%@ page import="com.example.GymWebAppSpring.dto.RutinaDTO" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 22/04/2024
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%
    DayOfWeek diaSemanaActual = LocalDate.now().getDayOfWeek();
    RutinaDTO rutina = (RutinaDTO) request.getAttribute("rutina");
    List<Triple<SesionentrenamientoDTO, Integer, Integer>> sesionesEjercicios = (List<Triple<SesionentrenamientoDTO, Integer, Integer>>) request.getAttribute("sesionesEjercicios");
%>
<html>
<head>
    <title>Mi: <%=rutina.getNombre()%>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../components/header.jsp"/>
<div class="text-center">
    <h1 class="">Mi <%= rutina.getNombre() %>
    </h1>
</div>
<p></p>
<div class="container-fluid">
    <div class="row d-flex justify-content-center align-items-center ">
        <div class="col-6 flex-column mx-5 border border-primary border-3 rounded" style="height: 400px">
            <% if (sesionesEjercicios.isEmpty()) { %>
            <h1 class="text-center"> No hay sesiones!</h1>
            <% } else { %>
            <form method="get" action="/client/rutina/sesion/ejercicio">
                <table class="table ">
                    <thead>
                    <tr>
                        <th scope="col">Nombre</th>
                        <th scope="col">Progreso</th>
                        <th scope="col">Porgreso</th>
                        <th scope="col"></th>

                    </tr>
                    </thead>
                    <tbody>
                    <% for (Triple<SesionentrenamientoDTO, Integer, Integer> datos : sesionesEjercicios) { %>
                    <%
                        SesionentrenamientoDTO sesionEntrenamiento = datos.getLeft();
                        int numEjercicios = datos.getMiddle();
                        int numEjerciciosCompletados = datos.getRight();

                        boolean esHoy = diaSemanaActual.getValue() == sesionEntrenamiento.getDia();

                        DayOfWeek diaSemana = DayOfWeek.of(sesionEntrenamiento.getDia());
                        String nombreDia = diaSemana.getDisplayName(java.time.format.TextStyle.FULL, Locale.of("es", "ES"));

                        boolean hayEjercicios = numEjercicios != 0;

                    %>
                    <tr class="<%= esHoy ? "table-primary" : "" %>">
                        <td>
                            <%
                                if (numEjerciciosCompletados == 0) {

                            %>
                            <button type="submit" class="<%= esHoy ? "btn btn-warning" : "btn btn-outline-primary"  %>"
                                    value="<%= sesionEntrenamiento.getId()%>"
                                    name="sesionEntrenamiento" <%=!hayEjercicios ? "disabled" : ""%>>Comenzar
                                <%= sesionEntrenamiento.getNombre() %>
                            </button>
                            <%
                            } else if (numEjerciciosCompletados >= numEjercicios) {
                            %>
                            <button type="submit" class="<%="btn btn-danger"  %>"
                                    value="<%=sesionEntrenamiento.getId()%>" name="sesionEntrenamiento" disabled>
                                <%= sesionEntrenamiento.getNombre() %>  Completada!
                            </button>
                            <%
                            } else {
                            %>
                            <button type="submit" class="<%= esHoy ? "btn btn-warning" : "btn btn-success"  %>"
                                    value="<%= sesionEntrenamiento.getId()%>" name="sesionEntrenamiento"
                                    <%=!hayEjercicios ? "disabled" : ""%>>Continuar
                                <%= sesionEntrenamiento.getNombre() %>
                            </button>
                            <%
                                }
                            %>
                        </td>
                        <td>
                            <%=hayEjercicios ? ((numEjerciciosCompletados * 100) / numEjercicios) + "% completada!" : "No hay ejercicios asignados!" %>

                        </td>
                        <td>
                            <button type="button" class="<%= esHoy ? "btn btn-warning" : "btn btn-outline-primary"  %>"
                                    value="<%= sesionEntrenamiento.getId()%>"
                                    name="sesionEntrenamiento"
                                    onclick="goRendimiento()"
                                    <%=!hayEjercicios || numEjerciciosCompletados <= 0 || numEjerciciosCompletados > numEjercicios ? "disabled" : ""%>>
                                Ver mi
                                rendimiento
                            </button>

                        </td>
                        <td class="text-end">
                                    <span class="badge text-bg-<%= esHoy ? "warning" : "primary" %>">
                                        Tu sesion del <%= esHoy ? "dia de hoy" : nombreDia %>
                                    </span>
                        </td>

                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </form>
            <% } %>
        </div>
    </div>
</div>
</body>
<script>
    function goRendimiento() {
        const sesionEntrenamientoId = document.querySelector("button[name='sesionEntrenamiento']").value;
        window.location.href = "/client/rutina/sesion/desempenyo?sesionEntrenamiento=" + sesionEntrenamientoId;
    }
</script>
</html>
