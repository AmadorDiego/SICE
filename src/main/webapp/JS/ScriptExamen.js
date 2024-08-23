let bancoPreguntas= [];
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
//window.addEventListener('load', actualizarCantidadPreguntas);

// Funciones de BuscarPreguntas.js (modificadas y adaptadas) ---------------------------------------------------------------------

function actualizarListaBancoPreguntas(preguntas = bancoPreguntas) {
    const lista = document.getElementById('lista-banco-preguntas');
    lista.innerHTML = '';
    preguntas.forEach(pregunta => {
        const li = document.createElement('li');
        li.innerHTML = `
            <input type="checkbox" id="pregunta-${pregunta.id}" onchange="togglePregunta(${pregunta.id})">
            <label for="pregunta-${pregunta.id}">${pregunta.texto}</label>
        `;
        lista.appendChild(li);
    });
}

function togglePregunta(id) {
    const checkbox = document.getElementById(`pregunta-${id}`);
    if (checkbox.checked) {
        const pregunta = bancoPreguntas.find(p => p.id === id);
        agregarPreguntaDesdeElBanco(pregunta);
    } else {
        eliminarPreguntaDelExamen(id);
    }
}

function agregarPreguntaDesdeElBanco(pregunta) {
    preguntaIndex++;
    const preguntaContainer = document.createElement('div');
    preguntaContainer.classList.add('mb-3', 'pregunta-container');
    preguntaContainer.id = `pregunta-examen-${pregunta.id}`;

    let contenido = `
        <input type="hidden" name="preguntasSeleccionadas[]" value="${pregunta.id}">
        <div class="mb-2">
            <label class="form-label text-white h5">Pregunta ${preguntaIndex}:</label>
            <input type="text" class="form-control" value="${pregunta.texto}" readonly>
            <button type="button" class="btn btn-danger btn-sm bg-red-SICE mb-3" onclick="eliminarPreguntaDelExamen(${pregunta.id})">
                <h6>Eliminar pregunta</h6>
            </button>
        </div>
    `;

    if (pregunta.tipo === 'cerrada') {
        contenido += `
            <div class="mt-3">
                ${pregunta.opciones.map((opcion, index) => `
                    <div class="mb-2 mt-2">
                        <input type="radio" disabled ${index === 0 ? 'checked' : ''}>
                        <input type="text" class="form-control d-inline-block w-75" value="${opcion}" readonly>
                    </div>
                `).join('')}
            </div>
        `;
    }

    preguntaContainer.innerHTML = contenido;
    document.getElementById('id_preguntas').appendChild(preguntaContainer);
    actualizarCantidadPreguntas();
}

function eliminarPreguntaDelExamen(id) {
    const pregunta = document.getElementById(`pregunta-examen-${id}`);
    if (pregunta) {
        pregunta.remove();
        const checkbox = document.getElementById(`pregunta-${id}`);
        if (checkbox) {
            checkbox.checked = false;
        }
        actualizarCantidadPreguntas();
    }
}

function buscarEnBanco(busqueda) {
    const resultados = bancoPreguntas.filter(pregunta =>
        pregunta.texto.toLowerCase().includes(busqueda.toLowerCase())
    );
    actualizarListaBancoPreguntas(resultados);
}

function actualizarCantidadPreguntas() {
    const cantidadPreguntas = document.querySelectorAll('.pregunta-container').length;
    document.getElementById('cantidad_preguntas').value = cantidadPreguntas;
}

// Event Listeners
window.addEventListener('load', () => {
    actualizarCantidadPreguntas();
    preguntaIndex = document.querySelectorAll('.pregunta-container').length;

    // Cargar banco de preguntas desde el HTML
    const listaBanco = document.getElementById('lista-banco-preguntas');
    const preguntas = Array.from(listaBanco.querySelectorAll('li')).map(li => {
        const checkbox = li.querySelector('input[type="checkbox"]');
        const label = li.querySelector('label');
        return {
            id: parseInt(checkbox.id.split('-')[1]),
            texto: label.textContent.trim(),
            tipo: li.querySelector('.ml-4') ? 'cerrada' : 'abierta',
            opciones: Array.from(li.querySelectorAll('.ml-4 label')).map(opcionLabel => opcionLabel.textContent.trim())
        };
    });
    bancoPreguntas = preguntas;
    actualizarListaBancoPreguntas();
});

document.getElementById('buscar-banco').addEventListener('input', function() {
    buscarEnBanco(this.value);
});

