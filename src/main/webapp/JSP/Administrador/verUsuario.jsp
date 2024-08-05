<%@ page import="mx.edu.utez.sice.model.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 04/08/2024
  Time: 06:55 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("loginSICE.jsp"); // Redirect if user is not found
            return;
        }
    %>
    <title>Perfil de <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%></title>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
</head>
<body>
<br>
<div class="container-sm">
    <h1 class="h1">Perfil de <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%></h1>
    <div class="container-sm">
        <div>
            <input class="text-center"  type="hidden" name="id_usuario" value="<%= usuario.getId_usuario() %>">
        </div>
        <div>
            <label class="form-label">Nombre(s): </label>
            <input class="form-control" type="text" disabled name="nombre_usuario" value="<%= usuario.getNombre_usuario()%>" placeholder="<%= usuario.getNombre_usuario()%>">
            <br>
        </div>
        <div>
            <label class="form-label">Apellido(s): </label>
            <input class="form-control" type="text" disabled name="apellido_usuario" value="<%= usuario.getApellido_usuario()%>" placeholder="<%= usuario.getApellido_usuario()%>">
            <br>
        </div>
        <div>
            <label class="form-label">Correo electrónico: </label>
            <input class="form-control" type="email" disabled name="correo_electronico" value="<%= usuario.getCorreo_electronico()%>" placeholder="<%= usuario.getCorreo_electronico()%>">
            <br>
        </div>
        <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox" disabled role="switch" name="estado" id="estado" <% if(usuario.getEstado()==1){%>checked<%}%>>
            <label class="form-check-label" for="estado">Estado: <% if(usuario.getEstado() == 1){%>Habilitado<%}else if (usuario.getEstado() == 0){%>Deshabilitado<%} else{%>Eliminado<%}%> </label>
            <br>
        </div>
        <div>
            <br>
            <label class="form-label">Tipo de usuario: </label>
            <input class="form-control" type="text" disabled value="<% switch(usuario.getId_tipo_usuario()){case 1:%><%="Administrador"%><%break;case 2:%><%="Docente"%><%break;case 3:%><%="Alumno"%><%break;case 4:%><%="Docente administrador"%><%break;
            }%>">
            <br>
        </div>
        <div>
            <label class="form-label">Fecha registrado: </label>
            <input class="form-control" type="text" disabled value="<%= usuario.getFecha_registrado()%>">
        </div>
        <br>
        <a class="btn btn-primary" href="../../ActualizarUsuarioServlet?id_usuario=<%= usuario.getId_usuario()%>">Actualizar ></a>
    </div>
</div>
</body>
</html>
