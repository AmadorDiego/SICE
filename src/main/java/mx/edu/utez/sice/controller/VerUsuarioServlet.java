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

@WebServlet (name = "VerUsuarioServlet", value = "/VerUsuarioServlet")
public class VerUsuarioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // obtenemos el id del usuario, recabado por parte del link "ver" que está dentro de la tabla de
        // la vista indexAdministrador.jsp
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));
        // el id identifica al usuario y necesitamos un método Para obtener su información (DAO)
        UsuarioDao dao = new UsuarioDao();
        Usuario usuario = dao.getOne(id_usuario);
        // llevamos la información a una vista que está en la vista verUsuario.jsp
        HttpSession sesion = req.getSession();
        sesion.setAttribute("usuario", usuario);
        // aqui vamos a ver los datos del usuario anteriormente seleccionado
        resp.sendRedirect("JSP/Administrador/verUsuario.jsp");
        // proseguimos con un update
    }
}
