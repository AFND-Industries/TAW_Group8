<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 29/04/2024
  Time: 18:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Usuario usuario = (Usuario) request.getAttribute("user");
    List<Usuario> entrenadores = (List<Usuario>) request.getAttribute("trainers");
    List<Usuario> selected = (List<Usuario>) request.getAttribute("sTrainers");
    Boolean contains = (Boolean) request.getAttribute("contains");
%>
<html>
<head>
    <title>Asignar entrenador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp"/>

<div class="container text-center">
    <h2 class="mb-4">Asignar entrenadores a <%=usuario.getNombre()%></h2>
        <form method="post" action="/admin/assign">
            <input type="hidden" value="<%=usuario.getId()%>" name="user" />
            <%
                for (Usuario entrenador : entrenadores){
            %>
                <input type="checkbox" class="form-check-input mb-3" value="<%=entrenador.getId()%>" name="trainers" <%=selected.contains(entrenador) ? "checked" : ""%>  />
                <label><%=entrenador.getNombre()%> <%=entrenador.getApellidos()%></label>
            <%
                }
            %>
            <button class="btn btn-primary w-100">
                <i class="bi bi-floppy-2-fill"></i> Asignar entrenadores
            </button>
        </form>
</div>

<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
