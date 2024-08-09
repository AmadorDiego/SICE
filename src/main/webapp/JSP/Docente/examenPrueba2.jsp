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
<div class="container">
    <h1>Crear Nuevo Examen</h1>
    <form id="examenForm" action="submit_exam.jsp" method="post">
        <div class="mb-3">
            <label for="nombre_examen">Nombre del Examen:</label>
            <input type="text" id="nombre_examen" name="nombre_examen" required>
        </div>
        <div class="mb-3">
            <label for="descripcion">Descripción:</label>
            <textarea id="descripcion" name="descripcion" rows="4"></textarea>
        </div>

        <div id="preguntas-container">
            <!-- Las preguntas se agregarán aquí dinámicamente -->
        </div>

        <button type="button" id="agregarPregunta" class="btn">Agregar Pregunta</button>
        <button type="submit" class="btn">Guardar Examen</button>
    </form>
</div>

<script>
    let preguntaIndex = 0;
    let opcionIndex = 0;
    document.getElementById('agregarPregunta').addEventListener('click', function() {
        preguntaIndex++;
        const preguntaContainer = document.createElement('div');
        preguntaContainer.classList.add('pregunta-container');
        preguntaContainer.innerHTML = `
                <h3>Pregunta ${preguntaIndex}</h3>
                <div class="mb-3">
                    <label>Tipo de pregunta:</label>
                    <select class="tipo-pregunta" name="tipo_pregunta[]" onchange="cambiarTipoPregunta(this, ${preguntaIndex})" required>
                        <option value="abierta">Abierta</option>
                        <option value="cerrada">Cerrada</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label>Pregunta:</label>
                    <input type="text" name="pregunta[]" required>
                </div>
                <div class="opciones-container" id="opciones-${preguntaIndex}" style="display: none;">
                    <button type="button" onclick="agregarOpcion(${preguntaIndex})">Agregar Opción</button>
                </div>
            `;
        document.getElementById('preguntas-container').appendChild(preguntaContainer);
    });

    function cambiarTipoPregunta(select, preguntaIndex) {
        opcionIndex++;

        const opcionesContainer = document.getElementById(`opcion-${opcionIndex}-${preguntaIndex}`);
        opcionIndex++;
        if (select.value === "cerrada") {
            opcionesContainer.style.display = 'block';
        } else {
            opcionesContainer.style.display = 'none';
            opcionesContainer.innerHTML = `
            <div>
            <input type="text" name="opcion_${opcionIndex}_${preguntaIndex}[]" placeholder="Opción de respuesta" required> ${opcionIndex+1}
            <input type="text" name="opcion_${opcionIndex}_${preguntaIndex}[]" placeholder="Opción de respuesta" required> ${opcionIndex+1}
            </div>
            <button type="button" onclick="agregarOpcion(${preguntaIndex})">Agregar Opción</button>

            `;
        }
    }

    function agregarOpcion(preguntaIndex) {
        const opcionesContainer = document.getElementById(`opciones-${preguntaIndex}`);
        const nuevaOpcion = document.createElement('div');
        nuevaOpcion.classList.add('mb-2');
        nuevaOpcion.innerHTML = `
                <input type="text" name="opcion_${preguntaIndex}[]" placeholder="Opción de respuesta" required>
            `;
        opcionesContainer.insertBefore(nuevaOpcion, opcionesContainer.querySelector('button'));
    }
</script>
</body>
</html>
