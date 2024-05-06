<%@ page import="com.google.gson.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Ejercicio ejercicio = (Ejercicio) request.getAttribute("ejercicio");
    Sesionentrenamiento sesion = (Sesionentrenamiento) request.getAttribute("sesion");
    Informacionejercicio info = (Informacionejercicio) request.getAttribute("informacionEjercicio");
    String repeticiones = (String) request.getAttribute("repeticionesTotales");

    Gson gson = new Gson();
    System.out.println(info.getEvaluacion());
    JsonArray jsonArray = gson.fromJson(info.getEvaluacion(), JsonArray.class);

    List<JsonElement> elementos = jsonArray.asList();

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
        <a class="btn btn-outline-secondary"
           href="/entrenador/clientes/rutinas/verSesion?idSesion=<%= sesion.getId()%>">
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
    <div class="row mb-3 d-flex text-center">
        <h4><%=ejercicio.getNombre()%>
        </h4>
    </div>

    <div class="row mb-3">
        <div class="col mb-3">
            <h6>Descripcion</h6>
            <%=ejercicio.getDescripcion()%>
        </div>
        <div class="mb-3">
            <h6>Video:</h6>
            <br>
            <iframe width="560" height="315" src="<%=ejercicio.getVideo()%>?rel=0"
                    title=" YouTube video player
            " frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                    referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
        </div>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Serie</th>
                <th>Num repeticiones realizadas</th>
                <th>¿Menos peso?</th>
            </tr>
            </thead>
            <tbody>
            <%
                int i = 1;
                for (JsonElement elemento : elementos) {
            %>
            <tr>
                <td>
                    <div class="my-2" style="font-size: 18px">
                        <%=i%>
                    </div>
                </td>
                <td>
                    <div class="my-2" style="font-size: 18px">
                        <%= elemento.getAsJsonObject().get("repeticiones") %> / <%=repeticiones%>
                    </div>
                </td>
                <td>
                    <div class="my-2" style="font-size: 18px">
                        <%= elemento.getAsJsonObject().get("mpeso") %>
                    </div>
                </td>
            </tr>
            <%
                    i++;
                } %>
            </tbody>
        </table>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
