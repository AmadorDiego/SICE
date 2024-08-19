package mx.edu.utez.sice.controller;// getCarreras.java
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sice.dao.CarreraDao;
import mx.edu.utez.sice.model.Carrera;

@WebServlet(name = "CarrerasServlet", value = "/CarrerasServlet")
public class CarrerasServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");

        String divisionId = request.getParameter("divisionId");
        System.out.println("CarrerasServlet llamado con divisionId: " + divisionId);

        CarreraDao carreraDAO = new CarreraDao();
        ArrayList<Carrera> carreras = carreraDAO.getAll(Integer.parseInt(divisionId));
        System.out.println("Número de carreras obtenidas: " + carreras.size());

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<option value=''disabled selected>Selecciona una Carrera</option>");
        for(Carrera carrera : carreras) {
            System.out.println("Procesando carrera: " + carrera.getId_carrera() + " - " + carrera.getCarrera());
            out.println("<option value='" + carrera.getId_carrera() + "'>" + carrera.getCarrera() + "</option>");
        }
    }
}