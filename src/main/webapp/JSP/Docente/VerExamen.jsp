<%@ page import="mx.edu.utez.sice.dao.OpcionDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.PreguntaDao" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--
Created by IntelliJ IDEA.
User: corey
Date: 13/08/2024
Time: 10:42 p. m.
To change this template use File | Settings | File Templates.
-->
<html>
<head>
    <title>Ver Examen</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Docentes.css">
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexDocente");
        if (usuario != null){
        Examen examen = new Examen();%>
    <style>
        .btn-primary {
            background-color: #003e81;
        }
    </style>
</head>
<body>
<!--//////////////////////////////////////// Fondo ///////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>
<!--////////////////////////////////////// Contenido //////////////////////////////////////////////////-->
<div class="container-md">
    <div class="row">
        <div class="col-12">
            <%
                Examen examen1 = (Examen) request.getAttribute("examen");
                ArrayList<Pregunta> preguntas = (ArrayList<Pregunta>) request.getAttribute("preguntas");
            %>

            <form class="form-control rounded-5 p-3 mt-4 border-0 bg-green-utz" method="post" action="../../ModificarExamenServlet">
                <!--<h1 class="blue-utz">Modificar Examen</h1>
                <br>
                <label class="form-label text-white h5">Título del examen: </label>-->
                <input class="form-control" type="text" name="nombre_examen" required value="<%=examen.getNombre_examen()%>" placeholder="<%=examen.getNombre_examen()%>">
                <br>
                <!--<label class="form-label text-white h5">Descripción: </label>-->
                <input class="form-control" type="text" name="descripcion" required value="<%=examen.getDescripcion()%>" placeholder="<%=examen.getDescripcion()%>">
                <br>
                <%
                    PreguntaDao preguntaDao = new PreguntaDao();
                    ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());
                    int i = 0;
                    for (Pregunta pregunta : listaPreguntas) {
                        i++; %>
                <div>
                    <label class="form-label text-white h5">Pregunta <%=i%>:  </label>
                    <input class="form-control" type="text" name="pregunta_<%=i%>" required value="<%=pregunta.getPregunta()%>" placeholder="<%=pregunta.getPregunta()%>">
                </div>
                <%
                    if (pregunta.getId_tipo_pregunta()==2){
                        OpcionDao opcionDao = new OpcionDao();
                        ArrayList<Opcion> listaOpciones = opcionDao.getAll(pregunta.getId_pregunta());
                        int j = 0;
                        for (Opcion opcion : listaOpciones) {
                            PreguntaOpcion preguntaOpcion = opcionDao.getOpcionCorrecta(opcion.getId_opcion());
                            j++; %>
                <div class="mb-2">
                    <input type="radio" name="pregunta_<%=i%>_opcion_<%=j%>_correcta_<%=preguntaOpcion.getCorrecta()%>" value="" <%if (preguntaOpcion.getCorrecta()==1){%>checked<%}%> >
                    <input class="form-control" type="text" name="pregunta_<%=i%>_opcion_<%=j%>" required value="<%=opcion.getOpcion()%>" placeholder="<%=opcion.getOpcion()%>">
                </div>
                <%}
                }
                }
                %>
            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/JS/VerExamen.js"></script>

</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>