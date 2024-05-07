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
    Gson gson = new Gson();
    String cache = (String) request.getAttribute("cache");
    RutinaArgument rutina = gson.fromJson(cache, RutinaArgument.class);

    Integer sesionPos = (Integer) request.getAttribute("sesionPos");
    String oldSesion = (String) request.getAttribute("oldSesion");

    Object readOnlyObject = request.getAttribute("readOnly");
    boolean readOnly = readOnlyObject != null && ((Boolean) readOnlyObject);
    boolean sesionExists = !oldSesion.equals("{}");

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
<script>
    const cache = <%=cache%>;
    const oldSesion = <%=oldSesion%>;
    console.log(<%=oldSesion%>);
</script>
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
    <input id="sesionId" type="hidden" name="id" value="<%=sesion.getId()%>"/>
    <div class="row mb-3">
        <div class="col-8">
            <h1>Añadir sesión de entrenamiento</h1>
        </div>
        <div class="col-4 d-flex justify-content-end align-items-center">
            <button onClick="enviarJSON('/entrenador/rutinas/' + <%=(readOnly ? "'ver'" : "'editar'")%>, save = <%=readOnly ? "true" : "false"%>)"
                    class="btn btn-primary">Volver
            </button>
        </div>
    </div>

    <div class="row mb-3">
        <div class="col-12">
            <span class="h4 text-secondary">Nombre de la sesión</span><br/>
        </div>
        <div class="col-12">
            <input id="nombre" type="text" class="form-control mt-2"
                   value="<%=sesion.getNombre()%>" <%=readOnly ? "disabled" : ""%>>
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
            <a class="btn btn-primary"
               onClick="enviarJSON('/entrenador/rutinas/crear/ejercicio/seleccionar', save = true,
                       additionalParams='pos=<%=sesionPos%>&oldSesion=<%=URLEncoder.encode(oldSesion, StandardCharsets.UTF_8)%>')">Añadir
                ejercicio</a>
        </div>
        <%}%>
    </div>
    <%
        List<EjercicioArgument> ejerciciosArguments = sesion.getEjercicios();
        for (int i = 0; i < ejerciciosArguments.size(); i++) {
            EjercicioArgument ejercicioSesion = ejerciciosArguments.get(i);
            Ejercicio ejercicio = getEjercicioByEjercicioSesion(ejercicioSesion, ejercicios);
    %>
    <div class="row">
        <div class="col-9 d-flex align-items-center" style="cursor: pointer"
             onClick="enviarJSON('/entrenador/rutinas/crear/ejercicio/<%=readOnly ? "ver" : "editar"%>', save = true, 'pos=<%= sesionPos %>&oldSesion=<%=URLEncoder.encode(gson.toJson(sesion), StandardCharsets.UTF_8)%>&ejercicioPos=<%=i%>&ejbase=<%=ejercicio.getId()%>')">
            <img src="<%=ejercicio.getCategoria().getIcono()%>" alt="Borrar" style="width:50px; height:50px">
            <div class="ms-3">
                <span class="h2"><%=ejercicio.getNombre()%> <span class="text-danger">(<%=ejercicio.getCategoria().getNombre()%>)</span></span></br>
                <span class="h5 text-secondary">
                    <%
                        String data = "";
                        List<String> tiposBase = gson.fromJson(ejercicio.getCategoria().getTiposBase(), ArrayList.class);
                        for (int j = 0; j < tiposBase.size(); j++) {
                            String especificacion = ejercicioSesion.getEspecificaciones().get(j);%>
                            <%="<span style='color: black'><b>" + tiposBase.get(j) + "</b></span>: " + (especificacion.isEmpty() ? "Sin especificar" : especificacion) + " "%></br><%
                         }
                    %>
                    <%=data%>
                </span>
            </div>
        </div>
        <%if (!readOnly) {%>
            <div class="col-3 d-flex justify-content-end align-items-center">
                <div onClick="enviarJSON('/entrenador/rutinas/crear/ejercicio/editar', save = true, 'pos=<%= sesionPos %>&oldSesion=<%=URLEncoder.encode(gson.toJson(sesion), StandardCharsets.UTF_8)%>&ejercicioPos=<%=i%>&ejbase=<%=ejercicio.getId()%>')"
                     style="cursor: pointer; text-decoration: none;">
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
                <button onClick="enviarJSON('/entrenador/rutinas/editar')" type="submit"
                        class="btn btn-primary"><%=sesionExists ? "Guardar" : "Crear"%>
                </button>
            </div>
        </div>
    <%}%>
</div>
<script>
    console.log(cache);

    function enviarJSON(action, save = true, additionalParams = "") {
        if (save) {
            cache.sesiones[<%=sesionPos%>] = {
                "id": document.getElementById("sesionId").value,
                "nombre": document.getElementById("nombre").value,
                "descripcion": document.getElementById("descripcion").value,
                "ejercicios": <%=gson.toJson(sesion.getEjercicios())%>
            }
        } else {
            if (Object.keys(oldSesion).length > 0) cache.sesiones[<%=sesionPos%>] = oldSesion;
            else cache.sesiones.splice(<%=sesionPos%>, 1);
        }

        const cacheString = encodeURIComponent(JSON.stringify(cache));
        window.location.href =
            action + "?cache=" + cacheString + (additionalParams.length > 0 ? "&" : "") + additionalParams;
    }

    function showDeleteModal(nombre, ejPos) {
        const deleteModal = new bootstrap.Modal(document.getElementById('delete-modal'));
        const modalBody = document.getElementById("delete-modal-body");
        const modalButton = document.getElementById("delete-modal-button");

        modalBody.innerHTML = `¿Estás seguro de que quieres eliminar el ejercicio <b>` + nombre + `</b>?`;
        modalButton.onclick = () => {
            enviarJSON('/entrenador/rutinas/crear/ejercicio/borrar', save = true, 'ejPos=' + ejPos + '&pos=<%=sesionPos%>&oldSesion=<%=URLEncoder.encode(oldSesion, StandardCharsets.UTF_8)%>')
        };

        deleteModal.show();
    }
</script>
</body>
</html>
