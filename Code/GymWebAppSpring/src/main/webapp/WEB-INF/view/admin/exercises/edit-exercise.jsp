<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.example.GymWebAppSpring.entity.Ejercicio" %>
<%--
  Created by IntelliJ IDEA.
  ejercicio: tonib
  Date: 15/05/2024
  Time: 19:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="es">
<%
    Ejercicio ejercicio = (Ejercicio) request.getAttribute("ejercicio");
%>
<head>
    <title><%=ejercicio.getId() != null ? "Editar" : "Nuevo"%> ejercicio</title>
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
    <h2 class="text-center"><%=ejercicio.getId() != null ? "Editar" : "Registro de un nuevo"%> ejercicio</h2>
    <form:form action="/admin/exercises/edit" modelAttribute="ejercicio" cssClass="row g-3 was-validated" method="post">
        <form:hidden path="id" />
        <div class="col-md-6 mb-3">
            <label for="nombreInput" class="form-label">Nombre</label>
            <form:input path="nombre" class="form-control"  id="nombreInput" />
            <div class="invalid-feedback">
                Por favor, escriba un nombre válido
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="equipamientoInput" class="form-label">Equipamiento</label>
            <form:input path="equipamiento" class="form-control"  id="equipamientoInput"/>
            <div class="invalid-feedback">
                Por favor, escriba un equipamiento válido
            </div>
        </div>
        <div class="col-12 mb-3">
            <label for="descripcionInput" class="form-label">Descripción</label>
            <form:textarea path="descripcion" class="form-control" id="descripcionInput" />
            <div class="invalid-feedback">
                Por favor, escriba una descripción válida
            </div>
        </div>
        <div class="col-md-3 col-sm-6 col-12 mb-3">
            <label for="musculoInput" class="form-label">Músculo</label>
            <form:select path="musculo" items="${musculos}" itemLabel="nombre" itemValue="id" class="form-select" id="musculoInput" />
            <div class="invalid-feedback">
                Por favor, seleccione un músculo válido
            </div>
        </div>
        <div class="col-md-3 col-sm-6 col-12 mb-3">
            <label for="musculoSecInput" class="form-label">Músculo Secundario</label>
            <form:select path="musculoSecundario" class="form-select"
                         items="${musculos}"
                         itemLabel="nombre"
                         itemValue="id"
                         id="musculoSecInput">
            </form:select>
            <div class="invalid-feedback">
                Por favor, indique un músculo válido
            </div>
        </div>
        <div class="col-md-3 col-sm-6 col-12 mb-3">
            <label for="categoriaInput" class="form-label">Categoría</label>
            <form:select path="categoria" class="form-select" items="${categorias}" itemLabel="nombre" itemValue="id" id="categoriaInput">
            </form:select>
        </div>
        <div class="col-md-3 col-sm-6 mb-3">
            <label for="tipoFuerzaInput" class="form-label">Tipo de fuerza</label>
            <form:select path="tipofuerza" class="form-select" id="tipoFuerzaInput" items="${tipos}" itemLabel="nombre" itemValue="id">
            </form:select>
            <div class="invalid-feedback">
                Por favor, seleccione un tipo de ejercicio válido
            </div>
        </div>
        <div class="col-md-6 col-12 mb-3">
            <label for="videoInput" class="form-label">Vídeo</label>
            <form:input path="video" class="form-control" id="videoInput" />
            <div class="invalid-feedback">
                Por favor, escriba un enlace válido
            </div>
        </div>
        <div class="col-md-6 col-12 mb-3">
            <label for="logoInput" class="form-label">Logo</label>
            <form:input path="logo" class="form-control" id="logoInput" />
            <div class="invalid-feedback">
                Por favor, escriba un enlace válido
            </div>
        </div>
        <form:button class="btn btn-primary w-100">
            <%
                if (ejercicio.getId() != null) {
            %>
            <i class="bi bi-floppy me-1" style="font-size: 15px"></i> Guardar
            <%
            } else {
            %>
            <i class="bi bi-person-add me-1" style="font-size: 15px"></i> Añadir
            <%
                }
            %>
        </form:button>
    </form:form>

</div>
<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script>
    $("nombreInput").attr("required", "")
    $("descripcionInput").attr("required", "")
    $("musculoInput").attr("required", "")
    $("musculoSecInput").attr("required", "")
    $("categoriaInput").attr("required", "")
    $("videoInput").attr("required", "")
    $("logoInput").attr("required", "")
</script>
</body>
</html>
