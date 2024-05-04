<%@ page import="java.util.List" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.example.GymWebAppSpring.entity.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.databind.JsonNode" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 22/04/2024
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%
    List<Ejerciciosesion> ejercicios = (List<Ejerciciosesion>) request.getAttribute("ejercicios");
    Sesionentrenamiento sesionEntrenamiento = (Sesionentrenamiento) request.getAttribute("sesionEntrenamiento");
    Ejerciciosesion ejercicioElegido = (Ejerciciosesion) request.getAttribute("ejercicioElegido");
//    DayOfWeek diaSemanaActual = LocalDate.now().getDayOfWeek();
//    Usuario cliente = (Usuario) request.getAttribute("usuario");
//    Rutina rutina = (Rutina) request.getAttribute("rutina");
//    Map<Sesionrutina, List<Ejerciciosesion>> sesionesEjercicios = (Map<Sesionrutina, List<Ejerciciosesion>>) request.getAttribute("sesionesEjercicios");
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../components/header.jsp"/>
<div class="text-center">
    <h1 class="">Mi <%= sesionEntrenamiento.getNombre() %></h1>
</div>
<p></p>
<div class="container-fluid">
    <div class="row d-flex justify-content-center align-items-center ">
        <div class="col-6 flex-column mx-5" style="height: 400px">
            <% if (ejercicios.isEmpty()) { %>
            <h1 class="text-center"> No hay ejercicios!</h1>
            <% } else { %>
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <%
                    int i = 0;
                    for (Ejerciciosesion ejercicio : ejercicios) {
                        ObjectMapper objectMapper = new ObjectMapper();

                        // Convertir el JSON en un árbol de nodos
                        JsonNode jsonNode = objectMapper.readTree(ejercicio.getEspecificaciones());

                        // Obtener el valor de las repeticiones
                        int repeticiones = jsonNode.get("repeticiones").asInt();
                        int peso = jsonNode.get("peso").asInt();
                        int series = jsonNode.get("series").asInt();

                %>
                <li class="nav-item">
                    <a class="nav-link <%=i==0 ? "active": ""%>"  id="tab<%=i%>-tab" data-bs-toggle="tab"  href="#tab<%=i%>" role="tab" aria-controls="tab<%=i%>" aria-selected="<%=i==0 ? "true" : "false"%>"><%=ejercicio.getEjercicio().getNombre() +" "+ series+"/"+ series%></a>
                </li>
                <%i++;
                    } %>
            </ul>
            <div class=" border border-primary border-3 rounded h-100">
                <div class="tab-content" id="myTabContent">
                    <%
                        for(int j = 0; j<i ; j++){
                    %>
                    <div class="tab-pane fade <%=j==0 ? "active show" : ""%>" id="tab<%=j%>" role="tabpanel" aria-labelledby="tab<%=j%>-tab">
                        <h3>Contenido de Tab <%=j%></h3>
                        <p>Este es el contenido de la pestaña <%=j%>.</p>
                    </div>
                    <% } %>
                    </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
