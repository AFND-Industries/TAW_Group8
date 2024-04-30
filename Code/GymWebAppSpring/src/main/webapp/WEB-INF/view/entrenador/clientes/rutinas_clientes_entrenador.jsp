<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.Arrays" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 23/04/2024
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Rutina> rutinas = (List<Rutina>) request.getAttribute("rutinas");
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    int[] sesiones = (int[]) request.getAttribute("numSesiones");
%>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
<div class="modal fade" id="delete-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="delete-modal-label">Eliminar rutina</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p style="display: flex; justify-content: center"> ¿Estás seguro de que quieres eliminar la rutina? </p>
                <p id="rutina-nombre"></p>
            </div>
            <div class="modal-footer">
                <a id="delete-option" class="btn btn-danger">Eliminar</a>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>

<script>
    function mostrarDetalleRutina(nombreRutina, idRutina) {
        document.getElementById('rutina-nombre').textContent = 'Nombre: ' + nombreRutina;
        document.getElementById('delete-option').setAttribute('href', '/entrenador/clientes/rutinas/eliminarRutina?idRutina=' + idRutina + '&idCliente=<%= usuario.getId()%>');
    }

    document.addEventListener('DOMContentLoaded', function () {
        var trashIcons = document.querySelectorAll('.delete-icon');

        trashIcons.forEach(function (icon) {
            icon.addEventListener('click', function () {
                var nombreRutina = icon.getAttribute('data-rutina-nombre');
                var idRutina = icon.getAttribute('data-rutina-id');
                mostrarDetalleRutina(nombreRutina, idRutina);
            });
        });
    });


</script>

<div class="container">
    <div class="row mb-3">
        <h1> Rutinas de <%= usuario.getNombre()%> <%= usuario.getApellidos() %> </h1>
    </div>
    <div class="row mb-3">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>Sesiones</th>
            </tr>
            </thead>
            <tbody>
            <% int i = 0;
                for (Rutina rutina : rutinas) { %>
            <tr>
                <td><a class="btn" style="font-size: 20px; border: transparent" href="/entrenador/clientes/rutinas/verRutina?idRutina=<%= rutina.getId() %>&idCliente=<%=usuario.getId()%>">
                    <%= rutina.getNombre() %>
                </a></td>
                <td><div class="my-2" style="font-size: 18px">
                    0 / <%= sesiones[i] %>
                </div></td>
                <td>
                    <div class="my-3" data-bs-toggle="modal" data-bs-target="#delete-modal" style="cursor: pointer;">
                        <i class="bi bi-trash delete-icon"
                           data-rutina-nombre="<%= rutina.getNombre() %>"
                            data-rutina-id="<%= rutina.getId() %>"
                        >
                        </i>
                    </div>
                </td>
            </tr>
            <% i++; } %>
            </tbody>
        </table>
    </div>
    <div class="row d-flex justify-content-center">
        <a href="/entrenador/clientes/rutinas/anyadirRutina?id=<%= usuario.getId() %>" class="btn btn-primary" style="width: 15%">Nueva Rutina</a>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
