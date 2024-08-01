<%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 11/07/2024
  Time: 09:45 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form method="post" action="updateContra">
        <label>Ingresa tu nueva contraseña: </label>
        <input type="password" value="contra" required>
        <br>
        <input type="hidden" name="codigo" value="<%= request.getParameter("codigo")%>">
        <input type="submit" value="cambiar contraseña">
    </form>
</body>
</html>
