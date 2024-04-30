<%@ page import="com.google.gson.*" %>
<%@ page import="com.example.GymWebAppSpring.entity.Ejerciciosesion" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionentrenamiento" %>
<%@ page import="com.example.GymWebAppSpring.entity.Informacionsesion" %>
<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Ejerciciosesion> ejercicios = (List<Ejerciciosesion>) request.getAttribute("ejercicios");
    Sesionentrenamiento sesion = (Sesionentrenamiento) request.getAttribute("sesion");
    Informacionsesion info = (Informacionsesion) request.getAttribute("informacionSesion");
    Usuario cliente = (Usuario) request.getAttribute("cliente");
%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
<div class="container">
    <div class="row mb-3 d-flex text-center">
        <h1>Sesion de <%= sesion.getNombre() %>
        </h1>
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
                            String series = "";
                            if (ejercicio.getEspecificaciones() != null) {
                                Gson gson = new Gson();
                                JsonObject jsonObject = gson.fromJson(ejercicio.getEspecificaciones(), JsonObject.class);
                                series = jsonObject.get("series").getAsString();
                            }

                        %>
                        <%= series %>
                    </div>
                </td>
                <td>
                    <a class="btn border border-black"
                       href="/entrenador/clientes/rutinas/verSesion?id=<%= sesion.getId()%>">
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
            <div class="d-flex justify-content-center align-items-center">
                <%
                    if (info != null) {
                %>
                <div class="card">
                    <div class="card-title m-2">
                        <h5><%= cliente.getNombre() %> <%= cliente.getApellidos()%>
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <div class="col-12 text-start">
                                    <div class="mb-4 text-top">
                                        Valoracion:
                                    </div>
                                </div>
                                <div class="col-12 d-flex justify-content-center align-items-center">
                                    <%

                                        Integer valoracion = info.getValoracion();
                                        for (int i = 0; i < 5; i++) {
                                            if (i < valoracion) {
                                    %>
                                    <i class="fa fa-star">&nbsp</i>
                                    <%
                                    } else {
                                    %>
                                    <i class="fa fa-star-o">&nbsp</i>
                                    <%
                                            }
                                        }
                                    %>
                                </div>
                            </div>

                            <div class="col mx-3">
                                <div class="mx-2">
                                    Comentario:
                                </div>
                                <div class="card">
                                    <div class="card-body">
                                        <%= info.getComentario() %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                    } else {
                    %>
                    <div>
                        <h5>No hay comentarios</h5>
                    </div>
                    <%
                        }
                    %>
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
