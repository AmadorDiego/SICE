<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 30/07/2024
  Time: 11:34 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Crear Examen</title>
    <link rel="stylesheet" href="../../CSS/bootstrap.css">
</head>
<body>

<c:if test="${modo == 'crear'}">
    <h1>Crear Nuevo Examen</h1>
    <form action="${pageContext.request.contextPath}/examen" method="post">
        <label for="nombre">Nombre del Examen:</label>
        <input type="text" id="nombre" name="nombre" required>
        <br>
        <br>
        <label for="descripcion">Descripción:</label>
        <textarea id="descripcion" name="descripcion" required></textarea><br><br>

        <!-- Agrega más campos según sea necesario -->

        <input type="submit" value="Guardar cambios">
    </form>
</c:if>

<c:if test="${modo == 'listar'}">
    <h2>Lista de Exámenes</h2>
    <table>
        <tr>
            <th>Nombre</th>
            <th>Descripción</th>
        </tr>
        <c:forEach var="examen" items="${examenes}">
            <tr>
                <td>${examen.nombre_examen}</td>
                <td>${examen.descripcion}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<script src="../../JS/jquery-3.7.0.js"></script>
<script src="../../JS/bootstrap.js"></script>
<script src="../../JS/ScriptExamen.js"></script>
</body>
</html>

