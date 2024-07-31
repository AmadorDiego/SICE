<%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 30/07/2024
  Time: 08:19 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Crear examen</title>
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <script src='JS/bootstrap.js'></script>
</head>
<body>
<h1>Crear Nuevo Examen</h1>
<form action="crear" method="post">
    <div class="mb-3" id="inputs-container">
        <div class="input-container">
            <input type="text" name="dynamic-input[]" class="form-control" placeholder="Escribe algo...">
        </div>
    </div>
    <button id="add-input" class="btn btn-primary">Agregar otro input</button>
</form>


<script>
    document.getElementById('add-input').addEventListener('click', function() {
        // Crear un nuevo contenedor para el nuevo input
        var newInputContainer = document.createElement('div');
        newInputContainer.classList.add('input-container');

        // Crear un nuevo input
        var newInput = document.createElement('input');
        newInput.type = 'text';
        newInput.name = 'dynamic-input[]';
        newInput.placeholder = 'Escribe algo...';
        newInput.className = 'form-control';

        // Agregar el nuevo input al contenedor
        newInputContainer.appendChild(newInput);

        // Agregar el contenedor con el nuevo input al contenedor principal
        document.getElementById('inputs-container').appendChild(newInputContainer);
    });
</script>
</body>
</html>
