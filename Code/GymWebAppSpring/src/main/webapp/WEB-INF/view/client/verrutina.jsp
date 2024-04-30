<%@ page import="java.util.List" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.example.GymWebAppSpring.entity.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %><%--
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
    Map<Sesionrutina, List<Ejerciciosesion>> sesionesEjercicios = (Map<Sesionrutina, List<Ejerciciosesion>>) request.getAttribute("sesionesEjercicios");
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
                if (sesionesEjercicios.isEmpty()) {
            %>
            <h1 class="text-center"> No hay sesiones!</h1>
            <%
            } else {
            %>
            <table class="table ">
                <thead>
                <tr>
                    <th scope="col">Nombre</th>
                    <th scope="col">Progreso</th>
                    <th scope="col"></th>

                </tr>
                </thead>
                <tbody>
                <%
                    for (Sesionrutina s : sesionesEjercicios.keySet()) {
                        boolean esHoy = diaSemanaActual.getValue() == s.getDia();
                        DayOfWeek diaSemana = DayOfWeek.of(s.getDia());
                        String nombreDia = diaSemana.getDisplayName(
                                java.time.format.TextStyle.FULL,
                                new Locale("es", "ES")
                        );
                %>
                <tr class="<%=esHoy ? "table-primary" : ""%>">

                    <td><a  role="button" class="<%=esHoy ? "btn btn-warning" : "btn btn-outline-primary"%>" href="/client">Sesion de <%=s.getSesionentrenamiento().getNombre()%></a>
                    </td>
                    <td> <%=sesionesEjercicios.get(s).size()!=0 ? (sesionesEjercicios.get(s).size()*100/sesionesEjercicios.get(s).size()) : "Nan"%>% completada! </td>
                    <td class="text-end">


                    <span class="badge text-bg-<%=esHoy ? "warning" : "primary"%>">
                        Tu sesion del <%=esHoy ? "dia de hoy": nombreDia%>
                    </span>


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
