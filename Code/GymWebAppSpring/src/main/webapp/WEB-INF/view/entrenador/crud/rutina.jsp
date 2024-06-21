<%@ page import="com.example.GymWebAppSpring.iu.RutinaArgument" %>
<%@ page import="com.example.GymWebAppSpring.iu.SesionArgument" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.GymWebAppSpring.dto.DificultadDTO" %><%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%
    RutinaArgument rutina = (RutinaArgument) session.getAttribute("cache");
    List<DificultadDTO> dificultades = (List<DificultadDTO>) request.getAttribute("dificultades");

    Object readOnlyObject = request.getAttribute("readOnly");
    boolean rutinaExists = rutina.getId() >= 0;
    boolean readOnly = readOnlyObject != null && ((Boolean) readOnlyObject);

    List<String> errorList = (List<String>) request.getAttribute("errorList");
    String[] dias = { "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo" };
%>

<html>
<head>
    <title>Tus rutinas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
    <div class="modal fade" id="delete-modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="delete-modal-label">Eliminar sesión</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="delete-modal-body">
                    ¿Estás seguro de que quieres eliminar la sesion?
                </div>
                <div class="modal-footer">
                    <button id="delete-modal-button" type="button" class="btn btn-danger">Eliminar</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <%if (errorList != null && !errorList.isEmpty()) {%>
        <div class="row-mb-3">
            <%for (String error : errorList) {%>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%=error%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%}%>
        </div>
        <%}%>
         <div class="row mb-3">
            <div class="col-4">
                <h1>Crear nueva rutina</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <a href="/entrenador/rutinas" class="btn btn-primary">Volver</a>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-6">
                <span class="h4 text-secondary">Nombre de la rutina</span><br/>
                <input id="nombre" name="nombre" value="<%=rutina.getNombre()%>" type="text" class="form-control mt-2" <%=readOnly ? "disabled" : ""%>>
            </div>
            <div class="col-6">
                <span class="h4 text-secondary">Dificultad</span><br/>
                <select id="dificultad" name="dificultad" class="form-select mt-2" id="dificultad" <%=readOnly ? "disabled" : ""%>>
                    <%for(DificultadDTO dificultad : dificultades) {%>
                    <option <%=Objects.equals(rutina.getDificultad(), dificultad.getId()) ? "selected" : ""%>
                            value="<%=dificultad.getId()%>"><%=dificultad.getNombre()%></option>
                    <%}%>
                </select>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-12">
                <span class="h4 text-secondary">Descripción de la rutina</span><br/>
                <textarea id="descripcion" name="descripcion" class="form-control mt-2" style="resize:none;" rows="3" <%=readOnly ? "disabled" : ""%>><%=rutina.getDescripcion()%></textarea>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-6">
                <span class="h4 text-secondary">Sesiones de entrenamiento</span><br/>
            </div>
            <%if (!readOnly) {%>
                <div class="col-6 d-flex justify-content-end">
                    <button class="btn btn-primary" onClick="goCrearSesion()">Añadir sesión de entrenamiento</button>
                </div>
            <%}%>
        </div>
        <%
            List<SesionArgument> sesiones = rutina.getSesiones();
            Map<String, Integer> sesionIndices = new HashMap<>();
            for (int i = 0; i < sesiones.size(); i++)
                sesionIndices.put(sesiones.get(i).getDia(), i);

            List<String> diasOrdenados = new ArrayList<>(sesionIndices.keySet());
            Collections.sort(diasOrdenados);

            for (String dia : diasOrdenados) {
                int posReal = sesionIndices.get(dia);
                SesionArgument sesion = sesiones.get(posReal);
        %>
            <div class="row">
                <div class="col-9 d-flex align-items-center" style="height:75px; text-decoration: none; cursor: pointer;"
                     onClick="<%=readOnly ? ("goVerSesion(" + sesion.getId() + ")") : ("goEditarSesion(" + posReal + ")")%>">
                    <div class="d-flex flex-column justify-content-start align-items-center"
                         style="width: 125px">
                        <span class="h3 mb-0 text-danger"><%=dias[Integer.parseInt(sesion.getDia()) - 1]%></span>
                    </div>
                    <div class="ms-3">
                        <span class="h2" style="color: black;"><%=sesion.getNombre()%></span><br>
                        <span class="h5 text-secondary"><%=sesion.getDescripcion()%></span>
                    </div>
                </div>
                <%if (!readOnly) {%>
                    <div class="col-3 d-flex justify-content-end align-items-center">
                        <div onClick="goEditarSesion(<%= posReal %>)" style="cursor: pointer; text-decoration: none;">
                            <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px;">&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                        <div style="cursor: pointer;" onclick="showDeleteModal('<%=sesion.getNombre()%>', '<%= posReal %>')">
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
                    <button onClick="goGuardarRutina();" class="btn btn-primary"><%=rutinaExists ? "Guardar" : "Crear"%></button>
                </div>
            </div>
        <%}%>
    </div>
<script>
    function goPage(action, add="") {
        const nombre = document.getElementById("nombre").value;
        const dificultad = document.getElementById("dificultad").value;
        const descripcion = document.getElementById("descripcion").value;

       window.location.href = action +
            "?nombre=" + nombre +
            "&dificultad=" + dificultad +
            "&descripcion=" + descripcion +
            (add.length === 0 ? "" : "&") + add;
    }

    function goVerSesion(id) {
        window.location.href = '/entrenador/rutinas/sesion/ver?id=' + id; // no necesita el nombre dificultad y demas
    }

    function goCrearSesion() {
        goPage('/entrenador/rutinas/sesion/crear');
    }

    function goEditarSesion(pos) {
        goPage(action = '/entrenador/rutinas/sesion/editar', add = 'pos=' + pos);
    }

    function goBorrarSesion(pos) {
        goPage('/entrenador/rutinas/sesion/borrar', 'pos=' + pos);
    }

    function goGuardarRutina() {
        goPage('/entrenador/rutinas/rutina/guardar');
    }

    function showDeleteModal(nombre, pos) {
        const deleteModal = new bootstrap.Modal(document.getElementById('delete-modal'));
        const modalBody = document.getElementById("delete-modal-body");
        const modalButton = document.getElementById("delete-modal-button");

        modalBody.innerHTML = `¿Estás seguro de que quieres eliminar la sesión <b>` + nombre + `</b>?`;
        modalButton.onclick = () => {
            goBorrarSesion(pos)
        };

        deleteModal.show();
    }
</script>
</body>
</html>
