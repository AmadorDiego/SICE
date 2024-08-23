package mx.edu.utez.sice.controller;


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

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "BancoPreguntasServlet", value = "/BancoPreguntasServlet")
public class BancoPreguntasServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));

        PreguntaDao preguntaDao = new PreguntaDao();
        ExamenDao examenDao = new ExamenDao();
        Examen examen = examenDao.getOne(id_examen);
        ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(id_examen);

        HttpSession sesion = req.getSession();
        sesion.setAttribute("preguntas", listaPreguntas);
        sesion.setAttribute("examen", examen);
        sesion.setAttribute("id_examen", id_examen);
        resp.sendRedirect("JSP/Docente/examen.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        String[] preguntasSeleccionadas = req.getParameterValues("preguntasSeleccionadas");

        PreguntaDao preguntaDao = new PreguntaDao();
        ExamenDao examenDao = new ExamenDao();
        Examen examen = examenDao.getOne(id_examen);

        ArrayList<ArrayList<Pregunta>> listaPreguntas = new ArrayList<>();
        if (preguntasSeleccionadas != null) {
            for (String id_pregunta : preguntasSeleccionadas) {
                //Pregunta pregunta = preguntaDao.getOne(Integer.parseInt(id_pregunta));
                ArrayList<Pregunta> pregunta = preguntaDao.getAll(Integer.parseInt(id_pregunta));
                listaPreguntas.add(pregunta);
                // Aquí puedes agregar lógica para asociar la pregunta al examen en la base de datos
            }
        }

        HttpSession sesion = req.getSession();
        sesion.setAttribute("preguntas", listaPreguntas);
        sesion.setAttribute("examen", examen);
        sesion.setAttribute("id_examen", id_examen);
        resp.sendRedirect("JSP/Docente/examen.jsp");
    }
}
