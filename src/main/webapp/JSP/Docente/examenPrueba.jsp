<%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 08/08/2024
  Time: 04:16 p. m.
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
    </style>

</head>
<body>
<div class="container mt-4">
    <h1 class="mb-4">Crear Nuevo Examen</h1>
    <form id="examenForm" action="${pageContext.request.contextPath}/CrearExamenServlet" method="post" class="mb-4">
        <div class="mb-3">
            <label class="form-label" for="nombre_examen">Nombre del Examen:</label>
            <input class="form-control" type="text" id="nombre_examen" name="nombre_examen" required>
        </div>
        <div class="mb-3">
            <label class="form-label" for="descripcion">Descripción:</label>
            <textarea class="form-control fixed-size-textarea" id="descripcion" name="descripcion" rows="4"></textarea>
        </div>
        <input type="hidden" name="cantidad_preguntas" id="cantidad_preguntas" value="">
        <div id="preguntas-container">
            <!-- Las preguntas se agregarán aquí dinámicamente -->
        </div>
        <button type="button" id="agregar_pregunta_abierta" class="btn btn-secondary mt-3">Agregar pregunta abierta</button>
        <button type="button" id="agregar_pregunta_cerrada" class="btn btn-secondary mt-3">Agregar pregunta cerrada</button>
        <button type="submit" class="btn btn-primary mt-3">Guardar Examen</button>
    </form>
</div>

<script src="../../JS/jquery-3.7.0.js"></script>
<script src="../../JS/bootstrap.js"></script>
<script>
    let preguntaIndex = 0;

    document.getElementById('agregar_pregunta_abierta').addEventListener('click', function() {
        preguntaIndex++;
        const preguntaContainer = document.createElement('div');
        preguntaContainer.classList.add('mb-3', 'pregunta-container');
        preguntaContainer.innerHTML = `
                <h4>Pregunta ${preguntaIndex}</h4>
                <input type="hidden" name="id_pregunta[]" value="${preguntaIndex}">
                <input type="hidden" name="id_tipo_pregunta" value="1">
                <div class="mb-2">
                    <label class="form-label">Pregunta:</label>
                    <input type="text" class="form-control" name="pregunta[]" required>
                </div>
            `;
        document.getElementById('preguntas-container').appendChild(preguntaContainer);
    });
    document.getElementById('agregar_pregunta_cerrada').addEventListener('click', function() {
        preguntaIndex++;
        const preguntaContainer = document.createElement('div');
        preguntaContainer.classList.add('mb-3', 'pregunta-container');
        preguntaContainer.innerHTML = `
                <h4>Pregunta ${preguntaIndex}</h4>
                <input type="hidden" name="id_pregunta[]" value="${preguntaIndex}">
                <input type="hidden" name="id_tipo_pregunta" value="2">
                <div class="mb-2">
                    <label class="form-label">Pregunta:</label>
                    <input type="text" class="form-control" name="pregunta[]" required>
                </div>
        `;
        document.getElementById('preguntas-container').appendChild(preguntaContainer);
        const opcionContainer = document.createElement('div');
        opcionContainer.classList.add('mb-3', 'opcion-container');
        opcionContainer.innerHTML = `
                <input type="hidden" name="id_pregunta[]" value="${preguntaIndex}">
                <input type="hidden" name="id_tipo_pregunta" value="2">
                <div class="mb-2">
                    <label class="form-label">Pregunta:</label>
                    <input type="text" class="form-control" name="texto_pregunta[]" required>
                </div>
                <div class="mb-2">
                    <label class="form-label">Opcion:</label>
                    <input type="text" class="form-control" name="texto_pregunta[]" required>
                </div>
                <div class="mb-2">
                    <label class="form-label">Opcion:</label>
                    <input type="text" class="form-control" name="texto_pregunta[]" required>
                </div>
                <div class="mb-2">
                    <button type="button" id="agregar_opcion" class="btn btn-secondary mt-3">Agregar opcion</button>
                </div>
        `;
        document.getElementById('preguntas-container').appendChild(preguntaContainer);
        <div className="mb-2">
            <label className="form-label">Tipo de pregunta:</label>
            <select className="form-select" name="id_tipo_pregunta[]" required>
                <option value="1">Abierta</option>
                <option value="2">Cerrada</option>
            </select>
        </div>

    });


    document.getElementById('examenForm').addEventListener('submit', function (e) {
        e.preventDefault();
        // Aquí puedes agregar lógica adicional antes de enviar el formulario
        this.submit();
    });
</script>
</body>
</html>
