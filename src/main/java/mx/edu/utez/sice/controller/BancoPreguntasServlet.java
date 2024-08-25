package mx.edu.utez.sice.controller;


import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.dao.OpcionDao;
import mx.edu.utez.sice.dao.PreguntaDao;
import mx.edu.utez.sice.dao.PreguntaOpcionDao;
import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Opcion;
import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.PreguntaOpcion;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "BancoPreguntasServlet", value = "/BancoPreguntasServlet")
public class BancoPreguntasServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        int id_pregunta = Integer.parseInt(req.getParameter("id_pregunta"));

        PreguntaDao preguntaDao = new PreguntaDao();
        OpcionDao opcionDao = new OpcionDao();

        Pregunta pregunta = preguntaDao.getOne(id_pregunta);
        ArrayList<Opcion> opciones = opcionDao.getAll(id_pregunta);

        JsonObject jsonObject = new JsonObject();
        jsonObject.add("pregunta",new Gson().toJsonTree(pregunta));
        jsonObject.add("opciones",new Gson().toJsonTree(opciones));

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new Gson().toJson(jsonObject));

    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        //String[] preguntasSeleccionadas = req.getParameterValues("preguntasSeleccionadas");
        PreguntaDao preguntaDao = new PreguntaDao();
        ExamenDao examenDao = new ExamenDao();
        OpcionDao opcionDao = new OpcionDao();
        PreguntaOpcionDao preguntaOpcionDao = new PreguntaOpcionDao();

        Examen examen = examenDao.getOne(id_examen);

        ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(id_examen);
        int id_pregunta = Integer.parseInt(req.getParameter("id_pregunta"));
        ArrayList<Opcion> listaOpciones = opcionDao.getAll(id_pregunta);
        ArrayList<PreguntaOpcion> listaOpcionesPreguntas = preguntaOpcionDao.getAll();

        HttpSession sesion = req.getSession();
        sesion.setAttribute("preguntas", listaPreguntas);
        sesion.setAttribute("listaOpciones", listaOpciones);
        sesion.setAttribute("listaOpcionesPreguntas", listaOpcionesPreguntas);
        sesion.setAttribute("examen", examen);
        sesion.setAttribute("id_examen", id_examen);
        resp.sendRedirect("JSP/Docente/examen.jsp");
    }
}
