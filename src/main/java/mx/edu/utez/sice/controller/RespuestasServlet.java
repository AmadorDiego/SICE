package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.dao.OpcionDao;
import mx.edu.utez.sice.dao.PreguntaDao;
import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Opcion;
import mx.edu.utez.sice.model.Pregunta;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet (name = "RespuestasServlet", value = "/RespuestasServlet")
public class RespuestasServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // obtenemos el id del usuario, recabado por parte del link "actualizar" que está dentro de la tabla de
        // la vista indexAdministrador.jsp
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        // el id identifica al usuario y necesitamos un método Para obtener su información (DAO)
        ExamenDao examenDao = new ExamenDao();
        Examen examen = examenDao.getOne(id_examen);

        PreguntaDao preguntaDao = new PreguntaDao();
        ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());
        OpcionDao opcionDao = new OpcionDao();
        ArrayList<Opcion> listaOpciones = opcionDao.getAll(examen.getId_examen());

        HttpSession sesion = req.getSession();
        sesion.setAttribute("examen", examen);

        // aqui vamos a actualizar los datos del usuario anteriormente seleccionado
        resp.sendRedirect("JSP/Docente/alumnosContestado.jsp");
        // proseguimos con un update
    }
}
