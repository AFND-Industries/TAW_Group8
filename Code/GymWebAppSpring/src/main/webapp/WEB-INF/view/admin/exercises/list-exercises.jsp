<%@ page import="java.util.List" %>
<%@ page import="com.example.GymWebAppSpring.dto.EjercicioDTO" %>
<%@ page import="com.example.GymWebAppSpring.dto.CategoriaDTO" %>
<%@ page import="com.example.GymWebAppSpring.dto.MusculoDTO" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 07/05/2024
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<EjercicioDTO> ejercicios = (List<EjercicioDTO>) request.getAttribute("ejercicios");
    List<CategoriaDTO> categorias = (List<CategoriaDTO>) request.getAttribute("categorias");
    List<MusculoDTO> musculos = (List<MusculoDTO>) request.getAttribute("musculos");

    String _nombre = (String) request.getAttribute("nombre");
    CategoriaDTO _categoria = (CategoriaDTO) request.getAttribute("categoria");
    MusculoDTO _musculo = (MusculoDTO) request.getAttribute("musculo");
%>
<html lang="es">
<head>
    <title>Listado de ejercicios</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons CSS Dependencies -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .icon-btn{
            cursor: pointer;
            transition-duration: 300ms;
        }

        .icon-btn:hover{
            scale: 1.1;
        }

        a{
            text-decoration: none;
        }
    </style>
</head>
<body>
<jsp:include page="../../components/header.jsp" />
<div class="container mb-2">
    <h1 class="text-center mb-2">Listado de ejercicios</h1>
    <form class="d-flex justify-content-between" method="post" action="">
        <input type="text" class="form-control" value="<%= _nombre != null ? _nombre : ""%>" name="nombre" placeholder="Nombre"/>
        <select class="form-select ms-2" name="categoria">
            <option disabled <%=_categoria == null ? "selected" : ""%>>Categoría</option>
            <%
                for (CategoriaDTO categoria : categorias) {
            %>
            <option value="<%=categoria.getId()%>" <%=categoria != null && categoria.equals(_categoria) ? "selected" : ""%>>
                <%=categoria.getNombre()%>
            </option>
            <%
                }
            %>
        </select>
        <select class="form-select ms-2" name="musculo">
            <option disabled <%=_musculo == null ? "selected" : ""%>>Músculo</option>
            <%
                for (MusculoDTO musculo : musculos) {
            %>
            <option value="<%=musculo.getId()%>" <%=musculo.equals(_musculo) ? "selected" : ""%>>
                <%=musculo.getNombre()%>
            </option>
            <%
                }
            %>
        </select>
        <button class="btn btn-primary d-flex align-items-center ms-2">
            <i class="bi bi-funnel-fill me-2"></i> Filtrar
        </button>
    </form>
    <div class="row mb-2">
        <h5>Leyenda</h5>
        <div class="col">
            <i class="bi bi-book me-1"></i> Ver información del ejercicio
        </div>
        <div class="col">
            <i class="bi bi-pencil-square me-1"></i> Editar ejercicio
        </div>
        <div class="col">
            <i class="bi bi-trash3 me-1"></i> Eliminar ejercicio
        </div>
    </div>
    <div class="row mb-2 g-2">
        <div class="col">
            <a href="/admin/exercises/new" class="btn btn-primary w-100">
                <i class="bi bi-person"></i> Añadir ejercicio
            </a>
        </div>
        <div class="col">
            <a href="" class="btn btn-outline-danger w-100">
                <i class="bi bi-funnel me-2"></i> Borrar filtrado
            </a>
        </div>
    </div>
    <div class="row g-3">
        <%
            if (ejercicios.isEmpty()){
        %>
        <div class="col">
            <div class="card text-center py-2">
                <span class="fw-bold">¡Ups! No se ha encontrado nignun ejercicio</span>
            </div>
        </div>
        <%
            }
        %>
        <%
            for (EjercicioDTO ejercicio : ejercicios){
        %>

            <div class="col-md-3 col-sm-6 col-12 h-100">
                <div class="card">
                    <img src="<%=ejercicio.getLogo()%>" class="card-img-top" />
                    <div class="card-body">
                        <span class="fw-bold fs-4"><%=ejercicio.getNombre()%></span><br>
                        <span class="text-secondary"><%=ejercicio.getMusculo().getNombre()%></span>
                        <div class="d-flex justify-content-around mt-4">
                            <a href="/admin/exercises/view?id=<%=ejercicio.getId()%>" class="icon-btn"><i class="bi bi-book me-1"></i></a>
                            <a href="/admin/exercises/edit?id=<%=ejercicio.getId()%>" class="icon-btn"><i class="bi bi-pencil-square me-1"></i></a>
                            <a href="/admin/exercises/delete?id=<%=ejercicio.getId()%>" class="icon-btn text-danger"><i class="bi bi-trash3 me-1"></i></a>
                        </div>
                    </div>
                </div>
            </div>

        <%
            }
        %>
    </div>
</div>

<!-- Bootstrap Javascript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
