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
    <link rel="stylesheet" href="CSS/bootstrap.css">
</head>
<body>
<div class="container">
    <h1>Crear Nuevo Examen</h1>
    <form action="${pageContext.request.contextPath}/crear" method="post">
        <div class="mb-3">
            <label for="nombre_examen" class="form-label">Nombre del Examen</label>
            <input type="text" class="form-control" id="nombre_examen" name="nombre_examen" required>
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="estado" name="estado">
            <label class="form-check-label" for="estado">Activo</label>
        </div>
        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <textarea class="form-control" id="descripcion" name="descripcion" rows="3"></textarea>
        </div>

        <!-- Agregar Pregunta -->
        <div class="mb-3">
            <label for="agregar_pregunta">Agregar Pregunta</label>
            <select class="form-control" id="agregar_pregunta" name="agregar_pregunta">
                <option value="">Seleccione una opción</option>
                <option value="opcion_multiple">Pregunta Opción Múltiple</option>
                <option value="respuesta_abierta">Pregunta Respuesta Abierta</option>
            </select>
        </div>

        <!-- Campos para Pregunta Opción Múltiple -->
        <div class="mb-3 d-none" id="campos_opcion_multiple">
            <label for="pregunta_opcion_multiple">Pregunta</label>
            <input type="text" class="form-control" id="pregunta_opcion_multiple" name="pregunta_opcion_multiple">
            <label for="respuesta_opcion_multiple">Respuesta</label>
            <input type="text" class="form-control" id="respuesta_opcion_multiple" name="respuesta_opcion_multiple">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="respuesta_correcta_opcion_multiple" id="respuesta_correcta_opcion_multiple" value="true">
                <label class="form-check-label" for="respuesta_correcta_opcion_multiple">
                    Respuesta Correcta
                </label>
            </div>
        </div>

        <!-- Campos para Pregunta Respuesta Abierta -->
        <div class="mb-3 d-none" id="campos_respuesta_abierta">
            <label for="pregunta_respuesta_abierta">Pregunta</label>
            <input type="text" class="form-control" id="pregunta_respuesta_abierta" name="pregunta_respuesta_abierta">
        </div>

        <!-- Agregar Imagen -->
        <div class="mb-3">
            <label for="agregar_imagen">Agregar Imagen</label>
            <input type="file" class="form-control" id="agregar_imagen" name="agregar_imagen">
        </div>

        <input type="hidden" name="usuario_id_usuario" value="${sessionScope.usuario.id_usuario}">
        <button type="submit" class="btn btn-primary">Crear Examen</button>
    </form>
</div>

<script src="JS/jquery-3.7.0.js"></script>
<script src="JS/bootstrap.js"></script>
<script>
    $(document).ready(function() {
        // Mostrar/ocultar campos según la opción seleccionada
        $('#agregar_pregunta').change(function() {
            var opcionSeleccionada = $(this).val();
            $('#campos_opcion_multiple, #campos_respuesta_abierta').addClass('d-none');
            if (opcionSeleccionada === 'opcion_multiple') {
                $('#campos_opcion_multiple').removeClass('d-none');
            } else if (opcionSeleccionada === 'respuesta_abierta') {
                $('#campos_respuesta_abierta').removeClass('d-none');
            }
        });
    });
</script>
</body>
</html>

