<%@ page import="com.example.GymWebAppSpring.entity.Usuario" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: tonib
  Date: 08/04/2024
  Time: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
%>
<html>
<head>
    <title>Example jsp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <div class="container text-center mt-2">
        <h1 class="mb-2">This is an example JSP page</h1>
        <%
            for(Usuario usuario : usuarios) {
        %>
            <h2><%=usuario.getNombre()%></h2>
        <%
            }
        %>

        <%
            if(usuarios.isEmpty()){
        %>
            <h3>La lista está vacía :(</h3>
        <%
            }
        %>
    </div>
</body>
</html>
