<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.model.DivisionAcademica" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="mx.edu.utez.sice.model.Carrera" %>
<%@ page import="mx.edu.utez.sice.dao.ExamenDao" %>
<%@ page import="mx.edu.utez.sice.model.Examen" %>

<html>
<head>
    <title>Selección de División, Carrera y Grupo</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<h1>Selecciona tu División, Carrera y Grupo</h1>

<select id="division" onchange="cargarCarreras()">
    <option disabled selected> Selecciona una división académica</option>
    <%
        DivisionAcademicaDao divisionAcademicaDao = new DivisionAcademicaDao();
        ArrayList<DivisionAcademica> divisiones = divisionAcademicaDao.getAll();
        for(DivisionAcademica division : divisiones) {
    %>
    <option value="<%= division.getId_division_academica() %>"><%= division.getDivision_academica() %></option>
    <% } %>
</select>

<select id="carrera" onchange="cargarGrupos()" disabled>
    <option disabled selected> Selecciona una carrera</option>
</select>

<select id="grupo" disabled>
    <option disabled selected> Selecciona un grupo</option>
</select>

<script>
    function cargarCarreras() {
        var divisionId = $('#division').val();
        if(divisionId) {
            $.ajax({
                url: '${pageContext.request.contextPath}/CarrerasServlet',
                data: { divisionId: divisionId },
                success: function(response) {
                    console.log("Respuesta recibida:", response);
                    $('#carrera').html(response);
                    $('#carrera').prop('disabled', false);
                    $('#grupo').html('<option value="">Selecciona un grupo</option>');
                    $('#grupo').prop('disabled', true);
                },
                error: function(xhr, status, error) {
                    console.error("Error al cargar carreras:", status, error);
                }
            });
        } else {
            // ... código existente ...
        }
    }

    function cargarGrupos() {
        var divisionId = $('#division').val();
        var carreraId = $('#carrera').val();
        if(divisionId && carreraId) {
            $.ajax({
                url: '${pageContext.request.contextPath}/GruposServlet',
                data: { divisionId: divisionId, carreraId: carreraId },
                success: function(response) {
                    $('#grupo').html(response);
                    $('#grupo').prop('disabled', false);
                }
            });
        } else {
            $('#grupo').html('<option value="">Selecciona un Grupo</option>');
            $('#grupo').prop('disabled', true);
        }
    }
</script>
</body>
</html>