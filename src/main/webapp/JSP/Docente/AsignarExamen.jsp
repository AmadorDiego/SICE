<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 17/08/2024
  Time: 05:31 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 17/08/2024
  Time: 05:31 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Grupo" %>
<%@ page import="mx.edu.utez.sice.model.Carrera" %>
<%@ page import="mx.edu.utez.sice.model.DivisionAcademica" %>
<%@ page import="mx.edu.utez.sice.dao.GrupoDao" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.model.Tabla" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Asignar Examen</title>
  <link href="../../CSS/bootstrap.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css" rel="stylesheet">
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

<div class="container">
  <br>
  <h1>Asignar Examen</h1>
  <h3>Exámenes por asignar</h3>
  <h3 id="id_periodo"><strong>Mayo-Agosto 2024</strong></h3>

  <div class="filters d-flex align-items-center mb-4">
    <span class="me-2">Filtros </span>

    <select id="id_grupo" name="grupo" class="form-select me-2">
      <option value="">Seleccione Grupo</option>
      <%
        GrupoDao grupoDao = new GrupoDao();
        ArrayList<Grupo> grupos = grupoDao.getAll();
        for (Grupo g : grupos) {
      %>
      <option value="<%= g.getId_grupo() %>"><%= g.getGrado() %> - <%= g.getGrupo() %></option>
      <%
        }
      %>
    </select>

    <select id="id_division_academica" name="division_academica" class="form-select me-2">
      <option value="">Seleccione División</option>
      <%
        DivisionAcademicaDao divisionDao = new DivisionAcademicaDao();
        ArrayList<DivisionAcademica> divisiones = divisionDao.getAll();
        for (DivisionAcademica d : divisiones) {
      %>
      <option value="<%= d.getId_division_academica() %>"><%= d.getDivision_academica() %></option>
      <%
        }
      %>
    </select>

    <select class="form-select carrera me-2" id="id_carrera" name="carrera">
      <option value="">Seleccione Carrera</option>
      <%
        CarreraDao carreraDao = new CarreraDao();
        ArrayList<Carrera> carreras = carreraDao.getAll();
        for (Carrera c : carreras) {
      %>
      <option value="<%= c.getId_carrera() %>"><%= c.getCarrera() %></option>
      <%
        }
      %>
    </select>

    <button id="buscarBtn" class="btn btn-primary me-2">Buscar</button>

    <div class="col-auto">
      <a class="btn btn-primary" href="indexDocente.jsp"> Regresar </a>
    </div>
  </div>

  <table id="tablaExamenes" class="display">
    <thead>
    <tr>
      <th>Grupo</th>
      <th>Grado</th>
      <th>División</th>
      <th>Carrera</th>
      <th>Seleccionar Grupo</th>
    </tr>
    </thead>
    <tbody id="contenido">
    <%
      ArrayList<Tabla> grupoInfo = grupoDao.getInfo();
      for (Tabla t : grupoInfo) {
    %>
    <tr>
      <td><%= t.getGrupo().getGrupo() %></td>
      <td><%= t.getGrupo().getGrado() %></td>
      <td><%= t.getDivisionAcademica().getDivision_academica() %></td>
      <td><%= t.getCarrera().getCarrera() %></td>
      <td><a class="btn btn-primary" href="PaulaAsignarAlumno.jsp"> Asignar </a></td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
<script>
  $(document).ready(function() {
    var table = $('#tablaExamenes').DataTable({
      "language": {
        "emptyTable": "No hay datos disponibles en la tabla"
      }
    });

    $('#buscarBtn').click(function() {
      var grupo = $('#id_grupo');
      var division = $('#id_division_academica');
      var carrera = $('#id_carrera');

      var id_grupo = grupo.val();
      var id_division = division.val();
      var id_carrera = carrera.val();

      var grupoSeleccionado = grupo.find('option:selected').text().split(' - ');
      var grado = grupoSeleccionado[0] || '';
      var letraGrupo = grupoSeleccionado[1] || '';

      console.log("Realizando búsqueda con los siguientes parámetros:");
      console.log("Grado:" + grado);
      console.log("Grupo: "+ letraGrupo);
      console.log("ID grupo: " + id_grupo);
      console.log("ID division: " + id_division);
      console.log("ID carrera: " + id_carrera);

      fetch('../../asignarExamen?id_grupo='+id_grupo+'&grado='+grado+'&grupo='+letraGrupo+'&id_division='+id_division+'&id_carrera='+id_carrera, {
        method: 'GET'
      }).then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      }).then(data => {
        console.log("Datos recibidos del servidor:", data);
        table.clear();
        if (!Array.isArray(data) || data.length === 0) {
          console.log("No se encontraron datos");
          // Opcionalmente, puedes agregar una fila a la tabla indicando que no hay datos
          table.row.add(['No se encontraron datos', '', '', '', '']).draw();
        } else {
          data.forEach(tabla => {
            if (tabla && tabla.grupo && tabla.divisionAcademica && tabla.carrera) {
              table.row.add([
                tabla.grupo.grupo || '',
                tabla.grupo.grado || '',
                tabla.divisionAcademica.division_academica || '',
                tabla.carrera.carrera || '',
                '<a class="btn btn-primary" href="PaulaAsignarAlumno.jsp"> Asignar </a>'
              ]);
            } else {
              console.log("Datos incompletos para una fila:", tabla);
            }
          });
        }
        table.draw();
      }).catch(error => {
        console.error("Error: ", error);
        alert("Ocurrió un error: " + error.message);
      });
    });
  });
</script>
</body>
</html>

