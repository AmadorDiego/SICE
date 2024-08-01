<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 27/07/2024
  Time: 02:30 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bienvenido docente</title>
</head>
<body>
    <h1>Bienvenido docente</h1>

    <div class="container">
        <h1>Bienvenido docente</h1>
        <h3>Exámenes creados</h3>
        <button type="button" id="CrearExamen" class="btn btn-primary mb-3" onclick="redirigir()">Crear Examen</button>

        <table class="table">
            <thead>
            <tr>
                <th>Nombre del Examen</th>
                <th>Descripción</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Examen> examenes = (List<Examen>)request.getAttribute("examenes");
                if(examenes != null) {
                    for(Examen examen : examenes) {
            %>
            <tr>
                <td><%= examen.getNombre_examen() %></td>
                <td><%= examen.getDescripcion() %></td>
                <td><%= examen.isEstado() ? "Activo" : "Inactivo" %></td>
                <td>
                    <button class="btn btn-sm btn-primary">Modificar</button>
                    <button class="btn btn-sm btn-success">Asignar</button>
                    <button class="btn btn-sm btn-danger">Eliminar</button>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>

    <a href="examen.jsp">Crear examen</a>
    <a href="examen2.jsp">Crear examen</a>

    <script src="../../JS/jquery-3.7.0.js"></script>
    <script src="../../JS/bootstrap.js"></script>
</body>
</html>
