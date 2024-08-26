<%@ page import="mx.edu.utez.sice.model.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 26/08/2024
  Time: 07:08 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.ExamenDao" %>
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="mx.edu.utez.sice.dao.PreguntaDao" %>
<%@ page import="mx.edu.utez.sice.model.Pregunta" %>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>

    <title>Bienvenido docente</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/Docentes.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>

</head>
<div class="container-xl">
    <div class="accordion" id="accordionExamen">
        <%
            Examen examen = (Examen) session.getAttribute("examen");
            ArrayList<Pregunta> listaPreguntas = (ArrayList<Pregunta>) session.getAttribute("preguntas");

            if (examen != null && listaPreguntas != null && !listaPreguntas.isEmpty()) {
        %>
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingExamen">
                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseExamen" aria-expanded="true"
                        aria-controls="collapseExamen">
                    <%= examen.getNombre_examen() %>
                </button>
            </h2>
            <div id="collapseExamen" class="accordion-collapse collapse show"
                 aria-labelledby="headingExamen">
                <div class="accordion-body">
                    <ul class="list-group">
                        <%
                            for (Pregunta pregunta : listaPreguntas) {
                        %>
                        <li class="list-group-item"><%= pregunta.getPregunta() %></li>
                        <%
                            }
                        %>
                    </ul>
                    <div class="mt-3">
                        <a href="ModificarExamenServlet?id_examen=<%= examen.getId_examen() %>"
                           class="btn btn-primary">Usar</a>
                    </div>
                </div>
            </div>
        </div>
        <%
        } else {
        %>
        <div class="alert alert-info" role="alert">
            No hay examen o preguntas disponibles.
        </div>
        <%
            }
        %>
    </div>
</div>

<script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
</body>
</html>

