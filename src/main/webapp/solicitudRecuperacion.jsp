<%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 12/07/2024
  Time: 11:11 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form method="post" action="solicitudRecuperacion">
        <label>Correo electronico: </label>
        <input type="email" required
               name="correo" placeholder="ejemplo@gmail.com">
        <br>
        <input type="submit" value="Solicitar">
    </form>
</body>
</html>
