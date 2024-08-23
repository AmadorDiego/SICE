<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.PreguntaDao" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page import="mx.edu.utez.sice.dao.OpcionDao" %>
<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 30/07/2024
  Time: 11:34 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Crear Examen</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Docentes.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>

    <STYLE>
        #banco-preguntas {
            height: 100vh;
            overflow-y: auto;
        }

        #lista-banco-preguntas li {
            margin-bottom: 10px;
        }

        #lista-banco-preguntas input[type="checkbox"] {
            margin-right: 10px;
        }
    </STYLE>

    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexDocente");
    %>


</head>
<body>
<!--/////////////////////////////////////////// Fondo //////////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>

<%
    HttpSession session1 = request.getSession();
    Examen examen  = (Examen) session1.getAttribute("examen");
    ArrayList<Pregunta> listaPreguntas = (ArrayList<Pregunta>) session1.getAttribute("listaPreguntas");

%>

<!--///////////////////////////////////////// Contenido ////////////////////////////////////////////////////-->
        <div class="container md">
            <div class="row">
                <div class="col-12">
                    <a  class="btn btn-primary bg-blue-utz text-white h5 g-2 mt-4 h6" href="indexDocente.jsp">
                        <span class="material-symbols-rounded">arrow_back</span>
                    </a>
                </div>

                <!-- Banco de preguntas -->
                <div class="col-md-3">
                    <div id="banco-preguntas" class="bg-light p-3 rounded">
                        <h3>Banco de Preguntas</h3>
                        <input type="text" id="buscar-banco" class="form-control mb-3" placeholder="Buscar pregunta...">
                        <ul id="lista-banco-preguntas" class="list-unstyled">
                            <%
                                PreguntaDao bancoPreguntaDao = new PreguntaDao();
                                ArrayList<Pregunta> todasLasPreguntas = bancoPreguntaDao.getAll();
                                int i = 0;
                                for (Pregunta pregunta : todasLasPreguntas) {
                                    i++;
                            %>
                            <li>
                                <input type="checkbox" name="preguntasSeleccionadas" value="<%=pregunta.getId_pregunta()%>"
                                       id="pregunta-<%=pregunta.getId_pregunta()%>">
                                <label for="pregunta-<%=pregunta.getId_pregunta()%>">
                                    Pregunta <%=i%>: <%=pregunta.getPregunta()%>
                                </label>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                </div>


                <div class="col-md-9">
                    <div class="rounded-5 p-3 bg-green-utz g-3">
                        <h1 class="mb-4 blue-utz">Crear Nuevo Examen</h1>
                        <br>
                        <form method="post" action="../../ExamenServlet" class="mb-4">
                            <div id="mensajeResultado" class="alert" style="display: none;"></div>

                            <input type="hidden" id="id_usuario" name="id_usuario" value="<%=usuario.getId_usuario()%>">
                            <input type="hidden" id="cantidad_preguntas" name="cantidad_preguntas" value="0">

                            <div class="mb-3">
                                <label class="form-label text-white h5" for="nombre_examen ">Nombre del Examen:</label>
                                <input class="form-control" type="text" id="nombre_examen " name="nombre_examen" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label text-white h5" for="descripcion">Descripción:</label>
                                <textarea class="form-control fixed-size-textarea" id="descripcion" name="descripcion" rows="4" style="resize: none;"></textarea>
                            </div>

                            <!--Por este medio se activa el examen-->
                            <!--<div class="mb-3">
                                <label class="form-label text-white h5" for="estado">Estado:</label>
                                <select class="form-control" id="estado" name="estado">
                                    <option value="1">Activo</option>
                                    <option value="0">Borrador</option>
                                </select>
                            </div>-->

                            <div id="id_preguntas" class="mb-3 mt-4">
                                <!--Aqui se van agregando las preguntas que se vayan creando-->
                            </div>

                            <div class="mt-5">
                                <button type="button" class="btn btn-primary blue-utz me-2 text-white" onclick="agregarPregunta('cerrada')">Pregunta cerrada</button>
                                <button type="button" class="btn btn-secondary gray-SICE text-white" onclick="agregarPregunta('abierta')">Pregunta abierta</button>
                            </div>
                            <!-- <div class="mt-3">
                                <button type="button" id="guardarCambios"
                                        class="btn btn-primary bg-blue-utz h6" href="indexDocente">Guardar cambios</button>
                            </div> -->
                            <button class="btn btn-primary bg-blue-utz mt-3 d-flex" type="submit" value="Crear">
                                <h6 class="d-block me-2">Crear </h6>
                                <span class="material-symbols-rounded d-block">check_circle</span>
                            </button>
                        </form>
                    </div>

                </div>

            </div>
        </div>

        <script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
        <script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
        <script src="${pageContext.request.contextPath}/JS/ScriptExamen.js"></script>

</body>
</html>

