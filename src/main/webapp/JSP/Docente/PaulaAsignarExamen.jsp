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

        <div class="col-auto">
            <a class="btn btn-primary" href="indexDocente.jsp"> Regresar </a>
        </div>
    </div>

    <table id="tablaExamenes" class="display">
        <thead>
        <tr>
            <th>Grado</th>
            <th>Grupo</th>
            <th>División</th>
            <th>Carrera</th>
            <th>Seleccionar Grupo</th>
        </tr>
        </thead>
        <tbody id="contenido">
        <%
            ArrayList<Tabla> grupoInfo = grupoDao.getInfo();
            for (Tabla t : grupoInfo) {
                Carrera carrera = new Carrera();
                DivisionAcademica divisionAcademica = new DivisionAcademica();
        %>
        <tr>
            <td><%= t.getGrupo().getGrado() %></td>
            <td><%= t.getGrupo().getGrupo() %></td>
            <td><%= t.getDivision().getDivision_academica() %></td>
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
        $('#tablaExamenes').DataTable();

        var bandera_grupo = false;
        var bandera_carrera = false;
        var bandera_division = false;

        var grupo = document.getElementById("id_grupo");
        grupo.addEventListener("change", () => {
            if(grupo.value > 0){
                bandera_grupo = true;
            }
        });

        var division = document.getElementById("id_division_academica");
        division.addEventListener("change", () => {
            if(division.value > 0){
                bandera_division = true;
            }
        });

        var carrera = document.getElementById("id_carrera");
        carrera.addEventListener("change", () => {
            if(carrera.value > 0){
                bandera_carrera = true;
            }

            if(bandera_grupo && bandera_division && bandera_carrera){
                //Un metodo fetch para comunicarnos con el servlet
                var id_grupo = grupo.value;
                var id_division = division.value;
                var id_carrera = carrera.value;

                console.log("ID grupo: " + id_grupo);
                console.log("ID division: " + id_division);
                console.log("ID carrera: " + id_carrera);

                fetch('../../asignarExamen?id_grupo='+id_grupo+'&id_division='+id_division+'&id_carrera='+id_carrera,{
                    method: 'GET'
                }).then(response => {
                    return response.text();
                }).then(data => {
                    //Esto es la lista de Tabla
                    let respuesta = JSON.parse(data);
                    var tbody = document.getElementById("contenido");
                    tbody.innerHTML = "";

                    for(const tabla in respuesta) {
                        var fila = document.createElement("tr");
                        var td_grado = document.createElement("td");
                        var td_grupo = document.createElement("td");
                        var td_division = document.createElement("td");
                        var td_carrera = document.createElement("td");
                        var td_boton = document.createElement("td");

                        td_grado.innerText = tabla.grupo.grado;
                        fila.appendChild(td_grado);
                        td_grupo.innerText = tabla.grupo.grupo;
                        fila.appendChild(td_grupo);
                        td_division.innerText = tabla.division.division_academica;
                        fila.appendChild(td_division);
                        td_carrera.innerText = tabla.carrera.carrera;
                        fila.appendChild(td_carrera);
                        td_boton.innerHTML = '<a class="btn btn-primary" href="PaulaAsignarAlumno.jsp"> Asignar </a>'
                        fila.appendChild(td_boton);

                        tbody.appendChild(fila);
                    }
                }).catch(error => {
                    console.log("Error: ", error);
                });
            }
        });

    });
</script>
</body>
</html>
