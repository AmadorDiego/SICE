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
    <title>modificar</title>
</head>
<%
    HttpSession sesion = request.getSession();
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>
<form method="post" action="../../ActualizarUsuarioServlet">
    <label>Ingrese su nombre: </label>
    <input type="text" name="nombre_usuario" value="<%= usuario.getNombre_usuario()%>" placeholder="<%= usuario.getNombre_usuario()%>">
    <br>
    <label>Ingrese su apellido: </label>
    <input type="text" name="apellido_usuario" value="<%= usuario.getApellido_usuario()%>" placeholder="<%= usuario.getApellido_usuario()%>">
    <br>
    <label>Ingrese su correo electrónico: </label>
    <input type="email" name="correo_electronico" value="<%= usuario.getCorreo_electronico()%>" placeholder="<%= usuario.getCorreo_electronico()%>">
    <br>
    <label>Ingrese su contraseña: </label>
    <input type="password" name="contrasena1">
    <br>
    <label>Reingrese su contraseña: </label>
    <input type="password" name="contrasena2">
    <br>
    <label>Estado: </label>
    <input type="checkbox" name="estado" value="">
    <br>
    <label>Ingrese el tipo de usuario: </label>
    <select name="id_tipo_usuario">
        <option value="4">Docente administrador</option>
        <option value="1">Administrador</option>
        <option value="2">Docente</option>
        <option value="3">Alumno</option>
    </select>
    <br>
    <!--<input type="hidden" name="operación" value="">-->
    <input type="submit">
</form>
</body>
</html>
