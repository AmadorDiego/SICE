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

@WebServlet(name = "RegistrarUsuarioServlet", value = "/RegistrarUsuarioServlet")
public class RegistrarUsuarioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario u = new Usuario();
        u.setNombre_usuario(req.getParameter("nombre_usuario"));
        u.setApellido_usuario(req.getParameter("apellido_usuario"));
        u.setCorreo_electronico(req.getParameter("correo_electronico"));
        if(req.getParameter("contrasena1").equals(req.getParameter("contrasena2"))){
            u.setContrasena(req.getParameter("contrasena1"));
        }else{
            //Mensaje para visar que las contras no son iguales
            resp.sendRedirect("JSP/Administrador/indexAdministrador.jsp");
        }
        u.setEstado(1);
        u.setId_tipo_usuario(Integer.parseInt(req.getParameter("id_tipo_usuario")));
        //Debemos mandar a llamar un DAO que me permita insertar
        UsuarioDao dao = new UsuarioDao();
        HttpSession sesion = req.getSession();
        if (dao.insertUsuario(u)){
            sesion.setAttribute("mensaje","Se registró correctamente el usuario");
            sesion.setAttribute("flag", true);
        }else {
            sesion.setAttribute("mensaje","Ocurrio un error al registrar el usuario");
            sesion.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Administrador/indexAdministrador.jsp");
    }
}

