<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Tipousuario" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 22/04/2024
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("users");
    List<Tipousuario> tipos = (List<Tipousuario>) request.getAttribute("tipos");
    String _dni = (String) request.getAttribute("dniFilter");
    String _apellidos = (String) request.getAttribute("apellidosFilter");
    Integer _edad = (Integer) request.getAttribute("edadFilter");
    Tipousuario _tipo = (Tipousuario) request.getAttribute("tipoFilter");
%>
<html>
<head>
    <title>Listado de usuarios</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
<div class="container">
    <h1 class="text-center mb-2">Listado de usuarios</h1>
    <form class="d-flex justify-content-between" method="post" action="">
        <input type="text" class="form-control" value="<%=_dni != null ? _dni : ""%>" name="dni" placeholder="DNI"/>
        <input type="text" class="form-control ms-2" value="<%=_apellidos != null ? _apellidos : ""%>" name="apellidos"
               placeholder="Apellidos"/>
        <input type="number" class="form-control ms-2" value="<%=_edad != null ? _edad : ""%>" name="edad"
               placeholder="Edad"/>
        <select class="form-select ms-2" name="tipo">
            <option disabled <%=_tipo == null ? "selected" : ""%>>Tipo de usuario</option>
            <%
                for (Tipousuario tipo : tipos) {
            %>
            <option value="<%=tipo.getId()%>" <%=tipo != null && tipo.equals(_tipo) ? "selected" : ""%>><%=tipo.getNombre()%>
            </option>
            <%
                }
            %>
        </select>
        <button class="btn btn-primary d-flex align-items-center ms-2">
            <i class="bi bi-funnel me-2"></i> Filtrar
        </button>
    </form>
    <div class="row mb-2">
        <h5>Leyenda</h5>
        <div class="col">
            <i class="bi bi-book me-1"></i> Ver información del usuario
        </div>
        <div class="col">
            <i class="bi bi-pencil-square me-1"></i> Editar usuario
        </div>
        <div class="col">
            <i class="bi bi-trash3 me-1"></i> Eliminar usuario
        </div>
        <div class="col">
            <i class="bi bi-person-check me-1"></i> Asignar entrenador al usuario
        </div>
    </div>
    <table class="table table-striped">
        <thead>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Edad</th>
        <th>DNI</th>
        <th colspan="2">Tipo usuario</th>
        </thead>
        <tbody>
        <%
            if (usuarios.isEmpty()) {
        %>
        <tr>
            <th colspan="6" style="text-align: center">¡Ups! No se ha encontrado ningún usuario :(</th>
        </tr>
        <%
            }
        %>
        <%
            for (Usuario usuario : usuarios) {
        %>
        <tr>
            <td><%= usuario.getNombre() %>
            </td>
            <td><%= usuario.getApellidos() %>
            </td>
            <td><%=usuario.getEdad()%>
            </td>
            <td><%= usuario.getDni() %>
            </td>
            <td><%= usuario.getTipo().getNombre() %>
            </td>
            <td>
                <a href="/admin/users/view?id=<%=usuario.getId()%>" class="me-3"><i class="bi bi-book me-1"></i></a>
                <a href="/admin/users/edit?id=<%=usuario.getId()%>" class="me-3"><i class="bi bi-pencil-square me-1"></i></a>
                <a href="/admin/users/delete?id=<%=usuario.getId()%>" class="me-3"><i class="bi bi-trash3 me-1"></i></a>
                <%
                    if (usuario.getTipo().getNombre().equals("Cliente")) {
                %>
                <a href="/admin/assign?id=<%=usuario.getId()%>" class="me-3"><i class="bi bi-person-check me-1"></i></a>

                <%
                    }
                %>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <h5 class="text-center"><%=usuarios.size()%> usuario<%=usuarios.size() != 1 ? "s" : ""%>
        obtenido<%=usuarios.size() != 1 ? "s" : ""%>
    </h5>
    <div class="text-center">
        <a class="btn btn-outline-secondary px-2 mb-3" href="/admin/register">
            <i class="bi bi-plus-circle me-1"></i> Añadir usuario
        </a>
    </div>
</div>
<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>

