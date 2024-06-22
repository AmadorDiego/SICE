<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>

<form method="post" action="login">
    <label>Correo electrónico: </label>
    <input type="email" name="correo_electronico" required>
    <br>
    <label>Contra: </label>
    <input type="password" name="contrasena" required>
    <br>
    <input type="submit" value="iniciar sesión">
    <%
        HttpSession sesion = request.getSession();
        String mensaje = (String) sesion.getAttribute("mensaje");
        if(mensaje != null){ %>
    <p style="color: red"><%=mensaje%></p>
    <% } %>
</form>
</body>
</html>


