
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.GrupoDao" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Asignar Examen</title>
  <link href="../../CSS/bootstrap.css" rel="stylesheet">
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

<%
  HttpSession sesion = request.getSession();
  Examen examen = (Examen) sesion.getAttribute("examen");
  Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexDocente");
%>

<div class="full-width-navbar">
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
      <a class="navbar-brand" href="#"></a>
    </div>
  </nav>
</div>

<%DivisionAcademicaDao divisionAcademicaDao = new DivisionAcademicaDao();
  ArrayList<DivisionAcademica> divisiones = divisionAcademicaDao.getAll();%>

<div class="container">
  <br>
  <h1><%=examen.getNombre_examen()%></h1>

  <a class="btn btn-primary" href="indexDocente.jsp"> Regresar </a>
  <div class="row">
    <div class="col-md-11 col-12 p-3">
      <form method="post" action="../../AsignarGrupoExamenServlet" id="asignar_examen">
        <div>
          <table class="table">
            <thead>
            <tr>
              <th scope="col">Division</th>
              <th scope="col" class="w-75">Carrera</th>
              <th scope="col">Grupo</th>
              <th scope="col">Seleccionar</th>
            </tr>
            </thead>
            <tbody>

            <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////// -->
            <%
              for (DivisionAcademica divisionAcademica : divisiones) {%> <tr> <%
              CarreraDao carreraDao = new CarreraDao();
              ArrayList<Carrera> carreras = carreraDao.getAll(divisionAcademica.getId_division_academica());
              for (Carrera carrera : carreras) {
                GrupoDao grupoDao = new GrupoDao();
                ArrayList<Grupo> grupos = grupoDao.getAll(carrera.getId_carrera());
                for (Grupo grupo : grupos) {
                  if (grupoDao.imparteDocenteGrupo(grupo.getId_grupo(), usuario.getId_usuario())){%>
              <th scope="row">
                <%
                  switch (divisionAcademica.getId_division_academica()){
                    case 1:%>
                DATID<%
                  break;
                case 2:%>
                DAMI<%
                  break;
                case 3:%>
                DACEA<%
                  break;
                case 4:%>
                DATEFI<%
                  break;
                default:%>
                divisionAcademica.getDivision_academica()<%
                    break;}%></th>
              <td>
                <input type="text" class="form-control" disabled value="<%=carrera.getCarrera()%>">
              </td>
              <td><%=grupo.getGrado()+"-"+grupo.getGrupo()%></td>
              <td>
                <input type="hidden" name="id_examen" value="<%=examen.getId_examen()%>">
                <div class="form-check form-switch">
                  <input class="form-check-input" type="checkbox" role="switch" name="id_grupo[]" value="<%=grupo.getId_grupo()%>">
                </div>
              </td>
            </tr><%}}}}%>
            </tbody>
          </table>
        </div>
        <input type="submit" form="asignar_examen" class="btn btn-primary bg-blue-utz justify-content-center mb-0">
      </form>
    </div>

    <div class="col-md-1 col-12 p-3">
        <div>
          <table class="table">
            <thead>
            <tr>
              <th scope="col">Alumnos</th>
            </tr>
            </thead>
            <tbody>
            <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////// -->
            <%
              for (DivisionAcademica divisionAcademica : divisiones) {%> <tr> <%
              CarreraDao carreraDao = new CarreraDao();
              ArrayList<Carrera> carreras = carreraDao.getAll(divisionAcademica.getId_division_academica());
              for (Carrera carrera : carreras) {
                GrupoDao grupoDao = new GrupoDao();
                ArrayList<Grupo> grupos = grupoDao.getAll(carrera.getId_carrera());
                for (Grupo grupo : grupos) {
                  if (grupoDao.imparteDocenteGrupo(grupo.getId_grupo(), usuario.getId_usuario())){%>
              <th scope="row">
                <button type="button" class="btn btn-primary bg-blue-utz justify-content-center mb-0"
                        data-bs-toggle="modal" data-bs-target="#alumnos_grupo_<%= grupo.getId_grupo() %>">
                  <span class="material-symbols-rounded justify-content-center">ver</span>
                </button>

                <!-- Modal para asignar examen a alumnos -->
                <div class="modal fade" id="alumnos_grupo_<%= grupo.getId_grupo() %>" tabindex="-1"
                     aria-labelledby="exampleModalLabel_<%= grupo.getId_grupo()  %>" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header bg-blue-utz">
                        <h1 class="modal-title fs-5 text-white" id="exampleModalLabel_<%= grupo.getId_grupo()  %>">
                          Alumnos del <%=grupo.getGrado()+"-"+grupo.getGrupo()%>:
                        </h1>
                        <button type="button" class="btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                      </div>
                      <div class="modal-body">
                        <form method="post" action="../../AsignarAlumnoExamenServlet" id="asignar_examen_alumno">
                          <table class="table">
                            <thead>
                            <tr>
                              <th scope="col">Correo electrónico:</th>
                              <th scope="col">Nombre:</th>
                              <th scope="col">Asignar</th>
                            </tr>
                            </thead>
                            <tbody>
                            <input type="hidden" name="id_examen" value="<%=examen.getId_examen()%>">
                            <%
                              UsuarioDao usuarioDao = new UsuarioDao();
                              ArrayList<Usuario> alumnos = usuarioDao.getAllAlumnosConGrupo(grupo.getId_grupo());
                              for (Usuario u : alumnos) {%>
                            <tr>
                              <th scope="row"><%=u.getCorreo_electronico()%></th>
                              <td><%=u.getApellido_usuario()+" "+u.getNombre_usuario()%></td>
                              <td>
                                <div class="form-check form-switch">
                                  <input class="form-check-input" type="checkbox" role="switch" name="id_usuario" value="<%=u.getId_usuario()%>">
                                </div>
                              </td>
                            </tr>
                            <%}%>
                            </tbody>
                          </table>
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="botonCancelar_<%= grupo.getId_grupo() %>">
                          Cancelar
                        </button>
                        <button type="submit" form="asignar_examen_alumno" class="btn btn-primary bg-blue-utz justify-content-center mb-0" value="Asignar">
                          <p class="mb-0">Asignar</p>
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </th>
            </tr><%}}}}%>
            </tbody>
          </table>
        </div>
    </div>
  </div>
</div>
<script src="../../JS/bootstrap.bundle.min.js"></script>
</body>
</html>






