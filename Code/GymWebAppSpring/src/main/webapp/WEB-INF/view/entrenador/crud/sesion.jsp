<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.iu.SesionArgument" %>
<%@ page import="com.example.GymWebAppSpring.iu.RutinaArgument" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.example.GymWebAppSpring.iu.EjercicioArgument" %>
<%@ page import="com.example.GymWebAppSpring.entity.Ejercicio" %>
<%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");

    Integer sesionPos = (Integer) session.getAttribute("sesionPos");
    SesionArgument oldSesion = (SesionArgument) session.getAttribute("oldSesion");

    Object readOnlyObject = request.getAttribute("readOnly");
    boolean readOnly = readOnlyObject != null && ((Boolean) readOnlyObject);
    boolean sesionExists = oldSesion.getId() != -100;

    SesionArgument sesion = rutina.getSesiones().get(sesionPos);
    List<Ejercicio> ejercicios = new ArrayList<>();
    if (!sesion.getEjercicios().isEmpty())
        ejercicios = (List<Ejercicio>) request.getAttribute("ejercicios");
%>

<%!
    public Ejercicio getEjercicioByEjercicioSesion(EjercicioArgument ejercicioArgument, List<Ejercicio> ejercicios) {
        Ejercicio ej = null;

        int i = 0;
        while (i < ejercicios.size() && ej == null) {
            if (ejercicios.get(i).getId().equals(ejercicioArgument.getEjercicio()))
                ej = ejercicios.get(i);
            i++;
        }

        return ej;
    }
%>

<html>
<head>
    <title>Tus rutinas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
<div class="modal fade" id="delete-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="delete-modal-label">Eliminar ejercicio</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="delete-modal-body">
                ¿Estás seguro de que quieres eliminar el ejercicio?
            </div>
            <div class="modal-footer">
                <button id="delete-modal-button" type="button" class="btn btn-danger" data-bs-dismiss="modal">Eliminar
                </button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row mb-3">
        <div class="col-8">
            <h1>Añadir sesión de entrenamiento</h1>
        </div>
        <div class="col-4 d-flex justify-content-end align-items-center">
            <button onClick="<%=readOnly ? "goVolverVerRutina()" : "goVolverEditarRutina()"%>"
                    class="btn btn-primary">Volver</button>
        </div>
    </div>

    <div class="row">
        <div class="col-6">
            <span class="h4 text-secondary">Nombre de la sesión</span><br/>
        </div>
        <div class="col-6">
            <span class="h4 text-secondary">Día</span><br/>
        </div>
    </div>
    <div class="row mb-3">
        <div class="col-6">
            <input id="nombre" type="text" class="form-control mt-2"
                   value="<%=sesion.getNombre()%>" <%=readOnly ? "disabled" : ""%>>
        </div>
        <div class="col-6">
            <input id="dia" type="text" class="form-control mt-2"
                   value='<%=sesion.getDia().isEmpty() ? "" : sesion.getDia()%>' <%=readOnly ? "disabled" : ""%>>
        </div>
    </div>
    <div class="row mb-3">
        <div class="col-12">
            <span class="h4 text-secondary">Descripción de la sesión</span><br/>
            <textarea id="descripcion" class="form-control mt-2" style="resize:none;"
                      rows="3" <%=readOnly ? "disabled" : ""%>><%=sesion.getDescripcion()%></textarea>
        </div>
    </div>
    <div class="row mb-2">
        <div class="col-6">
            <span class="h4 text-secondary">Ejercicios</span><br/>
        </div>
        <%if (!readOnly) {%>
        <div class="col-6 d-flex justify-content-end">
            <a class="btn btn-primary" onClick="goSeleccionarEjercicio()">Añadir ejercicio</a>
        </div>
        <%}%>
    </div>
    <%
        Gson gson = new Gson();

        List<EjercicioArgument> ejerciciosArguments = sesion.getEjercicios();
        for (int i = 0; i < ejerciciosArguments.size(); i++) {
            EjercicioArgument ejercicioSesion = ejerciciosArguments.get(i);
            Ejercicio ejercicio = getEjercicioByEjercicioSesion(ejercicioSesion, ejercicios);
    %>
    <div class="row">
        <div class="col-9 d-flex align-items-center" style="cursor: pointer"
             onClick="<%=readOnly ? ("goVerEjercicio(" + ejercicioSesion.getId() + ")") : ("goEditarEjercicio(" + i + ")")%>">
            <img src="<%=ejercicio.getCategoria().getIcono()%>" alt="Borrar" style="width:50px; height:50px">
            <div class="ms-3">
                <span class="h2"><%=ejercicio.getNombre()%> <span class="text-danger">(<%=ejercicio.getCategoria().getNombre()%>)</span></span></br>
                <span class="h5 text-secondary">
                    <%
                        String data = "";
                        List<String> tiposBase = gson.fromJson(ejercicio.getCategoria().getTiposBase(), ArrayList.class);
                        for (int j = 0; j < tiposBase.size(); j++) {
                            String especificacion = ejercicioSesion.getEspecificaciones().get(tiposBase.get(j)).getAsString();%>
                            <%="<span style='color: black'><b>" + tiposBase.get(j) + "</b></span>: " + (especificacion.isEmpty() ? "Sin especificar" : especificacion) + " "%></br><%
                         }
                    %>
                    <%=data%>
                </span>
            </div>
        </div>
        <%if (!readOnly) {%>
            <div class="col-3 d-flex justify-content-end align-items-center">
                <div onClick="goEditarEjercicio(<%=i%>)" style="cursor: pointer; text-decoration: none;">
                    <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px;">&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
                <div onClick="showDeleteModal('<%=ejercicio.getNombre()%>', <%=i%>)" style="cursor: pointer;">
                    <img src="/svg/trash.svg" alt="Borrar" style="width:50px; height:50px">
                </div>
            </div>
        <%}%>
    </div>
    <hr>
    <%
        }
    %>

    <%if (!readOnly) {%>
        <div class="row">
            <div class="col-12 d-flex justify-content-end">
                <button onClick="goGuardarSesion()" type="submit"
                        class="btn btn-primary"><%=sesionExists ? "Guardar" : "Crear"%>
                </button>
            </div>
        </div>
    <%}%>
