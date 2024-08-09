/*let preguntaIndex = 0;

function agregarPregunta() {
    preguntaIndex++;
    const preguntaHtml = `
        <div class="mb-3 pregunta-container">
            <h4>Pregunta ${preguntaIndex}</h4>
            <input type="hidden" name="pregunta_index_${preguntaIndex}" value="${preguntaIndex}">
            <div class="mb-2">
                <label for="pregunta_${preguntaIndex}" class="form-label">Texto de la Pregunta</label>
                <input type="text" class="form-control" id="pregunta_${preguntaIndex}" name="pregunta_${preguntaIndex}" required>
            </div>
            <div class="mb-2">
                <label for="tipo_pregunta_${preguntaIndex}" class="form-label">Tipo de Pregunta</label>
                <select class="form-control" id="tipo_pregunta_${preguntaIndex}" name="tipo_pregunta_${preguntaIndex}">
                    <option value="1">Opción Múltiple</option>
                    <option value="2">Respuesta Abierta</option>
                </select>
            </div>
        </div>
    `;
    document.getElementById('id_preguntas').insertAdjacentHTML('beforeend', preguntaHtml);
}*/

    let preguntaIndex = 0;

    function agregarPregunta(tipo) {
    preguntaIndex++;
    const preguntaContainer = document.createElement('div');
    preguntaContainer.classList.add('mb-3', 'pregunta-container');
    preguntaContainer.id = `pregunta-${preguntaIndex}`;

    let contenido = `
                <input type="hidden" name="id_pregunta[]" value="${preguntaIndex}">
                <input type="hidden" name="id_tipo_pregunta[]" value="${tipo === 'abierta' ? '1' : '2'}">
                <div class="mb-2">
                    <label class="form-label">Pregunta:</label>
                    <input type="text" class="form-control" name="texto_pregunta[]" required>
                </div>
                <button type="button" class="btn btn-danger btn-sm me-2" onclick="eliminarPregunta(${preguntaIndex})">Eliminar Pregunta</button>
            `;

    if (tipo === 'cerrada') {
    contenido += `
                    <div id="opciones-${preguntaIndex}">
                        <div class="mb-2">
                            <input type="radio" name="opcion_correcta_${preguntaIndex}" value="1" checked>
                            <input type="text" class="form-control d-inline-block w-75" name="opcion_${preguntaIndex}[]" required>
                        </div>
                        <div class="mb-2">
                            <input type="radio" name="opcion_correcta_${preguntaIndex}" value="2">
                            <input type="text" class="form-control d-inline-block w-75" name="opcion_${preguntaIndex}[]" required>
                        </div>
                    </div>
                    <button type="button" class="btn btn-info btn-sm" onclick="agregarOpcion(${preguntaIndex})">Agregar opción</button>
                `;
}

    preguntaContainer.innerHTML = contenido;
    document.getElementById('id_preguntas').appendChild(preguntaContainer);
}

    function eliminarPregunta(index) {
    const pregunta = document.getElementById(`pregunta-${index}`);
    pregunta.remove();
}

function agregarOpcion(preguntaIndex) {
    const opcionesContainer = document.getElementById(`opciones-${preguntaIndex}`);
    const numOpciones = opcionesContainer.children.length;

    if (numOpciones < 5) {
        const nuevaOpcion = document.createElement('div');
        nuevaOpcion.classList.add('mb-2');
        nuevaOpcion.innerHTML = `
            <input type="radio" name="opcion_correcta_${preguntaIndex}" value="${numOpciones + 1}">
            <input type="text" class="form-control d-inline-block w-75" name="opcion_${preguntaIndex}[]" required>
        `;
        opcionesContainer.appendChild(nuevaOpcion);
    } else {
        alert('No se pueden agregar más de 5 opciones.');
    }
}

document.getElementById('guardarCambios').addEventListener('click', function() {
    // Aquí puedes agregar lógica de validación si es necesario
    const form = document.getElementById('id_examen');
    if (form.checkValidity()) {
        form.submit();
    } else {
        // Si el formulario no es válido, muestra los mensajes de error
        form.reportValidity();
    }
});

