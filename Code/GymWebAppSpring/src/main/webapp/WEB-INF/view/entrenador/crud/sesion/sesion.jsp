<%@ page import="com.example.GymWebAppSpring.iu.SesionArgument" %>
<%@ page import="com.example.GymWebAppSpring.iu.RutinaArgument" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.example.GymWebAppSpring.iu.EjercicioArgument" %>
<%@ page import="com.example.GymWebAppSpring.dto.EjercicioDTO" %>
<%@ page import="java.util.*" %>
<%--
  Created by IntelliJ IDEA.
  User: Eulogio Quemada
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
    List<EjercicioDTO> ejercicios = new ArrayList<>();
    if (!sesion.getEjercicios().isEmpty())
        ejercicios = (List<EjercicioDTO>) request.getAttribute("ejercicios");

    List<String> errorList = (List<String>) request.getAttribute("errorList");

    String[] dias = { "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo" };
    List<String> diasCogidos = (List<String>) request.getAttribute("diasCogidos");
%>

<%!
    public EjercicioDTO getEjercicioByEjercicioSesion(EjercicioArgument ejercicioArgument, List<EjercicioDTO> ejercicios) {
        EjercicioDTO ej = null;

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
<jsp:include page="../../../components/header.jsp"/>
<jsp:include page="../components/volver_modal.jsp"/>
<jsp:include page="../components/eliminar_modal.jsp"/>

<div class="container mb-5">
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
        <div class="col-8">
            <h1>Añadir sesión de entrenamiento</h1>
        </div>
        <div class="col-4 d-flex justify-content-end align-items-center">
            <button onClick="<%=readOnly ? "goVolverVerRutina()" : "showVolverModal()"%>"
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
            <input id="nombre" type="text" class="form-control mt-2" maxlength="32" autocomplete="off"
                   value="<%=sesion.getNombre()%>" <%=readOnly ? "disabled" : ""%>>
        </div>
        <div class="col-6">
            <select id="dia" name="dificultad" class="form-select mt-2" <%=readOnly ? "disabled" : ""%>>
                <%for(int i = 1; i <= dias.length; i++) {
                    String selectedDia = sesion.getDia(); int j = 0;
                    while (diasCogidos != null && selectedDia.isEmpty() && j < dias.length) {
                        if (!diasCogidos.contains(dias[j]))
                            selectedDia = dias[j];
                        j++;
                    }%>
                    <option <%=Objects.equals(selectedDia, i + "") ? "selected" :
                            (diasCogidos != null && diasCogidos.contains(i + "") ? "disabled" : "")%>
                            value="<%=i%>"><%=dias[i - 1]%></option>
                <%}%>
            </select>
        </div>
    </div>
    <div class="row mb-3">
        <div class="col-12">
            <span class="h4 text-secondary">Descripción de la sesión</span><br/>
            <textarea id="descripcion" class="form-control mt-2" style="resize:none;" maxlength="256" autocomplete="off"
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
        List<EjercicioArgument> ejerciciosArgument = sesion.getEjercicios();
        Map<Integer, Integer> ejerciciosIndices = new HashMap<>();
        for (int i = 0; i < ejerciciosArgument.size(); i++)
            ejerciciosIndices.put(ejerciciosArgument.get(i).getOrden(), i);

        List<Integer> ordenOrdenados = new ArrayList<>(ejerciciosIndices.keySet());
        Collections.sort(ordenOrdenados);

        for (Integer orden : ordenOrdenados) {
            int posReal = ejerciciosIndices.get(orden);
            EjercicioArgument ejercicioSesion = ejerciciosArgument.get(posReal);
            EjercicioDTO ejercicio = getEjercicioByEjercicioSesion(ejercicioSesion, ejercicios);

            StringBuilder tiposBaseHTML = new StringBuilder();
            List<String> tiposBase = new Gson().fromJson(ejercicio.getCategoria().getTiposBase(), ArrayList.class);
            for (int j = 0; j < tiposBase.size(); j++) {
                String especificacion = ejercicioSesion.getEspecificaciones().get(tiposBase.get(j)).getAsString();
                tiposBaseHTML.append("<span style='color: black'><b>").append(tiposBase.get(j)).append("</b></span>: ").append(especificacion.isEmpty() ? "Sin especificar" : especificacion).append(" ").append("</br>");
            }%>
            <jsp:include page="components/ejercicio_item.jsp" >
                <jsp:param name="readOnly" value="<%=readOnly%>" />
                <jsp:param name="id" value="<%=ejercicioSesion.getId()%>" />
                <jsp:param name="posReal" value="<%=posReal%>" />
                <jsp:param name="orden" value="<%=ejercicioSesion.getOrden() + 1%>" />
                <jsp:param name="icono" value="<%=ejercicio.getCategoria().getIcono()%>" />
                <jsp:param name="nombre" value="<%=ejercicio.getNombre()%>" />
                <jsp:param name="categoriaNombre" value="<%=ejercicio.getCategoria().getNombre()%>" />
                <jsp:param name="tiposBaseHTML" value="<%=tiposBaseHTML.toString()%>" />
                <jsp:param name="isFirst" value="<%=ordenOrdenados.getFirst().equals(orden)%>" />
                <jsp:param name="isLast" value="<%=ordenOrdenados.getLast().equals(orden)%>" />
            </jsp:include>
    <%}%>

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
        window.location.href = "/entrenador/rutinas/sesion/volver";
    }

    function goVolverVerRutina() {
        window.location.href = "/entrenador/rutinas/rutina/ver?id=<%=rutina.getId()%>";
    }

    function goVerEjercicio(id) {
        window.location.href = "/entrenador/rutinas/ejercicio/ver?id=" + id;
    }

    function goSeleccionarEjercicio() {
        goPage("/entrenador/rutinas/ejercicio/seleccionar");
    }

    function goEditarEjercicio(ejPos) {
        goPage("/entrenador/rutinas/ejercicio/editar", add = "ejPos=" + ejPos);
    }

    function goBorrarEjercicio(ejPos) {
        goPage("/entrenador/rutinas/ejercicio/borrar", add = "ejPos=" + ejPos);
    }

    function goMoverEjercicio(ejPos, move) {
        goPage("/entrenador/rutinas/ejercicio/mover", add = "ejPos=" + ejPos + "&move=" + move);
    }

    function goGuardarSesion() {
        goPage("/entrenador/rutinas/sesion/guardar");
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

    function showVolverModal(nombre, pos) {
        const volverModal = new bootstrap.Modal(document.getElementById('volver-modal'));
        const modalButton = document.getElementById("volver-modal-button");

        modalButton.onclick = () => {
            goVolverEditarRutina(pos)
        };

        volverModal.show();
    }
</script>
</body>
</html>
