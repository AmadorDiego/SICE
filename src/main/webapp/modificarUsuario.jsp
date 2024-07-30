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
<body>
<%
    HttpSession sesion = request.getSession();
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>
<form method="post" action="sign_in">
    <label>Ingrese su nombre: </label>
    <input type="text" name="nombre_usuario" value="">
    <br>
    <label>Ingrese su apellido: </label>
    <input type="text" name="apellido_usuario" value="">
    <br>
    <label>Ingrese su correo electrónico: </label>
    <input type="email" name="correo_electronico" value="">
    <br>
    <label>Ingrese el tipo de usuario: </label>
    <select name="id_tipo_usuario">
        <option value="4">Docente administrador</option>
        <option value="1">Administrador</option>
        <option value="2">Docente</option>
        <option selected value="3">Alumno</option>
    </select>
    <br>
    <!--<input type="hidden" name="operación" value="">-->
    <input type="submit">
</body>
</html>
