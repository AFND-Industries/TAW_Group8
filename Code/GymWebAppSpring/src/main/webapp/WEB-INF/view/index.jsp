<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 08/04/2024
  Time: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
%>
<html>
<head>
    <title>Example jsp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <div class="container text-center mt-2">
        <h1 class="mb-2">Listado de usuarios</h1>
        <table class="table">
            <thead>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellidos</th>
                <th>Genero</th>
                <th>Edad</th>
                <th>DNI</th>
                <th>Tipo usuario</th>
            </thead>
            <tbody>
            <%
                for(Usuario usuario : usuarios) {
            %>
            <tr>
                <td><%= usuario.getId() %></td>
                <td><%= usuario.getNombre() %></td>
                <td><%= usuario.getApellidos() %></td>
                <td><%= usuario.getGenero() %></td>
                <td><%= usuario.getEdad() %></td>
                <td><%= usuario.getDni() %></td>
                <td><%= usuario.getTipo().getNombre() %></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

    </div>
</body>
</html>
