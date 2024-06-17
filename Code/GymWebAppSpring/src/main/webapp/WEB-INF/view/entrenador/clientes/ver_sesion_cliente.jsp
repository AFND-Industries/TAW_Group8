<%@ page import="com.google.gson.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Ejerciciosesion> ejercicios = (List<Ejerciciosesion>) request.getAttribute("ejercicios");
    Sesionentrenamiento sesion = (Sesionentrenamiento) request.getAttribute("sesion");
    Informacionsesion info = (Informacionsesion) request.getAttribute("informacionSesion");
    Usuario cliente = (Usuario) session.getAttribute("cliente");
    List<Informacionejercicio> informacionejercicios = (List<Informacionejercicio>) request.getAttribute("informacionEjercicios");
    Rutina rutina = (Rutina) session.getAttribute("rutina");
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
<div class="row m-3">
    <div class="col-md-6">
        <a class="btn btn-outline-secondary" href="/entrenador/clientes/rutinas/verRutina?idRutina=<%=rutina.getId()%>">
            <i class="bi bi-chevron-left me-2"></i>
            <span class="d-sm-inline d-none">Volver</span>
        </a>
    </div>
</div>
<div class="container">
    <div class="row mb-3 d-flex text-center">
        <h1>Sesion de <%= sesion.getNombre() %>
        </h1>
    </div>

    <%
        int j = 0;
        for (Ejerciciosesion ejercicio : ejercicios) { %>
    <div class="card mb-3">
        <div class="row my-2 mx-3">
            <div class="col-2">
                <div class="my-2">
                    <img class="img-fluid" src="<%= ejercicio.getEjercicio().getLogo()%>">
                </div>
            </div>
            <div class="col-9 me-3 d-flex justify-content-center flex-column">
                <div class="row">
                    <div class="col my-2" style="font-size: 18px">
                        <strong>Nombre: </strong><%= ejercicio.getEjercicio().getNombre() %>
                    </div>
                </div>


                <%
                    System.out.println(j);
                    String[] parametros = null;
                    String[] nombres = null;
                    String[] hechos = null;
                    if (ejercicio.getEspecificaciones() != null) {
                        Gson gson = new Gson();
                        JsonArray jsonArray = gson.fromJson(ejercicio.getEjercicio().getCategoria().getTiposBase(), JsonArray.class);
                        System.out.println(jsonArray);
                        JsonObject jsonObjectHechos = gson.fromJson(informacionejercicios.get(j).getEvaluacion(), JsonObject.class);
                        System.out.println(jsonObjectHechos);
                        hechos = new String[jsonArray.size()];
                        parametros = new String[jsonArray.size()];
                        nombres = new String[jsonArray.size()];
                        String tipoCantidad = jsonArray.get(0).getAsString();
                        JsonObject jsonObject = gson.fromJson(ejercicio.getEspecificaciones(), JsonObject.class);
                        for (int i = 0; i < jsonArray.size(); i++) {
                            hechos[i] = jsonObjectHechos.get(jsonArray.get(i).getAsString()).getAsString();
                            parametros[i] = jsonObject.get(jsonArray.get(i).getAsString()).getAsString();
                            nombres[i] = jsonArray.get(i).getAsString();
                        }

                    }

                %>
                <div class="row">
                    <%
                        if (parametros != null) {
                            for (int i = 0; i < parametros.length; i++) {
                    %>
                    <div class=" col my-2" style="font-size: 18px">
                        <span class="me-2"><strong><%=  nombres[i] %>: </strong> <%= hechos[i]%> / <%= parametros[i] %></span>
                    </div>
                    <%
                            }
                        }
                    %>

                </div>

            </div>
        </div>
    </div>
    <%
            j++;
        }
    %>


    <div class="row my-3">
        <h4>Comentarios</h4>
    </div>
    <div class="row my-3">
        <div class="col ">
            <div class="d-flex justify-content-center align-items-center">
                <%
                    if (info != null) {
                %>
                <div class="card">
                    <div class="card-title m-2 d-flex align-items-center">
                        <i class="bi bi-person-square" style="font-size: 40px"></i>
                        <span class="mx-2 "
                              style="font-size: 18px"><strong><%= cliente.getNombre() %> <%= cliente.getApellidos()%></strong>
                        </span>
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
