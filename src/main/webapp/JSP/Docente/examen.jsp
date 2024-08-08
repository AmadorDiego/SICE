<jsp:useBean id="id_examen" scope="request" type="com.sun.org.apache.xml.internal.security.signature.SignatureProperty"/>
<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 30/07/2024
  Time: 11:34 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
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
    </style>

</head>
<body>
<div class="container mt-4">
    <h1 class="mb-4">Crear Nuevo Examen</h1>
    <form action="/PreguntaServlet", method="get" class="mb-4">
       <h1>Crear Examen</h1>



        <input type="submit" value="Guardar Examen">
    </form>
</div>

<script src="../../JS/jquery-3.7.0.js"></script>
<script src="../../JS/bootstrap.js"></script>
<script src="../../JS/ScriptExamen.js"></script>
</body>
</html>

