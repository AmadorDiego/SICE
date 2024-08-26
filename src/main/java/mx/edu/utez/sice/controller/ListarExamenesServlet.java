package mx.edu.utez.sice.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.dao.PreguntaDao;
import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.Usuario;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet (name =  "ListarExamenesServlet",value = "/ListarExamenesServlet")
public class ListarExamenesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            resp.sendRedirect("loginSICE.jsp"); // Redirige al login si no hay usuario en sesión
            return;
        }
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        ExamenDao examenDao = new ExamenDao();
        Examen examen = examenDao.getOne(id_examen);
        PreguntaDao preguntaDao = new PreguntaDao();
        ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());

        HttpSession sesion = req.getSession();
        sesion.setAttribute("examen", examen);
        sesion.setAttribute("preguntas", listaPreguntas);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/JSP/Docente/bancoPreguntas.jsp");
        dispatcher.forward(req, resp);

    }
}
