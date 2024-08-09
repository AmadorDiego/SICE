
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Examen</title>
    <link href="../../CSS/bootstrap.css" rel="stylesheet">

    <style>
        .fixed-size-textarea {
            resize: none; /* Deshabilita el redimensionamiento */
            width: 100%;  /* Ajusta el ancho al contenedor */
            max-width: 600px; /* Ajusta el ancho máximo según tus necesidades */
        }
        .pregunta-form {
            display: none;
        }

    </style>

</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">Crear Nuevo Examen</h1>
        <form id="id_examen" action="${pageContext.request.contextPath}/CrearExamenServlet" method="post" class="mb-4">
            <div class="mb-3">
                <label class="form-label" for="id_nombre">Nombre del Examen:</label>
                <input class="form-control" type="text" id="id_nombre" name="id_nombre" required>
            </div>

            <div class="mb-3">
                <label class="form-label" for="descripcion">Descripción:</label>
                <textarea class="form-control fixed-size-textarea" id="descripcion" name="descripcion" rows="4" required></textarea>
            </div>

            <div id="id_preguntas" class="mb-3">
            <!--Aqui se van agregando las preguntas que se vayan creando-->
            </div>

            <button class="btn btn-primary">Guardar cambios</button>

        </form>
    </div>

    <script src="../../JS/jquery-3.7.0.js"></script>
    <script src="../../JS/bootstrap.js"></script>
    <script src="../../JS/ScriptExamen.js"></script>
</body>
</html>

