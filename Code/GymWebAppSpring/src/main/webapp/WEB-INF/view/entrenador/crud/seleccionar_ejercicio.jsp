<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Integer> ejercicios = new ArrayList<>();
    for (int i = 0; i < 5; i++)
        ejercicios.add(i+1);
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

    <div class="container">
        <div class="row mb-3">
            <div class="col-4">
                <h1>Ejercicios</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <a class="btn btn-primary" href="/entrenador/rutinas/crear/ejercicio">Volver</a>
            </div>
        </div>
        <%
            for (Integer ejercicio : ejercicios) {
        %>
        <div class="row" style="cursor: pointer;">
            <a class="col-8 d-flex align-items-center" style="height:75px; text-decoration: none;" href="/entrenador/rutinas/crear/ejercicio">
                <img src="/svg/question-square.svg" alt="Borrar" style="width:50px; height:50px">
                <div>
                    <span class="ms-3 h2" style="color: black;">Ejercicio <%=ejercicio%></span><br>
                    <span class="ms-3 h5 text-secondary">Repeticiones: X. Series: X. Descanso: X....</span>
                </div>
            </a>
            <div class="col-4 d-flex justify-content-end align-items-center">
                <a style="cursor: pointer;" href="/entrenador/rutinas/crear/ejercicio/ver">
                    <img src="/svg/eye.svg" alt="Ver" style="width:50px; height:50px">
                </a>
            </div>
        </div>


        <hr>
        <%
            }
        %>
    </div>
</body>
</html>
