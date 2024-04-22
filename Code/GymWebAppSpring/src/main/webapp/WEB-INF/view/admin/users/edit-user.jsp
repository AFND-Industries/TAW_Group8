<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 20/04/2024
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Usuario user = (Usuario) request.getAttribute("user");
%>
<html>
<head>
    <title>Registro de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<div class="container">
    <h2 class="text-center">Registro de Usuario</h2>
    <form class="row g-3 was-validated" method="post" action="<%=user != null ? "/edit" : "/register"%>">
        <div class="col-md-6 mb-3">
            <label for="nombreInput" class="form-label">Nombre</label>
            <input type="text" class="form-control" maxlength="32" id="nombreInput" name="nombre"
                   value="<%=user != null ? user.getNombre() : ""%>"
                   required>
            <div class="invalid-feedback">
                Por favor, escriba un nombre válido
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="apellidosInput" class="form-label">Apellidos</label>
            <input type="text" class="form-control" maxlength="32" id="apellidosInput" name="apellidos"
                   value="<%=user != null ? user.getApellidos() : ""%>"
                   required>
            <div class="invalid-feedback">
                Por favor, escriba un(os) apellido(s) válido(s)
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <label for="generoInput" class="form-label">Género</label>
            <select class="form-select" id="generoInput" name="genero" required>
                <option <%=user == null ? "selected" : ""%> disabled value="">Selecciona...</option>
                <%
                    for (String str : new String[]{"Masculino", "Femenino"}) {
                        char value = str.toLowerCase().charAt(0);
                %>
                <option value="<%=value%>" <%=user != null && user.getGenero().equals(value) ? "selected" : ""%>><%=str%>
                </option>
                <%
                    }
                %>
            </select>
            <div class="invalid-feedback">
                Por favor, seleccione un género válido
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <label for="edadInput" class="form-label">Edad</label>
            <input type="number" class="form-control" id="edadInput" name="edad"
                   value="<%=user != null ? user.getEdad() : ""%>"
                   required>
            <div class="invalid-feedback">
                Por favor, indique una edad válida
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <label for="dniInput" class="form-label">Documento de Identificación</label>
            <input type="text" class="form-control" maxlength="10" id="dniInput" name="dni"
                   value="<%=user != null ? user.getDni() : ""%>"
                   required>
            <div class="invalid-feedback">
                Por favor, indique un documento de identificación válido
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="claveInput" class="form-label">Clave</label>
            <input type="password" class="form-control" id="claveInput" name="clave" required>
            <div class="invalid-feedback">
                Por favor, indique una clave válida
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="tipoUsuarioInput" class="form-label">Tipo de Usuario</label>
            <select class="form-select" id="tipoUsuarioInput" name="tipoUsuario" required>
                <option selected disabled value="">Selecciona...</option>
                <option value="1">Cliente</option>
                <option value="2">Entrenador</option>
                <option value="3">Administrador</option>
            </select>
            <div class="invalid-feedback">
                Por favor, seleccione un tipo de usuario válido
            </div>
        </div>
        <div class="col mb-3">
            <button type="submit" class="btn btn-primary w-100">
                <%
                    if (user != null) {
                %>
                <img src="/svg/save.svg" alt="Guardar" style="width:50px; height:50px"> Guardar
                <%
                } else {
                %>
                <img src="/svg/add-user.svg" alt="Registrar" style="width:50px; height:50px">Registrar
                <%
                    }
                %>
            </button>
        </div>
    </form>
</div>
</body>
</html>
