<%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 23/06/2024
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    boolean readOnly = Boolean.parseBoolean(request.getParameter("readOnly"));
    String id = request.getParameter("id");
    String posReal = request.getParameter("posReal");
    String dia = request.getParameter("dia");
    String nombre = request.getParameter("nombre");
    String descripcion = request.getParameter("descripcion");

    descripcion = descripcion.length() > 64 ? (descripcion.substring(0, 64) + "...") : descripcion;
%>

<div class="row">
    <div class="col-9 d-flex align-items-center" style="height:75px; text-decoration: none; cursor: pointer;"
         onClick="<%=readOnly ? ("goVerSesion(" + id + ")") : ("goEditarSesion(" + posReal + ")")%>">
        <div class="d-flex flex-column justify-content-start align-items-center"
             style="width: 125px">
            <span class="h3 mb-0 text-danger"><%=dia%></span>
        </div>
        <div class="ms-3">
            <span class="h2" style="color: black;"><%=nombre%></span><br>
            <span class="h5 text-secondary"><%=descripcion%></span>
        </div>
    </div>
    <%if (!readOnly) {%>
    <div class="col-3 d-flex justify-content-end align-items-center">
        <div onClick="goEditarSesion(<%= posReal %>)" style="cursor: pointer; text-decoration: none;">
            <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px;">&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
        <div style="cursor: pointer;" onclick="showDeleteModal('<%=nombre%>', '<%= posReal %>')">
            <img src="/svg/trash.svg" alt="Borrar" style="width:50px; height:50px">
        </div>
    </div>
    <%}%>
</div>
<hr>