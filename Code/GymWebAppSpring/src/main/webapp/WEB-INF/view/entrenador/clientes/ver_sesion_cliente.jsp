<%@ page import="com.google.gson.*" %>
<%@ page import="com.example.GymWebAppSpring.entity.Ejerciciosesion" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionentrenamiento" %>
<%@ page import="com.example.GymWebAppSpring.entity.Informacionsesion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Ejerciciosesion> ejercicios = (List<Ejerciciosesion>) request.getAttribute("ejercicios");
    Sesionentrenamiento sesion = (Sesionentrenamiento) request.getAttribute("sesion");
    Informacionsesion info = (Informacionsesion) request.getAttribute("informacionSesion");
%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
<div class="container">
    <div class="row mb-3 d-flex text-center" >
        <h1>Sesion de <%= sesion.getNombre() %></h1>
    </div>

    <div class="row mb-3">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Ejercicio</th>
                <th>Series</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <% for (Ejerciciosesion ejercicio : ejercicios) { %>
            <tr>
                <td>
                    <div class="my-2" style="font-size: 18px">
                        <%= ejercicio.getEjercicio().getNombre() %>
                    </div>
                </td>
                <td>
                    <div class="my-2" style="font-size: 18px">

                        <%
                            Gson gson = new Gson();
                            JsonObject jsonObject = gson.fromJson(ejercicio.getEspecificaciones(), JsonObject.class);
                            String series = jsonObject.get("series").getAsString();
                        %>
                        <%= series %>
                    </div>
                </td>
                <td>
                    <a class="btn border border-black" href="/entrenador/clientes/rutinas/verSesion?id=<%= sesion.getId()%>">
                        Ver desempeño
                    </a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <div class="row mb-3">
        <h4>Comentarios</h4>
    </div>
    <div class="row my-3">
        <div class="col ">
            <div class="d-flex justify-content-between align-items-center">
                <%
                    String[] estrellas = {"", "", "", "", ""};
                    for(int i = 0; i < info.getValoracion(); i++) {
                        estrellas[i] = "rating-color";
                    }
                %>
                <div>
                    <i class="fa fa-star <%= estrellas[0]%>"></i>
                    <i class="fa fa-star <%= estrellas[1]%>"></i>
                    <i class="fa fa-star <%= estrellas[2]%>"></i>
                    <i class="fa fa-star <%= estrellas[3]%>"></i>
                    <i class="fa fa-star <%= estrellas[4]%>"></i>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
