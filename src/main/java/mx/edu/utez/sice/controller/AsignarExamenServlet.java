package mx.edu.utez.sice.controller;

import com.google.gson.FieldNamingPolicy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.*;
import mx.edu.utez.sice.model.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name="AsignarExamenServlet", value = "/asignarExamen")
public class AsignarExamenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        Examen examen = new Examen();
        ExamenDao examenDao = new ExamenDao();
        examenDao.getOne(id_examen);
        HttpSession sesion = req.getSession();
        sesion.setAttribute("examen", examen);
        resp.sendRedirect("JSP/Docente/AsignarExamen.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}