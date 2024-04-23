<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 08/04/2024
  Time: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Welcome!</title>
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <%@include file="components/header.jsp" %>
    <div class="container text-center mt-2">
        <h1>¡Bienvenido a tu gimnasio!</h1>
        <div class="row g-3">
            <div class="col-lg-6">
                <div class="card h-100">
                    <div class="card-body d-flex flex-column justify-content-center align-items-start">
                        <h3 class="card-title">Prueba nuestro gimnasio online</h3>
                        <p style="text-align: justify">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas odio nibh, convallis sed porttitor id, blandit id metus. Nulla sagittis metus mi, sit amet imperdiet eros condimentum ut. Mauris faucibus commodo nibh, in vestibulum nibh venenatis et. Morbi aliquet mauris odio, in mattis arcu tempor eget. Curabitur tincidunt eros dignissim, interdum dolor eu, dignissim leo.
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 d-flex align-items-center">
                <img src="https://t3.ftcdn.net/jpg/04/31/55/92/360_F_431559277_rkkDdPgYlypnPwf4EoDIlvkVDiWNBBft.jpg" class="rounded-2 w-100" />
            </div>
        </div>
    </div>

    <!-- Bootstrap Javascript Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
