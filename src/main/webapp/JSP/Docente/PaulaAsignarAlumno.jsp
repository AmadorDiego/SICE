<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asignar alumnos</title>
    <link href="../../CSS/bootstrap.css" rel="stylesheet">
    <link href="../../CSS/datatables.css" rel="stylesheet">
    <link href="../../CSS/docente.css" rel="stylesheet">
    <style>
        .navbar {
            background-color: #003366 !important;
        }
        .navbar-light .navbar-nav .nav-link {
            color: white !important;
        }
        .full-width-navbar {
            margin: 0;
            padding: 0;
            width: 100%;
        }
    </style>
</head>
<body>
<div class="full-width-navbar">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"></a>
        </div>
    </nav>
</div>
<div class="navbar"></div>
<div class="container">
    <br>
    <h1>Asignar alumnos</h1>
    <div class="group-info">
        <h3>Grupo de 3 A</h3>
    </div>
    <div class="search-and-select row align-items-center">
        <div class="col-auto">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="selectAll">
                <label class="form-check-label" for="selectAll">
                    Seleccionar a todos
                </label>
            </div>
        </div>
        <div class="col-auto">
            <a class="btn btn-primary" href="indexDocente.jsp"> Regresar </a>
        </div>

    </div>
    <div class="table-responsive">
        <table id="usuarios" class="table table-striped table-hover">
            <thead>
            <tr>
                <th>Seleccionar</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Correo</th>
            </tr>
            </thead>
            <tbody id="usuarioTabla">
            <%
                UsuarioDao dao = new UsuarioDao();
                ArrayList<Usuario> lista = dao.getAll();
                for (Usuario u : lista) {
                    if (u.getEstado() != 2) {
            %>
            <tr>
                <td><input type="checkbox" class="select-alumno" value="<%= u.getId_usuario() %>"></td>
                <td><%= u.getNombre_usuario() %></td>
                <td><%= u.getApellido_usuario() %></td>
                <td><%= u.getCorreo_electronico() %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
    <div class="text-end">
        <button class="btn btn-primary" id="guardarAsignacion">Guardar</button>
    </div>
</div>

<script src="../../JS/jquery-3.7.0.js"></script>
<script src="../../JS/bootstrap.js"></script>
<script src="../../JS/datatables.js"></script>
<script src="../../JS/dataTables.bootstrap5.js"></script>
<script src="../../JS/es-MX.json"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const selectAllCheckbox = document.getElementById('selectAll');
        const usuarioCheckboxes = document.querySelectorAll('.select-alumno');

        selectAllCheckbox.addEventListener('change', () => {
            const isChecked = selectAllCheckbox.checked;
            usuarioCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
        });

        document.getElementById('guardarAsignacion').addEventListener('click', () => {
            const selectedUsuario = Array.from(usuarioCheckboxes)
                .filter(checkbox => checkbox.checked)
                .map(checkbox => checkbox.value);

            if (selectedUsuario.length === 0) {
                alert('Por favor seleccione al menos un alumno.');
                return;
            }

            fetch('AsignarUsuarioServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ usuario: selectedUsuario })
            }).then(response => {
                if (response.ok) {
                    alert('Alumnos asignados exitosamente');
                    location.reload();
                } else {
                    alert('Error al asignar alumnos');
                }
            });
        });

        const table = $('#usuarios').DataTable({
            language: {
                url: '../../JS/es-MX.json'
            }
        });
    });
</script>
</body>
</html>
