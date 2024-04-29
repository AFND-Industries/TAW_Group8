<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.entity.Rutina" %><%--
  Created by IntelliJ IDEA.
  User: anton
  Date: 22/04/2024
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Usuario cliente = (Usuario) request.getAttribute("usuario");
    List<Rutina> rutinas = (List<Rutina>) request.getAttribute("rutinas");
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
                if (rutinas.isEmpty()) {
            %>
            <h1 class="text-center"> No hay rutinas asignadas!</h1>
            <%
            } else {
            %>

            <div class="list-group my-2">
                <%--                <a href="#" class="list-group-item list-group-item-action active" aria-current="true">--%>
                <%--                    The current link item--%>
                <%--                </a>--%>
                    <form method="post" action="client/verrutina">
                <%
                    for (Rutina r : rutinas) {


                %>
                        <button type="submit" class="list-group-item list-group-item-action" value="<%=r.getId()%>" name="rutinaElegida"><%=r.getNombre()%></button>

                <%
                    }
                %>
                    </form>
                <%--                    <a href="#" class="list-group-item list-group-item-action">A third link item</a>--%>
                <%--                    <a href="#" class="list-group-item list-group-item-action">A fourth link item</a>--%>
                <%--                    <a class="list-group-item list-group-item-action disabled" aria-disabled="true">A disabled link--%>
                <%--                        item</a>--%>
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
            <%
                }
            %>
        </div>
    </div>
</div>


</body>
</html>
