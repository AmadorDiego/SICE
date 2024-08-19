package mx.edu.utez.sice.controller;// getGrupos.java
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sice.dao.GrupoDao;
import mx.edu.utez.sice.model.Grupo;

@WebServlet(name = "GruposServlet", value = "/GruposServlet")
public class GruposServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String divisionId = request.getParameter("divisionId");
        String carreraId = request.getParameter("carreraId");
        GrupoDao grupoDao = new GrupoDao();
        ArrayList<Grupo> grupos = grupoDao.getAll(Integer.parseInt(carreraId));

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<option value='' disabled selected>Selecciona un Grupo</option>");
        for(Grupo grupo : grupos) {
            out.println("<option value='" + grupo.getId_grupo() + "'>" + grupo.getGrado()+grupo.getGrupo() + "</option>");
        }
    }
}