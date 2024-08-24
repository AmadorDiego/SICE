package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.GrupoDao;

import java.io.IOException;

@WebServlet (name = "ActualizarGrupoServlet", value = "/ActualizarGrupoServlet")
public class ActualizarGrupoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_grupo = Integer.parseInt(req.getParameter("id_grupo"));
        int id_carrera = Integer.parseInt(req.getParameter("id_carrera"));
        int grado = Integer.parseInt(req.getParameter("grado"));
        String grupo = req.getParameter("grupo");
        int id_periodo = Integer.parseInt(req.getParameter("id_periodo"));
        GrupoDao grupoDao = new GrupoDao();
        HttpSession sesion = req.getSession();
        if (grupoDao.updateGrupo(id_carrera, grado, grupo, id_periodo, id_grupo)){
            sesion.setAttribute("mensajeAdministrador","Se actualizó correctamente el grupo");
            sesion.setAttribute("flag", true);
        }else {
            sesion.setAttribute("mensajeAdministrador","Ocurrio un error al actualizar el grupo");
            sesion.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Administrador/grupos.jsp");
    }
}
