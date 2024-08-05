<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registrar nuevo usuario</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>
<div class="container-xl">
    <br>
    <form class="form-control" method="post" action="../../RegistrarUsuarioServlet">
        <h1>Registrar nuevo usuario</h1>
        <label class="form-label">Ingrese su nombre: </label>
        <input required class="form-control" type="text" name="nombre_usuario" value="">
        <br>
        <label class="form-label">Ingrese su apellido: </label>
        <input required class="form-control" type="text" name="apellido_usuario" value="">
        <br>
        <label class="form-label">Ingrese su correo electrónico: </label>
        <input required class="form-control" type="email" name="correo_electronico" value="">
        <br>
        <label class="form-label">Ingrese su contraseña: </label>
        <input required class="form-control" type="password" name="contrasena1">
        <br>
        <label class="form-label">Reingrese su contraseña: </label>
        <input required class="form-control" type="password" name="contrasena2">
        <br>
        <label class="form-label">Ingrese el tipo de usuario: </label>
        <select required class="form-control" name="id_tipo_usuario">
            <option value="4">Docente administrador</option>
            <option value="1">Administrador</option>
            <option value="2">Docente</option>
            <option selected value="3">Alumno</option>
        </select>
        <br>
        <input type="submit" class="btn btn-primary">
    </form>
</div>
</body>
</html>
