<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/adicionales.css">
</head>

<body class="multi-repeating-linear">
<div class="container">
    <img id="imagen_esq_derecha" src="./IMG/colorArriba.png">
    <form  method="post" action="UsuarioServlet" id="loginForm" class="form">
        <div id="imagenLogo"><img src="./IMG/logo.png"></div>
        <h3  >Inicio de Sesión</h3>
        <br>
        <div class="form-group">
            <label for="correo">Correo electrónico: </label>
            <input type="email" class="form-control" id="correo" name="correo_electronico" required>
        </div>
        <div class="form-group">
            <label for="contrasena">Contraseña: </label>
            <input type="password" class="form-control" id="contrasena" name="contrasena" required>
        </div>

        <div class="submit-container">
            <input type="submit" value="Iniciar sesión" id="loginBtn">
        </div>
        <%
            HttpSession sesion = request.getSession();
            String mensaje = (String) sesion.getAttribute("mensaje");
            if(mensaje != null){ %>
        <p style="color: red"><%=mensaje%></p>
        <% } %>
    </form>
</div>
<img id="imagen_esq_izq" src="./IMG/colorAbajo.png">
</body>
</html>


