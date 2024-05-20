<%@ page import="com.example.GymWebAppSpring.entity.*" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.databind.JsonNode" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="org.springframework.lang.NonNull" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.lang.reflect.Type" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 22/04/2024
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%
    Gson gson = new Gson();
    ObjectMapper objectMapper = new ObjectMapper();


    List<Ejerciciosesion> ejercicios = (List<Ejerciciosesion>) request.getAttribute("ejercicios");
    Sesionentrenamiento sesionEntrenamiento = (Sesionentrenamiento) request.getAttribute("sesionEntrenamiento");
    String[] ejerciciosID = new String[ejercicios.size()];
    //session.setAttribute("listaEjercicos", ejercicios);

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
    <title>Ver rutina</title>
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
    <script>
        function incrementarContador(index, max) {
            var contadorInput = document.getElementById("contador" + index);
            var valorActual = parseInt(contadorInput.value);
            if (valorActual < max) {
                contadorInput.value = valorActual + 1;
            }

        }

        function decrementarContador(index) {
            var contadorInput = document.getElementById("contador" + index);
            var valorActual = parseInt(contadorInput.value);
            if (valorActual > 0) {
                contadorInput.value = valorActual - 1;
            }

        }
    </script>
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

    </style>

</head>
<body>
<jsp:include page="../components/header.jsp"/>
<div class="container-fluid">
    <div class="row d-flex justify-content-center align-items-center ">
        <div class="col-10 flex-column mx-5">
            <h1>Mi sesion de <%= sesionEntrenamiento.getNombre() %>
            </h1>
            <% if (ejercicios.isEmpty()) { %>
            <h1 class="text-center"> No hay ejercicios!</h1>
            <% } else { %>
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <%
                    for (int tabIndex = 0; tabIndex < ejercicios.size(); tabIndex++) {
                        Ejerciciosesion ejerciciosesion = ejercicios.get(tabIndex);
                        Ejercicio ejercicio = ejerciciosesion.getEjercicio();
                        Categoria categoria = ejerciciosesion.getEjercicio().getCategoria();
                %>
                <li class="nav-item">
                    <a class="nav-link <%=tabIndex==0 ? "active": ""%>" id="tab<%=tabIndex%>-tab" data-bs-toggle="tab"
                       href="#tab<%=tabIndex%>" role="tab" aria-controls="tab<%=tabIndex%>"
                       aria-selected="<%=tabIndex==0 ? "true" : "false"%>"><%=ejercicio.getNombre() + " (Ejercicio de " + categoria.getNombre() + ")" %>
                    </a>
                </li>
                <%
                    }
                %>
            </ul>
            <div class="mb-5 border border-primary border-3 rounded">
                <div class="tab-content" id="myTabContent">
                    <script>
                        let resultados = [];
                        let seriesArray = [];
                        let seriesTotal = 0;
                        let serieActual = 0;
                    </script>
                    <%
                        int[] seriesArray = new int[ejercicios.size()];
                        for (int i = 0; i < ejercicios.size(); i++) {
                            Ejerciciosesion ejercicioSesion = ejercicios.get(i);
                            Ejercicio ejercicio = ejercicioSesion.getEjercicio();
                            Categoria categoria = ejercicio.getCategoria();
                            HashMap<String, String> especificaciones = gson.fromJson(ejercicioSesion.getEspecificaciones(), HashMap.class);
                    %>

                    <div class=" tab-pane fade <%=i==0 ? "active show" : ""%>" id="tab<%=i%>" role="tabpanel"
                         aria-labelledby="tab<%=i%>-tab">

                        <%
                            switch (categoria.getNombre()) {
                                case "Fuerza": {

                                    // Obtener el valor de las especs
                                    int peso = Integer.parseInt(especificaciones.getOrDefault("Peso añadido", "0"));
                                    int series = Integer.parseInt(especificaciones.getOrDefault("Series", "0"));
                                    int repeticiones = Integer.parseInt(especificaciones.getOrDefault("Repeticiones", "0"));
                        %>
                        <script>
                            seriesTotal = <%=series%>;
                            serieActual = 0;
                            seriesArray.push(<%=series%>);
                            resultados.push([]);
                        </script>
                        <div class="container">

                            <div class="row my-5 mx-5">
                                <div class="col-5 wrapper">
                                    <iframe src="https://www.youtube.com/embed/<%=getVideoId(ejercicio.getVideo())%>"
                                            title="YouTube video player" frameborder="0"
                                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                            referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                                </div>
                            </div>
                            <h1 class="text-center"><%=ejercicio.getNombre()%>
                            </h1>
                            <h2>Descripcion:</h2>
                            <div class="row my-2">

                                <p><%=ejercicio.getDescripcion()%>
                                </p>
                                <p><%="El ejercicio consta de levantar un peso de " + peso + " kilogramos durante " + series + " series de repeticiones. En cada serie, se realizan " + repeticiones + " repeticiones."%>
                                </p>
                            </div>
                            <h2>Progreso:</h2>
                            <div class="row my-2 mx-5">
                                <div class="border border-primary border-3 rounded">
                                    <form>
                                        <div class="mx-2 my-2">
                                            <div class="row mb-3 justify-content-between">
                                                <div class="col-5">
                                                    <div class="row">
                                                        <p>Num de repeticiones completadas:</p>
                                                    </div>
                                                    <div class=" btn-spn btn-spn-sm input-group">

                                                        <span class='input-group-btn'>
                                                        <button
                                                                class='btn btn-secondary btn-spn-down'
                                                                type='button' onclick="decrementarContador(<%=i%>)">
                                                            <i class="bi bi-dash"></i>
                                                        </button>
                                                      </span>
                                                        <input value='0' min='0' max='<%=repeticiones%>'
                                                               class='btn-spn-input form-control text-center'
                                                               id="contador<%=i%>" readonly>
                                                        <span class='input-group-btn'>
                                                        <button
                                                                class='btn btn-secondary btn-spn-up'
                                                                type='button'
                                                                onclick="incrementarContador(<%=i%>,<%=repeticiones%>)">
                                                            <i class="bi bi-plus"></i>
                                                        </button>
                                                      </span>
                                                    </div>
                                                </div>
                                                <div class="col-5">
                                                    <p class="row" id="serieText<%=i%>">Serie 0/<%=series%>
                                                    </p>
                                                    <button class='row btn btn-primary' type='button'
                                                            id="boton-serie<%=i%>"
                                                            onclick="incrementarSerie(<%=i%>)">Siguiente Serie
                                                    </button>
                                                </div>

                                            </div>
                                            <div class="row justify-content-between ">
                                                <div class="col-5">
                                                    <div class="form-check-inline form-switch">
                                                        <input class="form-check-input" type="checkbox" role="switch"
                                                               id="menos-peso-swich<%=i%>">
                                                        <label class="form-check-label" for="menos-peso-swich<%=i%>">Menos
                                                            peso?</label>
                                                    </div>
                                                </div>
                                                <div class="col-5">Descansa un poco:</div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="row justify-content-center my-2">
                                <div class="col-2 justify-content-center">
                                    <button class="btn btn-primary"
                                            onclick="<%=i == ejercicios.size()-1 ? "terminarEntrenamiento()":"cambiarPestana("+(i + 1)+")"%>" <%=i == ejercicios.size() - 1 ? "data-bs-toggle=\"modal\" data-bs-target=\"#exampleModal\"" : ""%>
                                    ><%=i == ejercicios.size() - 1 ? "Terminar Entrenamiento" : "Siguiente Ejercicio"%>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <%
                                break;
                            }
                            case "Resistencia": {
                                // Obtener el valor de las especs

                                int descanso = Integer.parseInt(especificaciones.getOrDefault("Descanso", "0"));
                                int peso = Integer.parseInt(especificaciones.getOrDefault("Peso añadido", "0"));
                                int series = Integer.parseInt(especificaciones.getOrDefault("Series", "0"));
                                int repeticiones = Integer.parseInt(especificaciones.getOrDefault("Repeticiones", "0"));
                        %>
                        <script>
                            seriesTotal = <%=series%>;
                            serieActual = 0;
                            seriesArray.push(<%=series%>);
                            resultados.push([]);
                        </script>
                        <div class="container">

                            <div class="row my-5 mx-5">
                                <div class="col-5 wrapper">
                                    <iframe src="https://www.youtube.com/embed/<%=getVideoId(ejercicio.getVideo())%>"
                                            title="YouTube video player" frameborder="0"
                                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                            referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                                </div>
                            </div>
                            <h1 class="text-center"><%=ejercicio.getNombre()%>
                            </h1>
                            <h2>Descripcion:</h2>
                            <div class="row my-2">

                                <p><%=ejercicio.getDescripcion()%>
                                </p>
                                <p><%="El ejercicio consta de levantar un peso de " + peso + " kilogramos durante " + series + " series de repeticiones. En cada serie, se realizan " + repeticiones + " repeticiones."%>
                                </p>
                            </div>
                            <h2>Progreso:</h2>
                            <div class="row my-2 mx-5">
                                <div class="border border-primary border-3 rounded">
                                    <form>
                                        <div class="mx-2 my-2">
                                            <div class="row mb-3 justify-content-between">
                                                <div class="col-5">
                                                    <div class="row">
                                                        <p>Num de repeticiones completadas:</p>
                                                    </div>
                                                    <div class=" btn-spn btn-spn-sm input-group">

                                                        <span class='input-group-btn'>
                                                        <button
                                                                class='btn btn-secondary btn-spn-down'
                                                                type='button' onclick="decrementarContador(<%=i%>)">
                                                            <i class="bi bi-dash"></i>
                                                        </button>
                                                      </span>
                                                        <input value='0' min='0' max='<%=repeticiones%>'
                                                               class='btn-spn-input form-control text-center'
                                                               id="contador<%=i%>" readonly>
                                                        <span class='input-group-btn'>
                                                        <button
                                                                class='btn btn-secondary btn-spn-up'
                                                                type='button'
                                                                onclick="incrementarContador(<%=i%>,<%=repeticiones%>)">
                                                            <i class="bi bi-plus"></i>
                                                        </button>
                                                      </span>
                                                    </div>
                                                </div>
                                                <div class="col-5">
                                                    <p class="row" id="serieText<%=i%>">Serie 0/<%=series%>
                                                    </p>
                                                    <button class='row btn btn-primary' type='button'
                                                            id="boton-serie<%=i%>"
                                                            onclick="incrementarSerie(<%=i%>)">Siguiente Serie
                                                    </button>
                                                </div>

                                            </div>
                                            <div class="row justify-content-between ">
                                                <div class="col-5">
                                                    <div class="form-check-inline form-switch">
                                                        <input class="form-check-input" type="checkbox" role="switch"
                                                               id="menos-peso-swich<%=i%>">
                                                        <label class="form-check-label" for="menos-peso-swich<%=i%>">Menos
                                                            peso?</label>
                                                    </div>
                                                </div>
                                                <div class="col-5">Descansa un poco:</div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="row justify-content-center my-2">
                                <div class="col-2 justify-content-center">
                                    <button class="btn btn-primary"
                                            onclick="<%=i == ejercicios.size()-1 ? "terminarEntrenamiento()":"cambiarPestana("+(i + 1)+")"%>" <%=i == ejercicios.size() - 1 ? "data-bs-toggle=\"modal\" data-bs-target=\"#exampleModal\"" : ""%>
                                    ><%=i == ejercicios.size() - 1 ? "Terminar Entrenamiento" : "Siguiente Ejercicio"%>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <%
                                break;
                            }

                            case "Flexibilidad": {
                                // Obtener el valor de las especs
                                int repeticiones = 0;
                                int tiempoEstiramiento = 0;
                                if (especificaciones.get("Repeticiones") != null)
                                    repeticiones = Integer.parseInt(especificaciones.get("Repeticiones"));
                                if (especificaciones.get("Tiempo de estiramiento") != null)
                                    tiempoEstiramiento = Integer.parseInt(especificaciones.get("Tiempo de estiramiento"));

                        %>


                        <%
                                break;
                            }
                            default: {
                        %>


                        <%
                                }
                            }
                        %>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
<!-- Modal -->

<div class="modal fade" id="finishModal" tabindex="-1" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="valorarEntrenamiento" method="post">
                    <!-- URL para procesar el formulario -->
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Muy bien!</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input id="datosEntrenamientoInput" type="hidden" name="datosEntrenamiento"
                               value="">
                        <input id="datosEjercicios" type="hidden" name="sesionEntrenamiento"
                               value="<%=sesionEntrenamiento%>">
                        <p>Tomate un respiro. Ya has acabado tu sesion de entrenamiento!</p>
                        <p>Ahora puedes valorar tu entrenamiento para ayudar a nuestro coaches a mejorar!
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-secondary">
                            Salir sin valorar
                        </button>
                        <button type="button" class="btn btn-primary" onclick="showValoration()">Valorar entrenamiento
                        </button>
                        <!-- Cambiado a type="submit" -->
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
<!-- Segundo modal para la valoración -->
<div class="modal fade" id="valorarModal" tabindex="-1" aria-labelledby="valorarModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="submitValoracion" method="post">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="valorarModalLabel">Valora tu entrenamiento</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <textarea name="valoracion" class="form-control" rows="4"
                                  placeholder="Escribe tu valoración aquí..."></textarea>
                    </div>
                    <fieldset class="rating al">
                        <input type="radio" id="star5" name="rating" value="5"/><label class="full" for="star5"
                                                                                       title="Magnifico - 5 stars"></label>
                        <input type="radio" id="star4half" name="rating" value="4.5"/><label class="half"
                                                                                             for="star4half"
                                                                                             title="Bastante bueno - 4.5 stars"></label>
                        <input type="radio" id="star4" name="rating" value="4"/><label class="full" for="star4"
                                                                                       title="Bueno - 4 stars"></label>
                        <input type="radio" id="star3half" name="rating" value="3.5"/><label class="half"
                                                                                             for="star3half"
                                                                                             title="Meh - 3.5 stars"></label>
                        <input type="radio" id="star3" name="rating" value="3"/><label class="full" for="star3"
                                                                                       title="Meh - 3 stars"></label>
                        <input type="radio" id="star2half" name="rating" value="2.5"/><label class="half"
                                                                                             for="star2half"
                                                                                             title="Malillo - 2.5 stars"></label>
                        <input type="radio" id="star2" name="rating" value="2"/><label class="full" for="star2"
                                                                                       title="Malo - 2 stars"></label>
                        <input type="radio" id="star1half" name="rating" value="1.5"/><label class="half"
                                                                                             for="star1half"
                                                                                             title="Bastante Malo - 1.5 stars"></label>
                        <input type="radio" id="star1" name="rating" value="1"/><label class="full" for="star1"
                                                                                       title="Horrible - 1 star"></label>
                        <input type="radio" id="starhalf" name="rating" value="0.5"/><label class="half" for="starhalf"
                                                                                            title="Me quiero morir - 0.5 stars"></label>
                        <input type="radio" class="reset-option" name="rating" value="reset"/>
                    </fieldset>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Enviar valoración</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function showValoration() {

        var finishModal = bootstrap.Modal.getInstance(document.getElementById('finishModal'));
        finishModal.hide();

        var secondModal = new bootstrap.Modal(document.getElementById('valorarModal'));
        secondModal.show();
    }

    function incrementarSerie(index) {
        let menosPeso = document.getElementById("menos-peso-swich" + index);
        let repeticiones = document.getElementById("contador" + index).value;

        if (serieActual < seriesTotal) {
            serieActual++;
            document.getElementById('serieText' + index).innerHTML = 'Serie ' + serieActual + '/' + seriesTotal;

            var datos = {
                repeticiones: repeticiones,
                mpeso: menosPeso.checked ? "SI" : "NO"
            };

            // Convertir el objeto JSON a una cadena
            var datosString = JSON.stringify(datos);
            resultados[index].push(datosString);

            console.log(resultados)
            console.log(datosString);
            document.getElementById("menos-peso-swich" + index).checked = false;
            document.getElementById("contador" + index).value = "0";
        }
        if (serieActual === seriesTotal) {
            document.getElementById("boton-serie" + index).disabled = true;
            alert("Ya has completado todas las series!");
            console.log(resultados.at(index));
        }


    }

    function terminarEntrenamiento() {
        var vacio = {
            repeticiones: 0,
            mpeso: "NO"
        };
        for (let i = 0; i < <%=ejercicios.size()%>; i++) {
            for (let j = 0; j < seriesArray.at(i); j++) {
                if (resultados[i][j] === undefined || resultados[i][j] === null) {
                    resultados[i][j] = JSON.stringify(vacio);
                    console.log(resultados[i][j])

                }
            }
        }

        let miVariable = JSON.stringify(resultados);
        console.log(resultados)
        console.log(miVariable)
        // Obtén el campo de entrada oculto por su ID
        let datosEntrenamientoInput = document.getElementById("datosEntrenamientoInput");

        // Establece el valor del campo de entrada oculto usando la variable JavaScript
        datosEntrenamientoInput.value = miVariable;

        var finishModal = new bootstrap.Modal(document.getElementById('finishModal'));
        finishModal.show();

    }

    function confirmarAccion() {
        // Aquí puedes realizar la acción que desees al confirmar
        alert("Acción confirmada");
    }

    function cambiarPestana(index) {

        var tabContent = document.querySelectorAll('.tab-pane');
        var tabLinks = document.querySelectorAll('#myTab .nav-link');


        // Ocultar todos los contenidos de las pestañas
        tabContent.forEach(function (tab) {
            tab.classList.remove('active', 'show');

        });

        tabLinks.forEach(function (tab) {
            tab.classList.remove('active');
            tab.setAttribute('aria-selected', 'false');
        });
        // Marcar como activo el enlace de la siguiente pestaña

        tabLinks[index].classList.add('active');
        tabLinks[index].setAttribute('aria-selected', 'true');

        // Mostrar el contenido de la pestaña correspondiente al enlace
        tabContent[index].classList.add('active', 'show');
    }
</script>
<style>
    @import url(https://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);
    @import url(http://fonts.googleapis.com/css?family=Calibri:400,300,700);


    fieldset, label {
        margin: 0;
        padding: 0;
    }

    body {
        margin: 20px;
    }

    h1 {
        font-size: 1.5em;
        margin: 10px;
    }

    /****** Style Star Rating Widget *****/

    .rating {
        border: none;
        margin-right: 49px;
    }

    .myratings {

        font-size: 85px;
        color: green;
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

    .reset-option {
        display: none;
    }

    .reset-button {
        margin: 6px 12px;
        background-color: rgb(255, 255, 255);
        text-transform: uppercase;
    }


</style>
</html>
