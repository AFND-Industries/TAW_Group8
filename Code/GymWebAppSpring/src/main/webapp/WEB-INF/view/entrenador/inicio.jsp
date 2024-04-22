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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="/header.js"></script>
</head>
<body>
    <div id="header"></div>
    <script> createHeader("rutinas");</script>

    <div class="container d-flex justify-content-center align-items-center">
        <div class="card">
            <div class="card-body text-center px-5">
                <h1>Mi espacio personal</h1>
            </div>
        </div>
    </div>
</body>
</html>
