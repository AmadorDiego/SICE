<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <!-- <link rel="stylesheet" href="CSS/adicionales.css"> -->
</head>
<body>
<div class="container">
    <form method="post" action="login">
        <h1>Inicio de sesión</h1>
        <label class="form-label">Correo electrónico: </label>
        <br>
        <input type="email" class="form-control" name="correo_electronico" required>
        <br>
        <label class="form-label">Contra: </label>
        <br>
        <input type="password" class="form-control" name="contrasena" required>
        <br>
        <input type="submit" class="btn btn-primary" value="iniciar sesión">
        <%
            HttpSession sesion = request.getSession();
            String mensaje = (String) sesion.getAttribute("mensaje");
            if(mensaje != null){ %>
        <p style="color: red"><%=mensaje%></p>
        <% } %>

    </form>
</div>

<a href="solicitudRecuperacion.jsp">¿Olvisdaste tu contraseña?</a>
<a href="registroUsuario.jsp">Registrarme</a>
<a href="gestionUsuario.jsp">Ver usuarios</a>
<a href="pdf">Generar archivo PDF</a>
</body>
</html>


