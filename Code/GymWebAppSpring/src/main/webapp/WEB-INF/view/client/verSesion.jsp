<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.*" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.databind.JsonNode" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="org.springframework.lang.NonNull" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.lang.reflect.Type" %>
<%@ page import="com.google.gson.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 22/04/2024
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%
    //    Gson gson = new GsonBuilder().registerTypeAdapter(LocalDate.class, new JsonSerializer<LocalDate>() {
//        @Override
//        public JsonElement serialize(LocalDate localDate, Type type, JsonSerializationContext jsonSerializationContext) {
//            return jsonSerializationContext.serialize(localDate.toString());
//        }
//
//    }).create();
    Gson gson = new Gson();
    List<Ejerciciosesion> ejercicios = (List<Ejerciciosesion>) request.getAttribute("ejercicios");
    Sesionentrenamiento sesionEntrenamiento = (Sesionentrenamiento) request.getAttribute("sesionEntrenamiento");
    String[] ejerciciosID = new String[ejercicios.size()];
    session.setAttribute("listaEjercicos", ejercicios);

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

</head>
<body>
<jsp:include page="../components/header.jsp"/>
<div class="text-center">
    <h1 class="">Mi <%= sesionEntrenamiento.getNombre() %>
    </h1>
</div>
<p></p>
<div class="container-fluid">
    <div class="row d-flex justify-content-center align-items-center ">
        <div class="col-10 flex-column mx-5">
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
                    <a class="nav-link <%=i==0 ? "active": ""%>" id="tab<%=i%>-tab" data-bs-toggle="tab"
                       href="#tab<%=i%>" role="tab" aria-controls="tab<%=i%>"
                       aria-selected="<%=i==0 ? "true" : "false"%>"><%=ejercicio.getEjercicio().getNombre() + " " + series + "/" + series%>
                    </a>
                </li>
                <%
                        i++;
                    }
                %>
            </ul>
            <div class=" border border-primary border-3 rounded h-100">
                <div class="tab-content" id="myTabContent">
                    <script>
                        let serieActualArray = [];
                        let series = Array();
                        let resultados = [];
                    </script>
                    <%
                        int[] seriesArray = new int[i];
                        for (int j = 0; j < i; j++) {

                            Ejerciciosesion ejercicioSesion = ejercicios.get(j);
                            Ejercicio ejercicio = ejercicioSesion.getEjercicio();
                            ObjectMapper objectMapper = new ObjectMapper();

                            // Convertir el JSON en un árbol de nodos
                            JsonNode jsonNode = objectMapper.readTree(ejercicioSesion.getEspecificaciones());

                            // Obtener el valor de las repeticiones
                            int repeticiones = jsonNode.get("repeticiones").asInt();
                            int peso = jsonNode.get("peso").asInt();
                            int series = jsonNode.get("series").asInt();
                            seriesArray[j] = series;
                    %>
                    <script>
                        resultados.push(new Array(<%=series%>));
                        serieActualArray.push(0);
                        series.push(<%=series%>);

                    </script>
                    <div class="tab-pane fade <%=j==0 ? "active show" : ""%>" id="tab<%=j%>" role="tabpanel"
                         aria-labelledby="tab<%=j%>-tab">
                        <div class="container-fluid ">
                            <div class="row  justify-content-center">
                                <div class="col-7 flex-column justify-content-center">
                                    <iframe width="560" height="315"
                                            src="https://www.youtube.com/embed/<%=getVideoId(ejercicio.getVideo())%>"
                                            title="YouTube video player" frameborder="0"
                                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                            referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                                </div>
                            </div>
                            <div class="row text-center my-2">

                                <p><%=ejercicio.getDescripcion()%>
                                </p>
                                <p><%="El ejercicio consta de levantar un peso de " + peso + " kilogramos durante " + series + " series de repeticiones. En cada serie, se realizan " + repeticiones + " repeticiones."%>
                                </p>
                            </div>
                            <div class="row text-center my-2 mx-5 border border-primary border-3 rounded">
                                <form>
                                    <div class="container-fluid">
                                        <div class="row my-2">
                                            <div class="col flex-column">
                                                <div class="row">
                                                    <p class="col">Num de repeticiones completadas:</p>
                                                    <div class='col btn-spn btn-spn-sm input-group'>
                                                      <span class='input-group-btn'>
                                                        <button
                                                                class='btn btn-secondary btn-spn-down'
                                                                type='button' onclick="decrementarContador(<%=j%>)">
                                                            <i class="bi bi-dash"></i>
                                                        </button>
                                                      </span>
                                                        <input value='0' min='0' max='<%=repeticiones%>'
                                                               class='btn-spn-input form-control text-center'
                                                               id="contador<%=j%>" readonly>
                                                        <span class='input-group-btn'>
                                                        <button
                                                                class='btn btn-secondary btn-spn-up'
                                                                type='button'
                                                                onclick="incrementarContador(<%=j%>,<%=repeticiones%>)">
                                                            <i class="bi bi-plus"></i>
                                                        </button>
                                                      </span>
                                                    </div>
                                                </div>


                                            </div>
                                            <div class="col">
                                                <p id="serieText<%=j%>">Serie 0/<%=seriesArray[j]%>
                                                </p>
                                                <button class='btn btn-primary' type='button' id="boton-serie<%=j%>"
                                                        onclick="incrementarSerie(<%=j%>)">Siguiente Serie
                                                </button>
                                            </div>
                                            <script>
                                                function incrementarSerie(index) {
                                                    var menosPeso = document.getElementById("flexSwitchCheckDefault");
                                                    var repeticiones = document.getElementById("contador" + index).value;
                                                    // Obteniendo el valor de serieActual del array serieActualArray utilizando JavaScript
                                                    var seriesTotal = series.at(index);
                                                    var serieActual = serieActualArray.at(index);


                                                    if (serieActual < seriesTotal) {
                                                        serieActual++;
                                                        serieActualArray[index] = serieActual;
                                                        document.getElementById('serieText' + index).innerHTML = 'Serie ' + serieActual + '/' + seriesTotal;
                                                        var datos = {
                                                            repeticiones: repeticiones,
                                                            mpeso: menosPeso.checked ? "SI" : "NO"
                                                        };

                                                        // Convertir el objeto JSON a una cadena
                                                        var datosString = JSON.stringify(datos);
                                                        resultados[index].push(datosString);
                                                        console.log(datosString);
                                                        document.getElementById("flexSwitchCheckDefault").checked = false;
                                                        document.getElementById("contador" + index).value = "0";
                                                    }
                                                    if (serieActual === seriesTotal) {
                                                        document.getElementById("boton-serie" + index).disabled = true;
                                                        alert("Ya has completado todas las series!");
                                                        console.log(resultados.at(index));
                                                    }


                                                }
                                            </script>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-check-inline form-switch">
                                                    <input class="form-check-input" type="checkbox" role="switch"
                                                           id="flexSwitchCheckDefault">
                                                    <label class="form-check-label" for="flexSwitchCheckDefault">Menos
                                                        peso?</label>
                                                </div>
                                            </div>
                                            <div class="col">Descansa un poco:</div>
                                        </div>

                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row text-center my-2">
                            <div class="col">
                                <button class="btn btn-primary"
                                        onclick="<%=j == i-1 ? "terminarEntrenamiento()":"cambiarPestana("+(j + 1)+")"%>" <%=j == i - 1 ? "data-bs-toggle=\"modal\" data-bs-target=\"#exampleModal\"" : ""%>
                                ><%=j == i - 1 ? "Terminar Entrenamiento" : "Siguiente Ejercicio"%>
                                </button>
                                <!-- Button trigger modal -->

                            </div>

                        </div>


                    </div>
                    <% } %>


                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="valorarEntrenamiento" method="post">
                                    <!-- URL para procesar el formulario -->
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <input id="datosEntrenamientoInput" type="hidden" name="datosEntrenamiento"
                                               value="">
                                        <input id="datosEjercicios" type="hidden" name="ejerciciosID"
                                               value="<%=ejerciciosID%>">
                                        <p>Estas seguro que deseas acabar este entrenamieto? Se guardaran los datos de
                                            todas las repteciones pendientes!!!</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close
                                        </button>
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                        <!-- Cambiado a type="submit" -->
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>

                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function terminarEntrenamiento() {
        // Mostrar el modal de confirmación
        // Supongamos que tienes una variable JavaScript llamada miVariable
        var vacio = {
            repeticiones: 0,
            mpeso:  "NO"
        };
        for (let i = 0; i < resultados.length; i++) {
            for (let j = 0; j < resultados[i].length; j++) {
                if (resultados[i][j] === undefined) {
                    resultados[i][j] = JSON.stringify(vacio);
                }
            }
        }
        var miVariable = JSON.stringify(resultados);
        console.log(resultados)
        console.log(miVariable)
        // Obtén el campo de entrada oculto por su ID
        var datosEntrenamientoInput = document.getElementById("datosEntrenamientoInput");

        // Establece el valor del campo de entrada oculto usando la variable JavaScript
        datosEntrenamientoInput.value = miVariable;
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
</html>
