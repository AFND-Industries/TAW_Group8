<%@ page import="java.util.List" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.example.GymWebAppSpring.entity.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 22/04/2024
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%
    DayOfWeek diaSemanaActual = LocalDate.now().getDayOfWeek();
    Usuario cliente = (Usuario) request.getAttribute("usuario");
    Rutina rutina = (Rutina) request.getAttribute("rutina");
    Map<Sesionentrenamiento, List<Object>> sesionesEjercicios = (Map<Sesionentrenamiento, List<Object>>) request.getAttribute("sesionesEjercicios");
%>
<html>
<head>
    <title>Title</title>
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
                    <% for (Map.Entry<Sesionentrenamiento, List<Object>> entrada : sesionesEjercicios.entrySet()) { %>
                    <%
                        boolean esHoy = diaSemanaActual.getValue() == entrada.getKey().getDia();
                        DayOfWeek diaSemana = DayOfWeek.of(entrada.getKey().getDia());
                        String nombreDia = diaSemana.getDisplayName(java.time.format.TextStyle.FULL, new Locale("es", "ES"));
                        int numEjercicios = ((List<Ejerciciosesion>) entrada.getValue().get(0)).size();
                        int numEjerciciosCompletados = (Integer) entrada.getValue().get(1);
                        boolean hayEjercicios = !((List<Ejerciciosesion>) entrada.getValue().get(0)).isEmpty();

                    %>
                    <tr class="<%= esHoy ? "table-primary" : "" %>">
                        <td>
                            <%
                                if (numEjerciciosCompletados == 0) {

                            %>
                            <button type="submit" class="<%= esHoy ? "btn btn-warning" : "btn btn-outline-primary"  %>"
                                    value="<%= entrada.getKey().getId()%>"
                                    name="sesionEntrenamiento" <%=!hayEjercicios ? "disabled" : ""%>>Comenzar
                                <%= entrada.getKey().getNombre() %>
                            </button>
                            <%
                            } else if (numEjerciciosCompletados >= numEjercicios) {
                            %>
                            <button type="submit" class="<%="btn btn-danger"  %>"
                                    value="<%= entrada.getKey().getId()%>" name="sesionEntrenamiento" disabled>
                                <%= entrada.getKey().getNombre() %>  Completada!
                            </button>
                            <%
                            } else {
                            %>
                            <button type="submit" class="<%= esHoy ? "btn btn-warning" : "btn btn-success"  %>"
                                    value="<%= entrada.getKey().getId()%>" name="sesionEntrenamiento"
                                    <%=!hayEjercicios ? "disabled" : ""%>>Continuar
                                <%= entrada.getKey().getNombre() %>
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
                                    value="<%= entrada.getKey().getId()%>"
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
        const sesionEntrenamiento = document.querySelector("button[name='sesionEntrenamiento']").value;
        window.location.href = "/client/rutina/sesion/desempenyo?sesionEntrenamiento=" + sesionEntrenamiento;
    }
</script>
</html>
