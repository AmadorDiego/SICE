package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.UsuarioDao;
import mx.edu.utez.sice.model.Usuario;

import java.io.IOException;

@WebServlet (name = "RestaurarUsuarioServlet", value = "/RestaurarUsuarioServlet")
public class RestaurarUsuarioServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));
        UsuarioDao dao = new UsuarioDao();
        HttpSession sesion = req.getSession();
        if(dao.restaurarUsuario(id_usuario)){
            sesion.setAttribute("mensaje","Usuario restaurado con exito");
        }else{
            sesion.setAttribute("mensaje","Fallo la restauración");

        }
        resp.sendRedirect("JSP/Administrador/verUsuarioEliminado.jsp");
    }
}
