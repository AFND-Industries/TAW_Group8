<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutinacliente" %>
<%@ page import="com.example.GymWebAppSpring.dto.RutinaDTO" %>
<%@ page import="com.example.GymWebAppSpring.dto.UsuarioDTO" %>
<%@ page import="com.example.GymWebAppSpring.dto.RutinaclienteDTO" %><%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 22/04/2024
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    UsuarioDTO cliente = (UsuarioDTO) request.getAttribute("usuario");
    List<RutinaclienteDTO> rutinas = (List<RutinaclienteDTO>) request.getAttribute("rutinas");
%>
<html>
<head>
    <title>Mi espacio personal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../components/header.jsp"/>
<div class="text-center">
    <h1 class="">Mi espacio personal</h1>
    <h2 class="">Bienvenido de vuelta <%=cliente.getNombre() + " " + cliente.getApellidos()%>!</h2>
</div>
<p></p>
<div class="container-fluid">
    <div class="row d-flex justify-content-center align-items-center ">
        <div class="col-6 flex-column mx-5 border border-primary border-3 rounded" style="height: 400px">
            <%
                if (rutinas.isEmpty()) {
            %>
            <h1 class="text-center"> No hay rutinas asignadas!</h1>
            <%
            } else {
            %>
            <div class="list-group my-2">
                <form method="get" action="client/rutina">
                    <%
                        for (RutinaclienteDTO rutinacliente : rutinas) {
                            RutinaDTO r = rutinacliente.getRutina();
                    %>
                    <button type="submit"
                            class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
                            value="<%=r.getId()%>" name="rutinaElegida">

                        <span><%=r.getNombre()%></span>
                        <span>Fecha Creacion: <%=r.getFechaCreacion()%></span>
                    </button>
                    <%
                        }
                    %>
                </form>
            </div>
            <%
                }
            %>
        </div>
        <div class="d-flex justify-content-center">
            <nav aria-label="..." class="mt-1 ">
                <ul class="pagination">
                    <li class="page-item disabled">
                        <a class="page-link">Previous</a>
                    </li>
                    <li class="page-item active" aria-current="page"><a class="page-link" href="#">1</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item disabled">
                        <a class="page-link" href="#">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
