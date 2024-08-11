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

document.getElementById('guardarCambios').addEventListener('click', function(e) {
    e.preventDefault(); // Prevenir el envío normal del formulario
    const form = document.getElementById('id_examen');
    if (form.checkValidity()) {
        // Asegurarse de que el usuario_id esté configurado
        console.log("Elemento id_usuario:", document.getElementById('id_usuario'));
        console.log("Valor de id_usuario:", document.getElementById('id_usuario') ?
            document.getElementById('id_usuario').value : 'No encontrado');

        //El problema surge aqui amador, tecnicamente tiene que estar igual que en examen.jsp
        // y de hecho lo esta, pero no entiendo por que no me lo verifica
        if (!document.getElementById('id_usuario').value) {
            alert('Error: ID de usuario no configurado');
            return;
        }

        // Validar que haya al menos una pregunta
        if (document.querySelectorAll('.pregunta-container').length === 0) {
            alert('Debe agregar al menos una pregunta antes de guardar.');
            return;
        }

        // Validar opciones para preguntas cerradas
        let preguntasValidas = true;
        document.querySelectorAll('.pregunta-container').forEach(pregunta => {
            const tipoPregunta = pregunta.querySelector('input[name="id_tipo_pregunta[]"]').value;
            if (tipoPregunta === '2') { // Pregunta cerrada
                const opciones = pregunta.querySelectorAll('input[type="text"][name^="opcion_"]');
                if (opciones.length < 2) {
                    alert('Las preguntas cerradas deben tener al menos dos opciones.');
                    preguntasValidas = false;
                }
            }
        });

        if (!preguntasValidas) {
            return;
        }

        // Si todas las validaciones pasan, enviar el formulario con AJAX
        $.ajax({
            url: form.action,
            type: 'POST',
            data: new FormData(form),
            processData: false,
            contentType: false,
            success: function(response) {
                const mensajeDiv = document.getElementById('mensajeResultado');
                if (response.includes('exitoso')) {
                    mensajeDiv.className = 'alert alert-success';
                    mensajeDiv.textContent = 'Examen creado exitosamente';
                    // Opcional: redirigir después de un tiempo
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/ExamenServlet?action=listar';
                    }, 2000);
                } else {
                    mensajeDiv.className = 'alert alert-danger';
                    mensajeDiv.textContent = 'Hubo un problema al crear el examen';
                }
                mensajeDiv.style.display = 'block';
            },
            error: function() {
                const mensajeDiv = document.getElementById('mensajeResultado');
                mensajeDiv.className = 'alert alert-danger';
                mensajeDiv.textContent = 'Error al procesar la solicitud';
                mensajeDiv.style.display = 'block';
            }
        });
    } else {
        form.reportValidity();
    }
});

// Inicializar el contador de preguntas al cargar la página
window.addEventListener('load', actualizarCantidadPreguntas);

