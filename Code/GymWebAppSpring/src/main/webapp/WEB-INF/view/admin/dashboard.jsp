<%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 29/04/2024
  Time: 12:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .card-btn{
            cursor: pointer;
            transition-duration: 300ms;
        }

        .card-btn:hover{
            scale: 1.03;
        }

        a{
            text-decoration: none;
            color: black;
        }
    </style>
</head>
<body>
<jsp:include page="../components/header.jsp" />
<div class="container text-center mb-5">
    <div class="card mb-3">
        <div class="card-body text-center">
            <h1>Panel de administrador</h1>
        </div>
    </div>
    <h5>¿Qué desea hacer?</h5>
</div>
<div class="container">
    <div class="row g-5">
        <div class="col-12">
            <a href="/admin/users/" class="text">
                <div class="card card-btn">
                    <div class="card-body d-flex justify-content-center align-items-center p-5">
                        <i class="bi bi-person-lines-fill me-2 fs-4"></i> <span class="fs-4">Usuarios</span>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-6 col-12">
            <a href="/admin/exercises/">
                <div class="card card-btn">
                    <div class="card-body d-flex justify-content-center align-items-center  p-5">
                        <i class="bi bi-list-nested me-2 fs-4"></i> <span class="fs-4">Ejercicios</span>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-6 col-12">
            <a href="/admin/categories/">
                <div class="card card-btn">
                    <div class="card-body d-flex justify-content-center align-items-center p-5">
                        <i class="bi bi-person-lines-fill me-2 fs-4"></i> <span class="fs-4">Categorías</span>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
