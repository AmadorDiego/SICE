<% Examen examen = null; %>
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>

Created by IntelliJ IDEA.
  User: corey
  Date: 13/08/2024
  Time: 10:42 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ver Examen</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Docentes.css">
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
    %>
</head>
<body>
<!--//////////////////////////////////////// Fondo ///////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>
<!--////////////////////////////////////// Contenido //////////////////////////////////////////////////-->
<div class="container">
    <h1>${examen.getNombre_examen()}</h1>
    <form method="post" action="${pageContext.request.contextPath}/VerExamenServlet">
        <input type="hidden" name="examen_id" value="${examen.getId()}">
        <c:forEach var="pregunta" items="${preguntas}">
            <c:choose>
                <c:when test="${pregunta.getTipo() == 1}">
                    <div class="mb-3">
                        <label class="form-label">${pregunta.getTexto()}</label>
                        <input type="text" class="form-control" name="respuesta_abierta_${pregunta.getId()}">
                    </div>
                </c:when>
                <c:when test="${pregunta.getTipo() == 2}">
                    <div class="mb-3">
                        <label class="form-label">${pregunta.getTexto()}</label>
                        <c:forEach var="opcion" items="${examenDao.getOpcionesByPregunta(pregunta.getId())}">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="respuesta_opcion_${pregunta.getId()}" value="${opcion.getId()}">
                                <label class="form-check-label">${opcion.getTexto()}</label>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
            </c:choose>
        </c:forEach>
        <button type="submit" class="btn btn-primary">Enviar</button>
    </form>
</div>

<script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/JS/VerExamen.js"></script>

</body>
</html>