</div>
<script>
    function goPage(action, add="") {
        const nombre = document.getElementById("nombre").value;
        const dia = document.getElementById("dia").value;
        const descripcion = document.getElementById("descripcion").value;

        window.location.href = action +
            "?nombre=" + nombre +
            "&dia=" + dia +
            "&descripcion=" + descripcion +
            (add.length === 0 ? "" : "&") + add;
    }

    function goVolverEditarRutina() {
        window.location.href = "/entrenador/rutinas/crear/sesion/volver";
    }

    function goVolverVerRutina() {
        window.location.href = "/entrenador/rutinas/ver?id=<%=rutina.getId()%>";
    }

    function goVerEjercicio(id) {
        window.location.href = "/entrenador/rutinas/crear/ejercicio/ver?id=" + id;
    }

    function goSeleccionarEjercicio() {
        goPage("/entrenador/rutinas/crear/ejercicio/seleccionar");
    }

    function goEditarEjercicio(ejPos) {
        goPage("/entrenador/rutinas/crear/ejercicio/editar", add = "ejPos=" + ejPos);
    }

    function goBorrarEjercicio(ejPos) {
        goPage("/entrenador/rutinas/crear/ejercicio/borrar", add = "ejPos=" + ejPos);
    }

    function goGuardarSesion() {
        goPage("/entrenador/rutinas/crear/sesion/guardar");
    }

    function showDeleteModal(nombre, ejPos) {
        const deleteModal = new bootstrap.Modal(document.getElementById('delete-modal'));
        const modalBody = document.getElementById("delete-modal-body");
        const modalButton = document.getElementById("delete-modal-button");

        modalBody.innerHTML = `¿Estás seguro de que quieres eliminar el ejercicio <b>` + nombre + `</b>?`;
        modalButton.onclick = () => {
            goBorrarEjercicio(ejPos);
        };

        deleteModal.show();
    }
</script>
</body>
</html>
