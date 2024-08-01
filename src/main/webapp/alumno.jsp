<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 27/07/2024
  Time: 02:30 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Examen> examenesPendientes = (List<Examen>) request.getAttribute("examenesPendientes");
%>
<html>
<head>
    <title>Exámenes Pendientes</title>
    <link rel="stylesheet" href="CSS/bootstrap.css">
</head>
<body>
<div class="container">
    <h1>Bienvenido alumno</h1>
    <h2>Exámenes pendientes</h2>
    <table class="table">
        <thead>
        <tr>
            <th>Examen</th>
            <th>Descripción</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (examenesPendientes != null && !examenesPendientes.isEmpty()) {
                for (Examen examen : examenesPendientes) {
        %>
        <tr>
            <td><%=examen.getNombre_examen()%></td>
            <td><%=examen.getDescripcion()%></td>
            <td>
                <a href="${pageContext.request.contextPath}/examen/<%=examen.getId_examen()%>" class="btn btn-primary">Presentar Examen</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="3">No hay exámenes pendientes.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<script src="JS/jquery-3.7.0.js"></script>
<script src="JS/bootstrap.js"></script>
</body>
</html>
