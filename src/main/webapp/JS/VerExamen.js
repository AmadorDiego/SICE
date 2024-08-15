window.addEventListener('DOMContentLoaded', function() {
    cargarPreguntas();
});

function cargarPreguntas() {
    fetch('../../VerExamenServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ id_examen: document.getElementById('id_examen').value })
    })
        .then(response => response.json())
        .then(data => {
            const preguntasContainer = document.getElementById('id_preguntas');
            preguntasContainer.innerHTML = '';

            data.forEach((pregunta, index) => {
                const preguntaContainer = document.createElement('div');
                preguntaContainer.classList.add('mb-3', 'pregunta-container');
                preguntaContainer.id = `pregunta-${index + 1}`;

                let contenido = `
                <input type="hidden" name="id_pregunta[]" value="${index + 1}">
                <input type="hidden" name="id_tipo_pregunta[]" value="${pregunta.tipo}">
                <div class="mb-2">
                    <label class="form-label text-white">Pregunta:</label>
                    <input type="text" class="form-control" name="texto_pregunta[]" value="${pregunta.texto}" required>
                </div>
            `;

                if (pregunta.tipo === 2) {
                    contenido += `
                    <div id="opciones-${index + 1}">
                `;

                    pregunta.opciones.forEach((opcion, opcionIndex) => {
                        contenido += `
                        <div class="mb-2">
                            <input type="radio" name="respuesta_opcion_${index + 1}" value="${opcionIndex + 1}" ${opcion.correcta ? 'checked' : ''}>
                            <input type="text" class="form-control d-inline-block w-75" name="opcion_${index + 1}[]" value="${opcion.texto}" required>
                        </div>
                    `;
                    });

                    contenido += `
                    </div>
                    <button type="button" class="btn btn-info btn-sm" onclick="agregarOpcion(${index + 1})">Agregar opción</button>
                `;
                } else {
                    contenido += `
                    <div class="mb-2">
                        <label class="form-label text-white">Respuesta:</label>
                        <input type="text" class="form-control" name="respuesta_abierta_${index + 1}">
                    </div>
                `;
                }

                preguntaContainer.innerHTML = contenido;
                preguntasContainer.appendChild(preguntaContainer);
            });

            actualizarCantidadPreguntas();
        })
        .catch(error => {
            console.error('Error al cargar las preguntas:', error);
        });
}

// Otras funciones