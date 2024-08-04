<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>
<form method="post" action="../../RegistrarUsuarioServlet">
    <label>Ingrese su nombre: </label>
    <input type="text" name="nombre_usuario" value="">
    <br>
    <label>Ingrese su apellido: </label>
    <input type="text" name="apellido_usuario" value="">
    <br>
    <label>Ingrese su correo electrónico: </label>
    <input type="email" name="correo_electronico" value="">
    <br>
    <label>Ingrese su contraseña: </label>
    <input type="password" name="contrasena1">
    <br>
    <label>Reingrese su contraseña: </label>
    <input type="password" name="contrasena2">
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
</form>
</body>
</html>
