function enviarExamen() {
    // Obtener los datos del formulario
    var formData = $('#enviarExamenForm').serialize();

    // Realizar la solicitud AJAX
    $.ajax({
        type: 'POST',
        url: 'EnviarExamenServlet',
        data: formData,
        success: function(response) {
            // Manejar la respuesta del servidor
            console.log(response);
            // Mostrar un mensaje de éxito, redirigir a otra página, etc.
        },
        error: function(xhr, status, error) {
            // Manejar errores de la solicitud AJAX
            console.error(error);
            // Mostrar un mensaje de error al usuario
        }
    });
}
