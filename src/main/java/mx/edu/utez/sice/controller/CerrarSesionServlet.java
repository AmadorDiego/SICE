package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = "/CerrarSesionServlet")
public class CerrarSesionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener la sesión actual, si existe
        HttpSession sesion = request.getSession(false);

        // Si hay una sesión válida, invalidarla
        if (sesion != null) {
            sesion.invalidate();
            sesion = request.getSession();
            sesion.setAttribute("mensajeInicio", "Se cerró sesión correctamente");
        }

        // Redirigir a la página de inicio de sesión
        response.sendRedirect("loginSICE.jsp");
    }
}
