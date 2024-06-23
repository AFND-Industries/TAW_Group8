<%--
  Created by IntelliJ IDEA.
  User: Eulogio Quemada
  Date: 23/06/2024
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String logo = request.getParameter("logo");
    String nombre = request.getParameter("nombre");
    String descripcion = request.getParameter("descripcion");

    descripcion = descripcion.length() > 64 ? (descripcion.substring(0, 64) + "...") : descripcion;
%>

<div class="row">
    <a class="col-9 d-flex align-items-center" style="height:75px; text-decoration: none; cursor: pointer;"
       href="/entrenador/rutinas/rutina/ver?id=<%= id %>">
        <img src="<%= logo %>" alt="Dificultad" style="width:50px; height:50px">
        <div class="ms-3">
            <span class="h2" style="color: black;"><%= nombre %></span><br>
            <span class="h5 text-secondary"><%= descripcion %></span>
        </div>
    </a>
    <div class="col-3 d-flex justify-content-end align-items-center">
        <a href="/entrenador/rutinas/rutina/editar?id=<%= id %>" style="cursor: pointer; text-decoration: none;">
            <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px;">&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
        <div style="cursor: pointer;" onclick="showDeleteModal('<%= nombre %>', '<%= id %>')">
            <img src="/svg/trash.svg" alt="Borrar" style="width:50px; height:50px">
        </div>
    </div>
</div>
<hr>
