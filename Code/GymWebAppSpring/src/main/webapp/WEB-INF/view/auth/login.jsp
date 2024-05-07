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
    <title>Iniciar Sesión</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        .css-selector {
            background: linear-gradient(270deg, #30323d, #4d5061, #5c80bc);
            background-size: 600% 600%;

            animation: AnimationName 31s ease infinite;
        }

        @keyframes AnimationName {
            0% {
                background-position: 0% 50%
            }
            50% {
                background-position: 100% 50%
            }
            100% {
                background-position: 0% 50%
            }
        }

        body {
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body class="vh-100  css-selector">
<div class="d-flex align-items-center" style="height: 10%">
    <a href="/" class="btn btn-dark mx-5">Volver</a>
</div>

<div class=" d-flex justify-content-center align-items-center" style="height: 80%">
    <div class="card">
        <div class="card-body text-center px-5">
            <h2 class="card-title">Iniciar Sesión</h2>
            <form method="post" action="/login">
                <label for="userInput">Usuario</label>
                <input type="text" class="form-control" name="dni" id="userInput" placeholder="Usuario"/> <br>
                <label for="passInput">Contraseña</label>
                <input type="password" class="form-control" name="clave" id="passInput" placeholder="Contraseña"/><br>
                <%
                    if (error != null) {
                %>
                <div class="alert alert-danger">
                    <%=error%>
                </div>
                <%
                    }
                %>
                <input type="submit" class="btn btn-primary" value="Continuar"/>
            </form>
        </div>
    </div>
</div>
<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
