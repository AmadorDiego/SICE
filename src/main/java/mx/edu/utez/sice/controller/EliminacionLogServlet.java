package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.UsuarioDao;

import java.io.IOException;

@WebServlet(name = "EliminacionLogServlet", value = "/EliminacionLogServlet")
public class EliminacionLogServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));
        UsuarioDao dao = new UsuarioDao();
        HttpSession sesion = req.getSession();
        if(dao.eliminarLogico(id_usuario)){
            sesion.setAttribute("mensaje","Usuario eliminado logicamente con exito");
        }else{
            sesion.setAttribute("mensaje","Fallo la eliminación logica");
        }
        resp.sendRedirect("JSP/Administrador/indexAdministrador.jsp");
    }
}
