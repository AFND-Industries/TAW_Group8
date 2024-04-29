<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionentrenamiento" %>
<%@ page import="com.example.GymWebAppSpring.entity.Sesionrutina" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 22/04/2024
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    DayOfWeek diaSemanaActual = LocalDate.now().getDayOfWeek();
    Usuario cliente = (Usuario) request.getAttribute("usuario");
    List<Sesionrutina> sesiones = (List<Sesionrutina>) request.getAttribute("sesiones");
%>
<html>
<head>
    <title>Title</title>
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
                if (sesiones.isEmpty()) {
            %>
            <h1 class="text-center"> No hay sesiones!</h1>
            <%
            } else {
            %>
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Nombre</th>
                    <th scope="col">Progreso</th>
                    <th scope="col"></th>

                </tr>
                </thead>
                <tbody>
                <%
                    for (Sesionrutina s : sesiones) {
                        boolean esHoy = diaSemanaActual.getValue() == s.getDia();

                %>
                <tr class="<%=esHoy ? "table-primary" : ""%>">

                    <td>Sesion de <%=s.getSesionentrenamiento().getNombre()%>
                    </td>
                    <td>Otto</td>
                    <td class="text-end">

                            <%
                            if(esHoy){
                        %>

                    <span class="badge text-bg-warning">
                        Tu sesion de hoy!
                    </span>

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


            <%
                }
            %>
        </div>
    </div>
</div>


</body>
</html>
