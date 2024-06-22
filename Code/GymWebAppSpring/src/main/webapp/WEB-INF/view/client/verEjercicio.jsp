<%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 22/04/2024
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="org.springframework.lang.NonNull" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.GymWebAppSpring.dto.SesionentrenamientoDTO" %>
<%@ page import="com.example.GymWebAppSpring.dto.EjerciciosesionDTO" %>
<%@ page import="com.example.GymWebAppSpring.dto.EjercicioDTO" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Gson gson = new Gson();

    SesionentrenamientoDTO sesionEntrenamiento = (SesionentrenamientoDTO) request.getAttribute("sesionEntrenamiento");
    EjerciciosesionDTO ejercicioSesion = (EjerciciosesionDTO) request.getAttribute("ejercicioSesion");
    Integer ejercicioIndex = (Integer) request.getAttribute("ejercicioIndex");

    EjercicioDTO ejercicio = ejercicioSesion.getEjercicio();
    HashMap<String, String> especificaciones = gson.fromJson(ejercicioSesion.getEspecificaciones(), HashMap.class);
%>
<%!
    public static String getVideoId(@NonNull String videoUrl) {
        String videoId = "";
        String regex = "http(?:s)?:\\/\\/(?:m\\.)?(?:www\\.)?youtu(?:\\.be\\/|(?:be-nocookie|be)\\.com\\/(?:watch|[\\w]+\\?(?:feature=[\\w]+\\.[\\w]+\\&)?v=|v\\/|e\\/|embed\\/|live\\/|shorts\\/|user\\/(?:[\\w#]+\\/)+))([^&#?\\n]+)";
        Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(videoUrl);
        if (matcher.find()) {
            videoId = matcher.group(1);
        }
        return videoId;
    }
%>
<html>
<head>
    <title>Ver ejercicio</title>
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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playwrite+IS&display=swap" rel="stylesheet">
    <style>
        .wrapper {
            position: relative;
            padding-bottom: 56.25%; /* 16:9 ratio */
            padding-top: 25px;
            height: 0;
            max-height: 25vh; /* 25% de la altura de la pantalla */
            width: 100%;
            overflow: hidden;
        }

        .wrapper iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .font {
            font-family: "Playwrite IS", cursive;
            font-optical-sizing: auto;
            font-weight: 400;
            font-style: normal;
        }

    </style>

</head>

<body>
<jsp:include page="../components/header.jsp"/>
<div class="container-fluid">
    <div class="row d-flex justify-content-center align-items-center ">
        <div class="col-8 flex-column mx-5 h-50">
            <h1 class="text-center bold">Mi <%= sesionEntrenamiento.getNombre() %>
            </h1>
            <h3>Ejercicios: </h3>
            <div class="mb-5 border border-primary border-3 rounded">
                <div class="tab-content" id="myTabContent">
                    <div class="container">
                        <div class="row my-5 mx-5">
                            <div class="col-5 wrapper">
                                <iframe src="https://www.youtube.com/embed/<%=getVideoId(ejercicio.getVideo())%>"
                                        title="YouTube video player" frameborder="0"
                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                        referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                            </div>
                        </div>
                        <h1 class="font text-center"><%=ejercicio.getNombre()%>
                        </h1>
                        <div class="row my-2">
                            <h2>Descripcion:</h2>
                            <p class="fs-4"><%=ejercicio.getDescripcion()%>
                            </p>
                        </div>
                        <div class="row mb-4 justify-content-center">
                            <div class="col-12 mb-2">
                                <h2>Progreso:</h2>
                            </div>
                            <div class="col-5 border border-success border-3 rounded mx-1">
                                <div class="row justify-content-center my-2">
                                    <h4>Mi progreso:</h4>
                                    <div class="col-6">
                                        <form id="ejercicioForm">
                                            <%
                                                for (Map.Entry<String, String> entrada : especificaciones.entrySet()) {
                                            %>
                                            <label class="my-1">
                                                <%= entrada.getKey() %>:
                                                <input type="number" min="0"
                                                       max="<%= Integer.parseInt(entrada.getValue()) %>"
                                                       name="<%= entrada.getKey()%>"
                                                       value="0"/>
                                                <%= entrada.getKey().toLowerCase().contains("peso") ? "kg." : "" %>
                                                <%= entrada.getKey().toLowerCase().contains("tiempo") || entrada.getKey().toLowerCase().contains("descanso") ? "seg." : "" %>
                                            </label>
                                            <%
                                                }
                                            %>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-5 border border-primary border-3 rounded mx-1">
                                <div class="row justify-content-center my-2">
                                    <h4>Objetivos del entrenador:</h4>
                                    <div class="col-6">
                                        <div>
                                            <%
                                                for (Map.Entry<String, String> entrada : especificaciones.entrySet()) {
                                            %>
                                            <p class="my-2">
                                                <%= entrada.getKey() %>:
                                                <%= Integer.parseInt(entrada.getValue()) %>
                                                <%= entrada.getKey().toLowerCase().contains("peso") ? "kg." : "" %>
                                                <%= entrada.getKey().toLowerCase().contains("tiempo") || entrada.getKey().toLowerCase().contains("descanso") ? "seg." : "" %>
                                            </p>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row justify-content-center my-2">

                                <div class="col-2 d-flex justify-content-start">
                                    <button type="button" class="btn btn-primary" onclick="handleSummit()">
                                        Siguiente ejercicio
                                    </button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal confirmacion -->
<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <form method="post" action="/client/rutina/sesion/ejercicio/guardar">
        <input type="hidden" name="sesionEntrenamiento" value="<%=sesionEntrenamiento.getId()%>">
        <input type="hidden" name="resultados" id="resultados">
        <input type="hidden" name="ejercicioIndex" value="<%=ejercicioIndex%>">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Cuidado! </h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Estas seguro que has acabado con el ejercicio?
                    Al pulsar continuar, se guardaran los datos introducidos y se pasara al siguiente ejercicio.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Guardar y Continuar</button>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
<script>
    function handleSummit() {
        const jsonData = {};
        const form = document.getElementById('ejercicioForm');
        const formData = new FormData(form);


        formData.forEach((value, key) => {
            jsonData[key] = value;
        });

        $('#confirmationModal').modal('show');

        document.getElementById('resultados').value = JSON.stringify(jsonData);

    }

</script>
</html>
