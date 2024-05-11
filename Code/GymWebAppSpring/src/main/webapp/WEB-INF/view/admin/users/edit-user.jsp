<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="com.example.GymWebAppSpring.entity.Tipousuario" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 20/04/2024
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Usuario user = (Usuario) request.getAttribute("user");
    List<Tipousuario> tiposUsuario = (List<Tipousuario>) request.getAttribute("tiposUsuario");
    Boolean edit = (Boolean) request.getAttribute("editable");
    edit = edit == null ? true : false;
    String editable = user != null && !edit ? "disabled" : "";
%>
<html>
<head>
    <title><%=user != null ? (edit ? "Editar" : "Ver") : "Nuevo"%> usuario</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<jsp:include page="../../components/header.jsp"/>
<div class="container">
    <h2 class="text-center"><%=user != null ? (edit ? "Editar" : "Ver") : "Registro de un nuevo"%> usuario</h2>
    <form class="row g-3 was-validated" method="post" action="<%=user != null ? "/admin/users/edit" : "/admin/users/register"%>">
        <input type="hidden" value="<%=user != null ? user.getId() : ""%>" name="id"/>
        <div class="col-md-6 mb-3">
            <label for="nombreInput" class="form-label">Nombre</label>
            <input type="text" class="form-control" maxlength="32" id="nombreInput" name="nombre"
                   value="<%=user != null ? user.getNombre() : ""%>"
                <%=editable%>
                   required>
            <div class="invalid-feedback">
                Por favor, escriba un nombre válido
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="apellidosInput" class="form-label">Apellidos</label>
            <input type="text" class="form-control" maxlength="32" id="apellidosInput" name="apellidos"
                   value="<%=user != null ? user.getApellidos() : ""%>"
                <%=editable%>
                   required>
            <div class="invalid-feedback">
                Por favor, escriba un(os) apellido(s) válido(s)
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <label for="generoInput" class="form-label">Género</label>
            <select class="form-select" id="generoInput" name="genero" required <%=editable%>>
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
                <%=editable%>
                   required>
            <div class="invalid-feedback">
                Por favor, indique una edad válida
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <label for="dniInput" class="form-label">Documento de Identificación</label>
            <input type="text" class="form-control" maxlength="10" id="dniInput" name="dni"
                   value="<%=user != null ? user.getDni() : ""%>"
                <%=editable%>
                   required>
            <div class="invalid-feedback">
                Por favor, indique un documento de identificación válido
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="claveInput" class="form-label">Clave</label>
            <input type="password" class="form-control" id="claveInput" name="clave"
                   placeholder="<%=user != null ? (edit ? "Si se deja vacío se mantiene la clave anterior" : "************") : ""%>"
                <%=user == null ? "required" : ""%> <%=editable%>>
            <div class="invalid-feedback">
                Por favor, indique una clave válida
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="tipoUsuarioInput" class="form-label">Tipo de Usuario</label>
            <select class="form-select" id="tipoUsuarioInput" name="tipoUsuario" required <%=editable%>>
                <option selected disabled value="">Selecciona...</option>
                <%
                    for (Tipousuario tipo : tiposUsuario) {
                %>
                <option value="<%=tipo.getId()%>" <%=user != null && user.getTipo().equals(tipo) ? "selected" : ""%>><%=tipo.getNombre()%>
                </option>
                <%
                    }
                %>
            </select>
            <div class="invalid-feedback">
                Por favor, seleccione un tipo de usuario válido
            </div>
        </div>
        <div class="col mb-3">
            <%
                if (!edit) {
            %>
            <a href="/admin/users/">
                <button type="button" class="btn btn-primary w-100">
                    <i class="bi bi-arrow-left me-1" style="font-size: 15px"></i> Volver atrás
                </button>
            </a>
            <%
            } else {
            %>
            <button type="submit" class="btn btn-primary w-100">
                <%
                    if (user != null) {
                %>
                <i class="bi bi-floppy me-1" style="font-size: 15px"></i> Guardar
                <%
                } else {
                %>
                <i class="bi bi-person-add me-1" style="font-size: 15px"></i> Registrar
                <%
                    }
                %>
            </button>
            <%
                }
            %>
        </div>
    </form>
</div>
<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
