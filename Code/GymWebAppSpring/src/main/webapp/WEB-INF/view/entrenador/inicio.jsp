<%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 20/04/2024
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
%>
<html>
<head>
    <title>Mi espacio personal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .clickable-card {
            cursor: pointer;
            text-decoration: none;
            transform: scale(1);
            transition-duration: 0.25s;
        }

        .clickable-card:hover {
            transform: scale(1.1);
            transition-duration: 0.25s;
        }
    </style>
</head>
<body>
<jsp:include page="../components/header.jsp"/>
    <div class="container">
        <div class="row mt-4">
            <div class="col-12">
                <div class="card mb-5">
                    <div class="card-body text-center px-5">
                        <h1>Mi espacio personal</h1>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4 gx-5">
            <div class="col-md-6">
                <a class="card clickable-card" href="entrenador/clientes">
                    <div class="card-body text-center px-5">
                        <img src="/svg/clients.svg" alt="Clientes" style="height: 50vh">
                        <h1>Mis clientes</h1>
                    </div>
                </a>
            </div>
            <div class="col-md-6">
                <a class="card clickable-card" href="entrenador/rutinas">
                    <div class="card-body text-center px-5">
                        <img src="/svg/workout.svg" alt="Rutinas" style="height: 50svh">
                        <h1>Mis rutinas</h1>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <!-- Bootstrap Javascript Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
