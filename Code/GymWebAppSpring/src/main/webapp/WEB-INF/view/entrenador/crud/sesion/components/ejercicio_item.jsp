<%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 23/06/2024
  Time: 17:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    boolean readOnly = Boolean.parseBoolean(request.getParameter("readOnly"));
    String id = request.getParameter("id");
    String posReal = request.getParameter("posReal");
    String orden = request.getParameter("orden");
    String icono = request.getParameter("icono");
    String nombre = request.getParameter("nombre");
    String categoriaNombre = request.getParameter("categoriaNombre");
    String tiposBaseHTML = request.getParameter("tiposBaseHTML");
    boolean isFirst = Boolean.parseBoolean(request.getParameter("isFirst"));
    boolean isLast = Boolean.parseBoolean(request.getParameter("isLast"));

%>

<div class="row">
    <div class="col-9 d-flex align-items-center" style="cursor: pointer"
         onClick="<%=readOnly ? ("goVerEjercicio(" + id + ")") : ("goEditarEjercicio(" + posReal + ")")%>">
        <div class="d-flex flex-column justify-content-center align-items-center"
             style="width:50px; height:50px">
            <span class="h1 mb-0 text-dark"><%=orden%>.</span>
        </div>
        <img src="<%=icono%>" alt="Borrar" style="width:50px; height:50px">
        <div class="ms-3">
            <span class="h2"><%=nombre%> <span class="text-danger">(<%=categoriaNombre%>)</span></span></br>
            <span class="h5 text-secondary"><%=tiposBaseHTML%></span>
        </div>
    </div>
    <%if (!readOnly) {%>
    <div class="col-3 d-flex justify-content-end align-items-center">
        <div>
            <%if (!isFirst) {%>
            <div onClick="goMoverEjercicio(<%=posReal%>, -1)" style="cursor: pointer; text-decoration: none;">
                <img src="/svg/caret-up.svg" alt="Subir" style="width:60px; height:60px;">&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
            <%}%>
            <%if (!isLast) {%>
            <div onClick="goMoverEjercicio(<%=posReal%>, 1)" style="cursor: pointer; text-decoration: none;">
                <img src="/svg/caret-down.svg" alt="Bajarr" style="width:60px; height:60px;">&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
            <%}%>
        </div>
        <div onClick="goEditarEjercicio(<%=posReal%>)" style="cursor: pointer; text-decoration: none;">
            <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px;">&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
        <div onClick="showDeleteModal('<%=nombre%>', <%=posReal%>)" style="cursor: pointer;">
            <img src="/svg/trash.svg" alt="Borrar" style="width:50px; height:50px">
        </div>
    </div>
    <%}%>
</div>
<hr>