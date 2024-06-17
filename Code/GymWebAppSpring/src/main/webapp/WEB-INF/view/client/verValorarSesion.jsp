<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionentrenamiento" %>
<%@ page import="com.example.GymWebAppSpring.entity.Ejerciciosesion" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Informacionsesion" %><%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 14/06/2024
  Time: 19:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Informacionsesion informacionSesion = (Informacionsesion) request.getAttribute("informacionSesion");
    Sesionentrenamiento sesionentrenamiento = (Sesionentrenamiento) request.getAttribute("sesionEntrenamiento");

    String comentario = informacionSesion.getComentario();
    String contenidoTextarea = comentario.equals("NaN") ? "" : comentario.trim();
%>
<html>

<head>
    <title>Valora tu entrenamiento</title>
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>
<jsp:include page="../components/header.jsp"/>
<body style="height: 80vh;  background-color: #f8f9fa">
<div class="container-flex">
    <div class="row justify-content-center align-items-center mt-5">
        <div class="col-md-6 mt-5">
            <div class="card">
                <div class="card-body">
                    <h2 class="card-title text-center">Deja tu valoración</h2>
                    <form action="/client/rutina/sesion/valorarEntrenamiento/guardar" method="post">
                        <input type="hidden" name="sesionEntrenamiento" value="<%=sesionentrenamiento.getId()%>">
                        <div class="form-group my-3">
                            <label class="fs-3" for="coment">Comentario:</label>
                            <textarea id="coment" name="comentario" class="form-control"
                                      rows="4"
                                      placeholder="Escribe tu valoración aquí..."><%=contenidoTextarea%></textarea>
                        </div>
                        <div class="form-group">
                            <label class="fs-3" for="stars">Puntuación:</label>
                            <fieldset id="stars" class="rating al">
                                <input type="radio" id="star5" name="rating"
                                       value="5" <%=informacionSesion.getValoracion() == 5 ? "checked" : ""%>
                                />
                                <label class="full"
                                       for="star5"
                                       title="Magnifico - 5 stars">
                                </label>
                                <input type="radio" id="star4" name="rating"
                                       value="4" <%=informacionSesion.getValoracion() == 4 ? "checked" : ""%>/>
                                <label class="full"
                                       for="star4"
                                       title="Bueno - 4 stars">
                                </label>
                                <input type="radio" id="star3" name="rating"
                                       value="3" <%=informacionSesion.getValoracion() == 3 ? "checked" : ""%>/>
                                <label class="full"
                                       for="star3"
                                       title="Meh - 3 stars">
                                </label>
                                <input type="radio" id="star2" name="rating"
                                       value="2" <%=informacionSesion.getValoracion() == 2 ? "checked" : ""%>/>
                                <label class="full"
                                       for="star2"
                                       title="Malo - 2 stars">
                                </label>
                                <input type="radio" id="star1" name="rating"
                                       value="1"  <%=informacionSesion.getValoracion() == 1 || informacionSesion.getValoracion() == 0 ? "checked" : ""%>/>
                                <label class="full"
                                       for="star1"
                                       title="Horrible - 1 star">
                                </label>
                            </fieldset>
                        </div>
                        <div class="text-center mt-3">
                            <button type="submit" class="btn btn-primary">Enviar valoración</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<style>
    @import url(https://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);
    @import url(http://fonts.googleapis.com/css?family=Calibri:400,300,700);


    /****** Style Star Rating Widget *****/

    .rating {
        border: none;

    }

    .rating > [id^="star"] {
        display: none;
    }

    .rating > label:before {
        margin: 5px;
        font-size: 2.25em;
        font-family: FontAwesome;
        display: inline-block;
        content: "\f005";
    }

    .rating > .half:before {
        content: "\f089";
        position: absolute;
    }

    .rating > label {
        color: #ddd;
        float: right;
    }

    /***** CSS Magic to Highlight Stars on Hover *****/

    .rating > [id^="star"]:checked ~ label, /* show gold star when clicked */
    .rating:not(:checked) > label:hover, /* hover current star */
    .rating:not(:checked) > label:hover ~ label {
        color: #FFD700;
    }

    /* hover previous stars in list */

    .rating > [id^="star"]:checked + label:hover, /* hover current star when changing rating */
    .rating > [id^="star"]:checked ~ label:hover,
    .rating > label:hover ~ [id^="star"]:checked ~ label, /* lighten current selection */
    .rating > [id^="star"]:checked ~ label:hover ~ label {
        color: #FFED85;
    }

</style>
</html>
