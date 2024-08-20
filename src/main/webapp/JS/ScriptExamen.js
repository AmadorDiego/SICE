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
            <label class="form-label text-white h6">Pregunta:</label>
            <input type="text" class="form-control" name="texto_pregunta[]" required>
            <button type="button" class="btn btn-danger btn-sm bg-red-SICE mb-3" onclick="eliminarPregunta(${preguntaIndex})">
                <h6>Eliminar pregunta</h6>
            </button>
        </div>
        
    `;

    if (tipo === 'cerrada') {
        contenido += `
            <div id="opciones-${preguntaIndex}" class="mt-3">
                <div class="mb-2 mt-2">
                    <input class="" type="radio" name="opcion_correcta_${preguntaIndex}" value="1" checked>
                    <input type="text" class="form-control d-inline-block w-75" name="opcion_${preguntaIndex}[]" required>
                </div>
                <div class="mb-2">
                    <input type="radio" class="me-2" name="opcion_correcta_${preguntaIndex}" value="2">
                    <input type="text" class="form-control d-inline-block w-75" name="opcion_${preguntaIndex}[]" required>
                </div>
            </div>
            <button type="button" class="btn btn-info btn-sm" onclick="agregarOpcion(${preguntaIndex})">
                <span class="material-symbols-rounded">add</span>
            </button>
        `;
    }

    preguntaContainer.innerHTML = contenido;
    document.getElementById('id_preguntas').appendChild(preguntaContainer);
    actualizarCantidadPreguntas();
}

function eliminarPregunta(index) {
    const pregunta = document.getElementById(`pregunta-${index}`);
    pregunta.remove();
    actualizarCantidadPreguntas();
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

function actualizarCantidadPreguntas() {
    const cantidadPreguntas = document.querySelectorAll('.pregunta-container').length;
    document.getElementById('cantidad_preguntas').value = cantidadPreguntas;
}

// Inicializar el contador de preguntas al cargar la página
window.addEventListener('load', actualizarCantidadPreguntas);

