<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.GymWebAppSpring.entity.*" %>
<%@ page import="com.google.gson.Gson" %><%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 14/06/2024
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Informacionsesion informacionSesion = (Informacionsesion) request.getAttribute("informacionSesion");
    Sesionentrenamiento sesionEntrenamiento = (Sesionentrenamiento) request.getAttribute("sesionEntrenamiento");
    HashMap<Ejerciciosesion, Informacionejercicio> ejercicios = (HashMap<Ejerciciosesion, Informacionejercicio>) request.getAttribute("ejercicios");
    boolean ejercicioSinCompletar = false;

%>
<%!
    public String getDia(int dia) {
        switch (dia) {
            case 1:
                return "Lunes";
            case 2:
                return "Martes";
            case 3:
                return "Miércoles";
            case 4:
                return "Jueves";
            case 5:
                return "Viernes";
            case 6:
                return "Sábado";
            case 7:
                return "Domingo";
            default:
                return "Error";
        }
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sesión Lunes</title>

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
<button class=" mx-3 my-1 btn btn-dark"
        onclick="location.href='/client/rutina?rutinaElegida=<%=sesionEntrenamiento.getRutina().getId()%>'">
    <i class="bi bi-arrow-left"></i> Volver
</button>
<div class="container mt-4">

    <h1 class="text-center"><%=sesionEntrenamiento.getNombre()%>
    </h1>
    <h2 class="text-center">Tu desempeño</h2>

    <div class="card mb-4">
        <div class="card-body text-center fs-3">
            <%
                if (informacionSesion.getFechaFin() != null) {
            %>
            <p>Terminaste la sesión del <%=getDia(sesionEntrenamiento.getDia())%>
                el <%=informacionSesion.getFechaFin()%>
            </p>
            <% } else { %>
            Termina primero todos los ejercicios para ver tu desempeño completo!!
            <%
                }
            %>
        </div>
    </div>

    <h3>Ejercicios</h3>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Ejercicio</th>
            <th>Series completadas</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <%
            Gson gson = new Gson();
            for (Map.Entry<Ejerciciosesion, Informacionejercicio> entry : ejercicios.entrySet()) {
                Ejercicio ejercicio = entry.getKey().getEjercicio();
                HashMap<String, String> especificaciones = gson.fromJson(entry.getKey().getEspecificaciones(), HashMap.class);


        %>
        <tr>

            <td><%=entry.getKey().getEjercicio().getNombre()%>
            </td>
            <td>
                <%
                    if (entry.getValue() == null) {
                        ejercicioSinCompletar = true;
                %>

                No has completado este ejercicio!
                <%

                } else {
                    HashMap<String, String> resultados = gson.fromJson(entry.getValue().getEvaluacion(), HashMap.class);
                    for (int i = 0; i < especificaciones.size(); i++) {
                        String nombre = (String) especificaciones.keySet().toArray()[i];
                        String valorInicial = (String) especificaciones.get(nombre);
                        String valorFinal = (String) resultados.get(nombre);

                %>
                <%=nombre%>: <%=valorFinal%>/<%=valorInicial%> <br/>
                <%
                        }
                    }
                %>
            </td>
            <td>

                <button class="btn btn-secondary editar-btn"

                        <%= entry.getValue() == null ? "disabled" : "onclick='editarDatos(" + entry.getKey().getId() + "," + gson.toJson(entry.getKey().getEspecificaciones()) + "," + gson.toJson(entry.getValue().getEvaluacion()) + ")'" %>>
                    <i class="bi bi-pencil"></i>
                    Editar
                </button>
            </td>
                <%
            }
        %>
        </tbody>
    </table>

    <div class="mb-4">
        <button class="btn btn-danger" onclick="borrarDatos()">Borrar Datos</button>
        <button class="btn btn-primary">Aplicar Filtro</button>
    </div>
    <form method="get" action="/client/rutina/sesion/valorarEntrenamiento">
        <input type="hidden" name="sesionEntrenamiento" value="<%=sesionEntrenamiento.getId()%>">
        <input type="hidden" name="informacionSesion" value="<%=informacionSesion.getId()%>">
        <div class="card">
            <div class="card-body">
                <h4>Tus comentarios sobre la sesión</h4>
                <%
                    if (ejercicioSinCompletar) {
                %>
                Completa los ejercicios para poder dejar un comentario
                <%

                } else {
                %>
                <div class="form-group">
                    <label for="sessionFeedback">Comentario</label>
                    <textarea class="form-control" id="sessionFeedback" rows="4"
                              readonly><%=informacionSesion.getComentario()%>
                </textarea>
                </div>
                <fieldset class="rating al">
                    <input type="radio" id="star5" name="rating"
                           value="5" <%=informacionSesion.getValoracion() == 5 ? "checked" : ""%> disabled/><label
                        class="full"
                        for="star5"
                        title="Magnifico - 5 stars"></label>
                    <input type="radio" id="star4" name="rating"
                           value="4" <%=informacionSesion.getValoracion() == 4 ? "checked" : ""%> disabled/><label
                        class="full"
                        for="star4"
                        title="Bueno - 4 stars"></label>

                    <input type="radio" id="star3" name="rating"
                           value="3" <%=informacionSesion.getValoracion() == 3 ? "checked" : ""%> disabled/><label
                        class="full"
                        for="star3"
                        title="Meh - 3 stars"></label>
                    <input type="radio" id="star2" name="rating"
                           value="2" <%=informacionSesion.getValoracion() == 2 ? "checked" : ""%> disabled/><label
                        class="full"
                        for="star2"
                        title="Malo - 2 stars"></label>
                    <input type="radio" id="star1" name="rating"
                           value="1"  <%=informacionSesion.getValoracion() == 1 ? "checked" : ""%> disabled/><label
                        class="full"
                        for="star1"
                        title="Horrible - 1 star"></label>
                    <input type="radio" class="reset-option" name="rating" value="reset"/>
                </fieldset>
                <%
                    }
                %>
            </div>
            <div class="card-footer">
                <button type="submit" class="btn btn-primary" <%=ejercicioSinCompletar? "disabled" : ""%>>
                    <i class="bi bi-chat-left-text-fill"></i>
                    Editar valoración
                </button>
            </div>
        </div>
    </form>
</div>
<!-- Modal -->
<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <form method="post" action="/client/rutina/sesion/desempenyo/borrar">
        <input type="hidden" name="sesionEntrenamiento" value="<%=sesionEntrenamiento.getId()%>">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Cuidadin!</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Estas seguro que quieres borrar todos los datos de esta sesión?
                    La sesión se reiniciará y no podrás recuperar los datos.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Borrar datos</button>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- Modal Editar-->
<div class="modal fade" id="editarModal" tabindex="-1" aria-labelledby="editarModalLabel" aria-hidden="true">
    <form id="editarForm" method="post" action="/client/rutina/sesion/ejercicio/guardar">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="editarModalLabel">Modificar Datos del ejercicio</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="editarFormPH">
                        <!-- Los inputs se agregarán dinámicamente aquí -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" onclick="guardarNuevosDatos()" class="btn btn-primary">Guardar datos</button>
                </div>
            </div>
        </div>
    </form>
</div>
<div class="modal fade" id="confirmationUpdateModal" tabindex="-1" aria-labelledby="UpdateModalLabel"
     aria-hidden="true">
    <form method="post" action="/client/rutina/sesion/ejercicio/modificar">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="UpdateModalLabel">Seguro que lo snuevos datos son Correctos??</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Una vez confirmados los datos no podrás modificarlos</p>

                    <input type="hidden" name="sesionEntrenamiento" value="<%=sesionEntrenamiento.getId()%>">
                    <input type="hidden" name="ejercicioSesion" id="confirmExercice" value="">
                    <input type="hidden" name="resultados" id="resultados" value="">


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Confirmar</button>
                </div>
            </div>
        </div>
    </form>
</div>

</body>
<script>
    const jsonData = {};

    function borrarDatos() {
        $("#confirmationModal").modal("show");

    }

    function editarDatos(ejercicoId, especificaciones, resultados) {
        const confirmExercice = document.getElementById('confirmExercice');
        confirmExercice.value = ejercicoId;
        const modalEditar = $("#editarModal");
        modalEditar.modal("show");
        const espe = JSON.parse(especificaciones);
        const res = JSON.parse(resultados);
        const form = modalEditar.find('#editarFormPH');
        form.empty();
        $.each(espe, function (nombre, valorInicial) {
            const valorFinal = res[nombre] || 0;

            const inputGroup = '<div class="form-group">' +
                '<label>' + nombre + ':</label>' +
                '<input type="number" class="form-control" name="' + nombre + '" value="' + valorFinal + '" min="0" max="' + valorInicial + '">' +
                '</div>';
            form.append(inputGroup);
        });


    }

    function guardarNuevosDatos() {
        const form = document.getElementById('editarForm');
        const formData = new FormData(form);


        formData.forEach((value, key) => {
            jsonData[key] = value;
        });
        const results = document.getElementById('resultados');
        results.value = JSON.stringify(jsonData);

        $("#editarModal").modal("hide");
        $("#confirmationUpdateModal").modal("show");
    }


</script>
<style>
    @import url(https://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);
    @import url(http://fonts.googleapis.com/css?family=Calibri:400,300,700);


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
