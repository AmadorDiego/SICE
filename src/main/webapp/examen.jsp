<%@ page import="mx.edu.utez.sice.model.Usuario" %><%--
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
    <link rel="stylesheet" href="CSS/bootstrap.css">
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Usuario u = (Usuario) sesion.getAttribute("usuario");
%>
<div class="container">
    <h1>Crear Nuevo Examen</h1>
    <form action="crear" method="post">
        <div class="mb-3">
            <label for="nombre_examen" class="form-label">Nombre del Examen</label>
            <input type="text" class="form-control" id="nombre_examen" name="nombre_examen" required>
        </div>
        <div class="mb-3">
            <label for="cantidad_preguntas" class="form-label">Cantidad de Preguntas</label>
            <input type="number" class="form-control" id="cantidad_preguntas" name="cantidad_preguntas" required>
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="estado" name="estado">
            <label class="form-check-label" for="estado">Activo</label>
        </div>
        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <textarea class="form-control" id="descripcion" name="descripcion" rows="3"></textarea>
        </div>
        <input type="hidden" name="id_usuario" value="<%=u.getId_usuario()%>">
        <button type="submit" class="btn btn-primary">Crear Examen</button>
    </form>
</div>

<script src="JS/jquery-3.7.0.js"></script>
<script src="JS/bootstrap.js"></script>
</body>
</html>