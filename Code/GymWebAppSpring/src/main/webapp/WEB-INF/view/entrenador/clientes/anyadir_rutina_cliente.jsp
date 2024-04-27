<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alero
  Date: 24/04/2024
  Time: 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Rutina> rutinasCliente = (List<Rutina>) request.getAttribute("rutinasCliente");
    List<Rutina> rutinas = (List<Rutina>) request.getAttribute("rutinasEntrenador");
    int idCliente = (int) request.getAttribute("id");
%>
<html>
<head>
    <title>Add Rutina</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <%@include file="../../components/header.jsp"%>
    <div class="container">
        <div class="row mb-4">
            <div class="col-4">
                <h1>Tus Rutinas</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#filter-modal" >Filtros de búsqueda</button>
                </div>
            </div>
        </div>
        <form method="post" action="/entrenador/clientes/rutinas/guardar">
            <input type="hidden" name="idCliente" value="<%= idCliente %>">
        <%
            for(Rutina rutina : rutinas){
        %>
            <div class="row mb-3">
                <div class="col-8 d-flex align-items-center">
                    <div class="form-check">
                        <%
                            String seleccionado = "";
                            String disabled = "";
                            if(rutinasCliente.contains(rutina)){
                                seleccionado = "checked";
                                disabled = "disabled";
                            }
                        %>
                        <input class="form-check-input" type="checkbox" name="rutinas" value="<%= rutina.getId() %>" id="<%= rutina.getId() %>" <%= seleccionado %> <%= disabled %>>
                        <label class="form-check-label" for="<%= rutina.getId() %>" style="font-size: 20px">
                            <%= rutina.getNombre() %>
                        </label>
                    </div>
                </div>
            </div>
            <hr>
        <%
            }
        %>
        <div class="row">
                <div class="col-12 d-flex justify-content-center">
                    <button type="submit" class="btn btn-primary">Guardar Rutinas</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
