
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
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Crear Examen</title>
    <!--<link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/bootstrap.css">
    <!--<link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/fondo.css">
    <!--<link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Docentes.css">

</head>
<body>
<!--/////////////////////////////////////////// Fondo //////////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!--///////////////////////////////////////// Contenido ////////////////////////////////////////////////////-->
    <div class="container md">
        <div class="row">
            <div class="col-12">

                <a class="btn btn-primary bg-blue-utz text-white h5 g-2 mt-4 h6" href="indexDocente.jsp"> Regresar < </a>
            </div>
            <div class="col-12 mt-2 rounded-5 p-3 bg-green-utz g-3">
                <h1 class="mb-4 blue-utz">Crear Nuevo Examen</h1>
                <br>
                <form id="id_examen" action="${pageContext.request.contextPath}/CrearExamenServlet" method="post" class="mb-4">
                    <div class="mb-3">
                        <label class="form-label text-white h5" for="id_nombre">Nombre del Examen:</label>
                        <input class="form-control" type="text" id="id_nombre" name="id_nombre" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white h5" for="descripcion">Descripción:</label>
                        <textarea class="form-control fixed-size-textarea" id="descripcion" name="descripcion" rows="4" style="resize: none;"></textarea>
                    </div>

                    <div id="id_preguntas" class="mb-3">
                        <!--Aqui se van agregando las preguntas que se vayan creando-->
                    </div>

                    <div class="mt-3">
                        <button type="button" class="btn btn-primary me-2" onclick="agregarPregunta('cerrada')">Pregunta cerrada</button>
                        <button type="button" class="btn btn-secondary" onclick="agregarPregunta('abierta')">Pregunta abierta</button>
                    </div>

                    <button type="button" id="guardarCambios" class="btn btn-primary bg-blue-utz h6">Guardar cambios</button>
                </form>
            </div>
        </div>
    </div>
    <!--<script src="../../JS/jquery-3.7.0.js"></script>
    <script src="../../JS/bootstrap.js"></script>
    <script src="../../JS/ScriptExamen.js"></script>-->
    <script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
    <script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/JS/ScriptExamen.js"></script>

</body>
</html>

