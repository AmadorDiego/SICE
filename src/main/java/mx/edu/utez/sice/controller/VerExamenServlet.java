package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Pregunta;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "VerExamenServlet",value = "/VerExamenServlet")
public class VerExamenServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        Examen examen = new Examen();
        Pregunta preguntas = new Pregunta();

        req.setAttribute("examen", examen);
        req.setAttribute("preguntas",preguntas);
        req.getRequestDispatcher("/verExamen.jsp").forward(req, resp);



        /*List<Pregunta>preguntasAbiertas = ExamenDao.getPreguntasAbiertas(id_examen);
        List<Pregunta>preguntasCerradas = ExamenDao.getPreguntasCerradas(id_examen);*/
        /*req.setAttribute("examen", examen);
        req.setAttribute("preguntasAbiertas", preguntasAbiertas);
        req.setAttribute("preguntasCerradas", preguntasCerradas);
        req.getRequestDispatcher("verExamen.jsp").forward(req, resp);*/

    }
}
