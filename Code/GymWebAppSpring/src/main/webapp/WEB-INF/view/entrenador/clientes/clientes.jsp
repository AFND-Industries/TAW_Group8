<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 22/04/2024
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Usuario> clientes = (List<Usuario>) request.getAttribute("clientes");
%>
<html>
<head>
    <title>Tus Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="/header.js"></script>

</head>
<body>
    <header id="header"></header>
    <script>
        createHeader("clientes")
    </script>
    <div class="container">
        <div class="row mb-4">
            <div class="col-4">
                <h1>Tus clientes</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#filter-modal" >Filtros de búsqueda</button>
                </div>
            </div>
        </div>
        <%
            for(Usuario cliente : clientes){
        %>
        <div class="row">
            <div class="col-8 d-flex align-items-center">
                <i class="bi bi-person-square" style="font-size: 40px"></i>
                <button class="btn ms-3" style="font-size: 20px;  background-color:transparent; border: transparent"> <%= cliente.getNombre()%> <%= cliente.getApellidos()%></button>
            </div>
        </div>
        <hr>
        <%
            }
        %>
    </div>

</body>
</html>
