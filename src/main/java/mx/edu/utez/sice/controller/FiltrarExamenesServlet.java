package mx.edu.utez.sice.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.model.Examen;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/filtrarExamenes")
public class FiltrarExamenesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idGrado = Integer.parseInt(request.getParameter("id_grado"));
        int idGrupo = Integer.parseInt(request.getParameter("id_grupo"));
        int idDivision = Integer.parseInt(request.getParameter("id_division"));
        int idCarrera = Integer.parseInt(request.getParameter("id_carrera"));
        int idExamen = Integer.parseInt(request.getParameter("id_examen"));

        ExamenDao examenDao = new ExamenDao();
        List<Examen> listaExamenes = examenDao.filtrarExamenes(idGrado, idGrupo, idDivision, idCarrera, idExamen);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new Gson().toJson(listaExamenes);
        response.getWriter().write(json);
    }
}
