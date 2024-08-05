<%@ page import="mx.edu.utez.sice.model.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 30/07/2024
  Time: 03:05 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Actualizar datos</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("loginSICE.jsp"); // Redirect if user is not found
        return;
    }
%>
<div class="container-xl">
    <br>
    <form class="form-control" method="post" action="../../ActualizarUsuarioServlet">
        <h1>Actualizar datos</h1>
        <input type="hidden" name="id_usuario" value="<%= usuario.getId_usuario() %>">
        <label class="form-label">Ingrese su nombre: </label>
        <input class="form-control" type="text" name="nombre_usuario" required value="<%= usuario.getNombre_usuario()%>" placeholder="<%= usuario.getNombre_usuario()%>">
        <br>
        <label class="form-label">Ingrese su apellido: </label>
        <input class="form-control" type="text" name="apellido_usuario" required value="<%= usuario.getApellido_usuario()%>" placeholder="<%= usuario.getApellido_usuario()%>">
        <br>
        <label class="form-label">Ingrese su correo electrónico: </label>
        <input class="form-control" type="email" name="correo_electronico" required value="<%= usuario.getCorreo_electronico()%>" placeholder="<%= usuario.getCorreo_electronico()%>">
        <br>
        <label class="form-label">Ingrese su contraseña: </label>
        <input class="form-control" type="password" name="contrasena1" required>
        <br>
        <label class="form-label">Reingrese su contraseña: </label>
        <input class="form-control" type="password" name="contrasena2" required>
        <br>
        <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox" role="switch" name="estado" id="estado" <% if(usuario.getEstado()==1){%>checked<%}%>>
            <label class="form-check-label" for="estado">Estado</label>
        </div>
        <br>
        <label class="form-label">Seleccione el tipo de usuario: </label>
        <select class="form-control" name="id_tipo_usuario" required>
            <option value="1" <% if(usuario.getId_tipo_usuario()==1){%>selected<%}%>>Administrador</option>
            <option value="2" <% if(usuario.getId_tipo_usuario()==2){%>selected<%}%>>Docente</option>
            <option value="3" <% if(usuario.getId_tipo_usuario()==3){%>selected<%}%>>Alumno</option>
            <option value="4" <% if(usuario.getId_tipo_usuario()==4){%>selected<%}%>>Docente administrador</option>
        </select>
        <br>
        <input class="btn btn-primary" type="submit" value="Actualizar">
    </form>
</div>
</body>
</html>
