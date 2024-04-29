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
%>
<html>
<head>
    <title>Listado de usuarios</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
<div class="container">
    <h1 class="text-center mb-2">Listado de usuarios</h1>
    <form class="d-flex justify-content-between g-3" method="post" action="">
        <input type="text" class="form-control" name="dni" placeholder="DNI" />
        <input type="text" class="form-control ms-2" name="apellidos" placeholder="Apellidos" />
        <input type="number" class="form-control ms-2" name="edad" placeholder="Edad" />
        <select class="form-select ms-2" name="tipo">
            <option disabled selected>Tipo de usuario</option>
            <%
                for (Tipousuario tipo : tipos){
            %>
                <option value="<%=tipo.getId()%>"><%=tipo.getNombre()%></option>
            <%
                }
            %>
        </select>
        <button class="btn btn-primary d-flex align-items-center ms-2">
            <i class="bi bi-funnel me-2"></i> Filtrar
        </button>
    </form>
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
            for(Usuario usuario : usuarios) {
        %>
        <a href="/admin/view?id=<%=usuario.getId()%>">
            <tr>
                <td><%= usuario.getNombre() %></td>
                <td><%= usuario.getApellidos() %></td>
                <td><%=usuario.getEdad()%></td>
                <td><%= usuario.getDni() %></td>
                <td><%= usuario.getTipo().getNombre() %></td>
                <td>
                    <a href="/admin/edit?id=<%=usuario.getId()%>"><i class="bi bi-pencil-square me-3"></i></a>
                    <a href="/admin/delete?id=<%=usuario.getId()%>"><i class="bi bi-trash3 me-3"></i></a>
                    <%
                        if (usuario.getTipo().getNombre().equals("Cliente")){
                    %>
                    <a href="/admin/assign?id=<%=usuario.getId()%>"><i class="bi bi-person-check me-3"></i></a>

                    <%
                        }
                    %>
                </td>
            </tr>
        </a>

        <%
            }
        %>
        </tbody>
    </table>
    <div class="text-center">
        <a class="btn btn-outline-secondary px-2" href="/admin/register">
            <i class="bi bi-plus-circle me-1"></i> Añadir usuario
        </a>
    </div>
</div>
<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>

