<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 22/04/2024
  Time: 22:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Usuario user = (Usuario) session.getAttribute("user");
%>
<header>
    <nav class="navbar navbar-expand-lg bg-body-tertiary mb-3">
        <div class="container-fluid">
            <a class="navbar-brand" href="/entrenador"><i class="bi bi-person-arms-up me-1"></i>TAW PROJECT</a>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="<%="nav-link "+(request.getRequestURI().endsWith("clientes.jsp") ? "active" : "")%>" href="/entrenador/clientes" >Clientes</a>
                    </li>
                    <li class="nav-item">
                        <a class="<%="nav-link "+(request.getRequestURI().endsWith("rutinas.jsp") ? "active" : "")%>" href="/entrenador/rutinas">Rutinas</a>
                    </li>
                    <li class="nav-item">
                        <a class="<%="nav-link "+(request.getRequestURI().endsWith("client.jsp") ? "active" : "")%>" href="/client">Area personal</a>
                    </li>
                </ul>
            </div>
            <div class="btn-group dropstart ms-auto">
                <%
                    if (user == null){
                %>
                <a href="/login" class="btn rounded-pill"><i class="bi bi-person" style="font-size: 20px"></i> Iniciar sesión</a>
                <%
                    } else {
                %>
                <button type="button" class="btn rounded-pill" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-person" style="font-size: 20px"></i> <%=user.getNombre()%>
                </button>
                <ul class="dropdown-menu">
                    <%
                        if (user.getTipo().getNombre().equals("Administrador")){
                    %>
                    <li><a class="dropdown-item" href="/admin/dashboard"><i class="bi bi-speedometer2 me-2" style="font-size: 16px"></i>Panel de control</a></li>
                    <li><a class="dropdown-item" href="/admin/users"><i class="bi bi-person-lines-fill me-2" style="font-size: 16px"></i>Usuarios</a></li>
                    <%
                        } else if (user.getTipo().getNombre().equals("Entrenador")){
                    %>
                    <li><a class="dropdown-item" href="/entrenador"><i class="bi bi-file-earmark-person me-2" style="font-size: 16px"></i>Mi Espacio Personal</a></li>
                    <li><a class="dropdown-item" href="/entrenador/clientes"><i class="bi bi-person-lines-fill me-2" style="font-size: 16px"></i>Clientes</a></li>
                    <li><a class="dropdown-item" href="/entrenador/rutinas"><i class="bi bi-card-checklist me-2" style="font-size: 16px"></i>Rutinas</a></li>

                    <%
                        } else if (user.getTipo().getNombre().equals("Cliente")){
                    %>
                        <li><a class="dropdown-item" href="/client"><i class="bi bi-person-circle me-2" style="font-size: 16px"></i> Área personal</a></li>
                    <%
                        }
                    %>
                    <!-- List items template
                    <li><a class="dropdown-item" href="#">Action</a></li>
                    <li><a class="dropdown-item" href="#">Another action</a></li>
                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                    -->
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="/logout"><i class="bi bi-x-lg me-2"></i> Cerrar sesión</a></li>
                </ul>
                <%
                    }
                %>

            </div>
        </div>
    </nav>
</header>
