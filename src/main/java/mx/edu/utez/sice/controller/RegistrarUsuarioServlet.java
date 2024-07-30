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

@WebServlet(name = "RegistrarUsuarioServlet", value = "/sign_in")
public class RegistrarUsuarioServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1) obtener la información del usuario
        int id = Integer.parseInt(req.getParameter("id"));
        //Si el id identifica a X usuario necesitamos un método
        //Para obtener su información (DAO)
        UsuarioDao dao = new UsuarioDao();
        Usuario u = dao.getOne(id);

        // 2) llevar la info a un formulario
        HttpSession sesion = req.getSession();
        sesion.setAttribute("usuario", u);
        //Aqui sera donde vamos a editar la información a modificar
        resp.sendRedirect("modificarUsuario.jsp");

        // 3) update (se va a hacer en otro servlet)
    }

    //Esto es para inicio de sesión
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario u = new Usuario();
        u.setNombre_usuario(req.getParameter("nombre_usuario"));
        u.setApellido_usuario(req.getParameter("apellido_usuario"));
        u.setCorreo_electronico(req.getParameter("correo_electronico"));
        if(req.getParameter("contrasena1").equals(req.getParameter("contrasena2"))){
            u.setContrasena(req.getParameter("contrasena1"));
        }else{
            //Mensaje para visar que las contras no son iguales
            resp.sendRedirect("registroUsuario.jsp");
        }
        u.setEstado(true);
        u.setId_tipo_usuario(Integer.parseInt(req.getParameter("tipo_usuario_id_tipo_usuario")));
        //Debemos mandar a llamar un DAO que me permita insertar
        UsuarioDao dao = new UsuarioDao();
        dao.insertDocenteAdministrativo(u);

        //Ver si esta haciendo un insert o un update
        if(req.getParameter("operacion") != "") {
            //es un update
            u.setId_usuario(Integer.parseInt(req.getParameter("operacion")));
            dao.updateDocenteAdministrativo(u);
        }else{
            //Es un insert

        }
        resp.sendRedirect("index.jsp");
        req.getSession().setAttribute("mensaje","se inserto");
    }
}
