<%--
  Created by IntelliJ IDEA.
  User: elgam
  Date: 22/04/2024
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tus rutinas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <div class="row mb-5">
            <div class="col">
                Inicio Clientes Tus rutinas
            </div>
        </div>
        <div class="row">
            <div class="col-4">
                <h1>Tus rutinas</h1>
            </div>
            <div class="col-8 d-flex justify-content-end align-items-center">
                <div>
                    <button class="btn btn-primary">Filtros de búsqueda</button>
                    <button class="btn btn-primary">Crear nueva rutina</button>
                </div>
            </div>
        </div>
        <div class="row border">
            <div class="col-8 d-flex align-items-center">
                <img src="/svg/question-square.svg" alt="Borrar" style="width:50px; height:50px">
                <span class="h2">Rutina 1</span>
            </div>
            <div class="col-4 d-flex justify-content-end align-items-center">
                <img src="/svg/pencil.svg" alt="Editar" style="width:50px; height:50px">&nbsp;&nbsp;&nbsp;&nbsp;
                <img src="/svg/trash.svg" alt="Borrar" style="width:50px; height:50px">
            </div>
        </div>
    </div>
</body>
</html>
