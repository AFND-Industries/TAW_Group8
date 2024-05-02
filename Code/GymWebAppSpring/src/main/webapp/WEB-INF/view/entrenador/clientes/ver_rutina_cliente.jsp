<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionentrenamiento" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 29/04/2024
  Time: 11:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Rutina rutina = (Rutina) request.getAttribute("rutina");
    List<Sesionentrenamiento> sesiones = (List<Sesionentrenamiento>) request.getAttribute("sesiones");
    Usuario cliente = (Usuario) request.getAttribute("cliente");
    List<Integer> porcentaje = (List<Integer>) request.getAttribute("porcentaje");
%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp"/>

<%
    if (!sesiones.isEmpty()) {
%>
<div class="container">
    <div class="row mb-3">
        <h1> Sesiones de <%= rutina.getNombre()%>
        </h1>
    </div>
    <div class="row mb-3">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>Progreso</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <%
                int i = 0;
                for (Sesionentrenamiento sesion : sesiones) { %>
            <tr>
                <td>
                    <div class="my-2" style="font-size: 18px">
                        <%= sesion.getNombre() %>
                    </div>
                </td>
                <td>
                    <div class="my-2" style="font-size: 18px">
                        <%= porcentaje.get(i)%>%
                    </div>
                </td>
                <td>
                    <a class="btn border border-black"
                       href="/entrenador/clientes/rutinas/verSesion?idSesion=<%= sesion.getId()%>&idCliente=<%= cliente.getId() %>">
                        Ver desempeño
                    </a>
                </td>
            </tr>
            <%
                    i++;
                }
            %>
            </tbody>
        </table>
    </div>

</div>

<%
} else {
%>
<div class="mt-5 text-center">
    <h5>
        No hay sesiones agragadas a esta rutina
    </h5>
    <a class="btn btn-primary mt-4" href="/entrenador/clientes/rutinas?id=<%=cliente.getId()%>">
        Volver atras
    </a>
</div>

<%
    }
%>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
