document.addEventListener('DOMContentLoaded', function () {
    let bancoPreguntasAbiertas = [];
    let bancoPreguntasCerradas = [];
    let contadorPreguntas = 0;
    let contadorOpciones = {};

    window.agregarPreguntaBanco = function(idPregunta, idExamen) {
        // URL del servlet
        const url = `/BancoPreguntasServlet?id_examen=${idExamen}&id_pregunta=${idPregunta}`;
        console.log('Iniciando agregarPreguntaBanco');

        // Realizar la petición AJAX usando Fetch
        fetch(url, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok, problemas con el fetch en js');
                }
                return response.json();
            })
            .then(data => {
                // Asumimos que el servidor devuelve un objeto con la estructura correcta
                const pregunta = data.pregunta;
                const opciones = data.opciones;

                // Construir el objeto pregunta con sus opciones
                const preguntaCompleta = {
                    id: pregunta.id,
                    texto: pregunta.texto,
                    tipo: pregunta.tipo === 'abierta' ? 'abierta' : 'cerrada',
                    opciones: opciones.map(opcion => ({
                        id: opcion.id,
                        texto: opcion.texto,
                        correcta: opcion.correcta
                    }))
                };

                agregarPreguntaAlExamen(preguntaCompleta);
                actualizarListaPreguntas(); // Asegúrate de que esta línea esté presente
            })
            .catch(error => {
                console.error('Error al obtener detalles de la pregunta:', error);
                alert('Hubo un error al obtener los detalles de la pregunta. Por favor, intente nuevamente.');
            });
    };

    function agregarPregunta(idPregunta) {
        // Hacer una petición AJAX para obtener los detalles de la pregunta
        fetch(`/BancoPreguntasServlet?id_pregunta=${idPregunta}`)
            .then(response => response.json())
            .then(data => {
                const pregunta = data.pregunta;
                const opciones = data.opciones;

                const preguntasContainer = document.getElementById('id_preguntas');
                const nuevaPregunta = document.createElement('div');
                nuevaPregunta.className = 'mb-3 pregunta-container';
                nuevaPregunta.id = `pregunta-${pregunta.id_pregunta}`;

                let preguntaHTML = `
                <div class="mb-2">
                    <label class="form-label text-white h6">Pregunta:</label>
                    <input type="text" class="form-control" name="texto_pregunta[]" value="${pregunta.pregunta}" required>
                    <input type="hidden" name="id_pregunta[]" value="${pregunta.id_pregunta}">
                    <input type="hidden" name="tipo_pregunta[]" value="${pregunta.id_tipo_pregunta}">
                </div>
            `;

                if (pregunta.id_tipo_pregunta == 2) { // Pregunta cerrada
                    preguntaHTML += '<div class="opciones-container">';
                    opciones.forEach((opcion, index) => {
                        preguntaHTML += `
                        <div class="mb-2 mt-2 d-flex px-3">
                            <input class="form-check-input me-2 align-self-center" type="radio" 
                                   name="opcion_correcta_${pregunta.id_pregunta}" value="${opcion.id_opcion}"
                                   ${opcion.correcta == 1 ? 'checked' : ''}>
                            <input type="text" class="form-control" name="opcion_texto_${pregunta.id_pregunta}[]" 
                                   value="${opcion.opcion}" required>
                        </div>
                    `;
                    });
                    preguntaHTML += '</div>';
                }

                preguntaHTML += `
                <button type="button" class="btn btn-danger btn-sm mt-2" onclick="eliminarPregunta(${pregunta.id_pregunta})">
                    Eliminar pregunta
                </button>
            `;

                nuevaPregunta.innerHTML = preguntaHTML;
                preguntasContainer.appendChild(nuevaPregunta);

                actualizarContadorPreguntas();
            })
            .catch(error => {
                console.error('Error al obtener detalles de la pregunta:', error);
                alert('Hubo un error al obtener los detalles de la pregunta. Por favor, intente nuevamente.');
            });
    }

    // Función para agregar pregunta al examen (común para banco y nuevas)
    function agregarPreguntaAlExamen(pregunta) {
        preguntaIndex++;
        const preguntaContainer = document.createElement('div');
        preguntaContainer.classList.add('mb-3', 'pregunta-container');
        preguntaContainer.id = `pregunta-examen-${preguntaIndex}`;

        let contenido = `
            <input type="hidden" name="id_pregunta[]" value="${pregunta.id}">
            <input type="hidden" name="id_tipo_pregunta[]" value="${pregunta.tipo === 'abierta' ? '1' : '2'}">
            <div class="mb-2">
                <label class="form-label text-white h6">Pregunta:</label>
                <input type="text" class="form-control" name="texto_pregunta[]" value="${pregunta.texto}" ${pregunta.id.startsWith('nueva_') ? '' : 'readonly'}>
                <button type="button" class="btn btn-danger btn-sm bg-red-SICE mb-3" onclick="eliminarPregunta(${preguntaIndex})">
                    <h6>Eliminar pregunta</h6>
                </button>
            </div>
        `;

        if (pregunta.tipo === 'cerrada') {
            contenido += `<div id="opciones-${preguntaIndex}" class="mt-3">`;
            pregunta.opciones.forEach((opcion, index) => {
                contenido += `
                    <div class="mb-2 opcion-container">
                        <input type="radio" name="opcion_correcta_${preguntaIndex}" value="${index + 1}" ${opcion.correcta ? 'checked' : ''}>
                        <input type="text" class="form-control d-inline-block w-75" name="opcion_${preguntaIndex}[]" value="${opcion.texto}" ${pregunta.id.startsWith('nueva_') ? '' : 'readonly'}>
                        ${pregunta.id.startsWith('nueva_') ? `<button type="button" class="btn btn-sm btn-danger" onclick="eliminarOpcion(this)">X</button>` : ''}
                    </div>
                `;
            });
            contenido += `</div>`;
            if (pregunta.id.startsWith('nueva_')) {
                contenido += `
                    <button type="button" class="btn btn-info btn-sm" onclick="agregarOpcion(${preguntaIndex})">
                        <span class="material-symbols-rounded">add</span>
                    </button>
                `;
            }
        }

        preguntaContainer.innerHTML = contenido;
        document.getElementById('id_preguntas').appendChild(preguntaContainer);
        actualizarCantidadPreguntas();
    }


    // Función para mostrar una pregunta del banco
    window.mostrarPregunta = function(id, tipo) {
        const banco = tipo === 'abierta' ? bancoPreguntasAbiertas : bancoPreguntasCerradas;
        const pregunta = banco.find(p => p.id_pregunta === id);

        if (!pregunta) {
            alert('Pregunta no encontrada');
            return;
        }

        const preguntaContainer = document.createElement('div');
        preguntaContainer.classList.add('mb-3', 'pregunta-container');
        preguntaContainer.id = `pregunta-examen-${pregunta.id_pregunta}`;

        let contenido = `
            <input type="hidden" name="id_pregunta[]" value="${pregunta.id_pregunta}">
            <input type="hidden" name="id_tipo_pregunta[]" value="${pregunta.id_tipo_pregunta}">
            <div class="mb-2">
                <label class="form-label text-white h6">Pregunta:</label>
                <input type="text" class="form-control" name="texto_pregunta[]" value="${pregunta.pregunta}" readonly>
                <button type="button" class="btn btn-danger btn-sm bg-red-SICE mb-3" onclick="eliminarPreguntaMostrada(${pregunta.id_pregunta})">
                    <h6>Eliminar pregunta</h6>
                </button>
            </div>
        `;

        if (tipo === 'cerrada') {
            contenido += `<div id="opciones-${pregunta.id_pregunta}" class="mt-3">`;
            pregunta.opciones.forEach((opcion, index) => {
                contenido += `
                    <div class="mb-2">
                        <input type="radio" name="opcion_correcta_${pregunta.id_pregunta}" value="${opcion.id_opcion}" ${opcion.estado ? 'checked' : ''} disabled>
                        <input type="text" class="form-control d-inline-block w-75" name="opcion_${pregunta.id_pregunta}[]" value="${opcion.opcion}" readonly>
                    </div>
                `;
            });
            contenido += `</div>`;
        }

        preguntaContainer.innerHTML = contenido;
        document.getElementById('preguntas_mostradas').appendChild(preguntaContainer);
    };

    // Función para actualizar la lista de preguntas en el banco
    function actualizarListaPreguntas() {
        console.log('Iniciando actualizarListaPreguntas');
        const listaPreguntas = document.getElementById('listaPreguntas');
        console.log('listaPreguntas:', listaPreguntas);
        if (!listaPreguntas) {
            console.error('No se pudo encontrar el elemento con id "listaPreguntas"');
            return;
        }
        listaPreguntas.innerHTML = '';

        bancoPreguntasAbiertas.forEach(pregunta => {
            const li = document.createElement('li');
            li.textContent = `[Abierta] ${pregunta.pregunta}`;
            li.onclick = () => mostrarPregunta(pregunta.id_pregunta, 'abierta');
            listaPreguntas.appendChild(li);
        });

        bancoPreguntasCerradas.forEach(pregunta => {
            const li = document.createElement('li');
            li.textContent = `[Cerrada] ${pregunta.pregunta}`;
            li.onclick = () => mostrarPregunta(pregunta.id_pregunta, 'cerrada');
            listaPreguntas.appendChild(li);
        });
    }

    // Función para limpiar el formulario después de agregar una pregunta
    function limpiarFormulario() {
        document.getElementById('texto_pregunta').value = '';
        const opcionesContainer = document.getElementById('opciones_container');
        opcionesContainer.innerHTML = `
            <div class="mb-2">
                <input type="radio" name="opcion_correcta" value="1">
                <input type="text" class="form-control d-inline-block w-75 opcion-input" required>
            </div>
            <div class="mb-2">
                <input type="radio" name="opcion_correcta" value="2">
                <input type="text" class="form-control d-inline-block w-75 opcion-input" required>
            </div>
        `;
    }

    window.eliminarPregunta = function(index) {
        const pregunta = document.getElementById(`pregunta-examen-${index}`);
        if (pregunta) {
            pregunta.remove();
            actualizarCantidadPreguntas();
        }
    };

    window.agregarOpcion = function(preguntaIndex) {
        const opcionesContainer = document.getElementById(`opciones-${preguntaIndex}`);
        const numOpciones = opcionesContainer.children.length;

        if (numOpciones < 5) {
            const nuevaOpcion = document.createElement('div');
            nuevaOpcion.classList.add('mb-2', 'opcion-container');
            nuevaOpcion.innerHTML = `
                <input type="radio" name="opcion_correcta_${preguntaIndex}" value="${numOpciones + 1}">
                <input type="text" class="form-control d-inline-block w-75" name="opcion_${preguntaIndex}[]" required>
                <button type="button" class="btn btn-sm btn-danger" onclick="eliminarOpcion(this)">X</button>
            `;
            opcionesContainer.appendChild(nuevaOpcion);
        } else {
            alert('No se pueden agregar más de 5 opciones.');
        }
    };

    window.eliminarOpcion = function(button) {
        const opcionContainer = button.closest('.opcion-container');
        const opcionesContainer = opcionContainer.parentElement;
        opcionContainer.remove();

        // Reordenar las opciones restantes
        const opciones = opcionesContainer.querySelectorAll('.opcion-container');
        opciones.forEach((opcion, index) => {
            opcion.querySelector('input[type="radio"]').value = index + 1;
        });
    };

    function actualizarCantidadPreguntas() {
        const cantidadPreguntas = document.querySelectorAll('.pregunta-container').length;
        document.getElementById('cantidad_preguntas').value = cantidadPreguntas;
    }

    // Inicialización del banco de preguntas
    const listaBancoPreguntas = document.getElementById('lista-banco-preguntas');
    if (listaBancoPreguntas) {
        listaBancoPreguntas.querySelectorAll('li').forEach(li => {
            const idPregunta = li.dataset.idPregunta;
            const tipoPregunta = li.dataset.tipoPregunta === '1' ? 'abierta' : 'cerrada';
            const botonAgregar = li.querySelector('button');
            botonAgregar.onclick = function() {
                agregarPreguntaDesdeBanco(idPregunta, tipoPregunta);
            };
        });
    }
});