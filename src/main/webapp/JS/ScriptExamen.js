let preguntaIndex = 0;

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
}


