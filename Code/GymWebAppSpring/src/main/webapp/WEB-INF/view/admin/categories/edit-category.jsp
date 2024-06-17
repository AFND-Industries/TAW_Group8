<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.GymWebAppSpring.dto.CategoriaDTO" %>
<%--
  Created by IntelliJ IDEA.
  author: tonib
  Date: 15/05/2024
  Time: 19:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="es">
<%
    CategoriaDTO categoria = (CategoriaDTO) request.getAttribute("categoria");
    List<String> tipos = (List<String>) (request.getAttribute("tipos") != null ? request.getAttribute("tipos") : new ArrayList<>()) ;
%>
<head>
    <title><%=categoria.getId() != null ? "Editar" : "Nuevo"%> categoria</title>
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
    <h2 class="text-center"><%=categoria.getId() != null ? "Editar" : "Crear una nueva"%> categoria</h2>
    <form:form action="/admin/categories/edit" modelAttribute="categoria" cssClass="row g-3" method="post">
        <form:hidden path="id" />
        <div class="col-md-6">
            <label for="nombreInput" class="form-label">Nombre</label>
            <form:input path="nombre" class="form-control"  id="nombreInput" />
            <div class="invalid-feedback">
                Por favor, escriba un nombre válido
            </div>
        </div>
        <div class="col-md-6">
            <label for="iconoInput" class="form-label">Icono</label>
            <form:input path="icono" class="form-control"  id="iconoInput"/>
            <div class="invalid-feedback">
                Por favor, escriba un icono válido
            </div>
        </div>
        <div class="col-12">
            <label for="descripcionInput" class="form-label">Descripción</label>
            <form:textarea path="descripcion" class="form-control" id="descripcionInput" />
            <div class="invalid-feedback">
                Por favor, escriba una descripción válida
            </div>
        </div>
        <div class="col-md-6 col-12">
            <label for="tiposInput" class="form-label">Tipos base</label>
            <div class="input-group">
                <input class="form-control was-validated" id="tiposInput" />
                <a href="#" id="tiposButton" class="btn btn-outline-secondary">Añadir tipo</a>
            </div>
        </div>
        <div class="col-md-6 col-12">
            <label class="form-label">Tipos base añadidos</label>
            <div class="card">
                <div class="card-body" id="tipoParent">
                </div>
            </div>
        </div>
        <form:button class="btn btn-primary w-100">
            <%
                if (categoria.getId() != null) {
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
    document.getElementById("nombreInput").setAttribute("required", "")
    document.getElementById("iconoInput").setAttribute("required", "")
    document.getElementById("descripcionInput").setAttribute("required", "")

    let i = 1;
    const parent = document.getElementById("tipoParent");
    const input = document.getElementById("tiposInput");
    document.getElementById("tiposButton").onclick = () => {
        createItem(input.value)
        input.value = ""
    };

    <%
        for (String tipo : tipos){
    %>
        createItem("<%=tipo%>");
    <%
        }
    %>

    function createItem(itemname){
        const actualId = i;
        const x = document.createElement("i")
        x.classList.add("bi","bi-x-lg","ms-1")
        x.attributeStyleMap.set("cursor", "pointer")
        x.onclick = () => deleteItem(actualId);
        const input = document.createElement("input");
        input.setAttribute("type", "hidden")
        input.setAttribute("value", itemname)
        input.setAttribute("name", "tipos")
        const item = document.createElement("span");
        item.classList.add("badge", "text-bg-secondary", "me-2");
        item.id = "tipoItem" + actualId;
        item.innerText = itemname;
        item.appendChild(x)
        item.appendChild(input)
        parent.appendChild(item);
        i++;
    }

    function deleteItem(id){
        parent.removeChild(parent.querySelector("#tipoItem" + id));
    }

</script>
</body>
</html>
