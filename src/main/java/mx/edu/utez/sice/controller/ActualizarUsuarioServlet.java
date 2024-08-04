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

@WebServlet(name = "ActualizarUsuarioServlet", value = "/ActualizarUsuarioServlet")
public class ActualizarUsuarioServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // obtenemos el id del usuario, recabado por parte del link "actualizar" que está dentro de la tabla de
        // la vista gestionUsuario.jsp
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));
        // el id identifica al usuario y necesitamos un método Para obtener su información (DAO)
        UsuarioDao dao = new UsuarioDao();
        Usuario usuario = dao.getOne(id_usuario);
        // llevamos la información a un formulario que está en la vista modificarUsuario.jsp para actualizar
        HttpSession sesion = req.getSession();
        sesion.setAttribute("usuario", usuario);
        // aqui vamos a actualizar los datos del usuario anteriormente seleccionado
        resp.sendRedirect("JSP/Administrador/modificarUsuario.jsp");
        // proseguimos con un update
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
            resp.sendRedirect("JSP/Administrador/registroUsuario.jsp");
        }
        if (Boolean.parseBoolean(req.getParameter("estado"))){
            u.setEstado(1);
        }else{
            u.setEstado(0);
        }
        u.setId_tipo_usuario(Integer.parseInt(req.getParameter("id_tipo_usuario")));
        //Debemos mandar a llamar un DAO que me permita insertar
        UsuarioDao dao = new UsuarioDao();
        dao.updateDocenteAdministrativo(u);
        /*
        //Ver si esta haciendo un insert o un update
        if(req.getParameter("operacion") != "") {
            //es un update
            u.setId_usuario(Integer.parseInt(req.getParameter("operacion")));
            dao.updateDocenteAdministrativo(u);
        }else{
            //Es un insert

        }*/
        resp.sendRedirect("index.jsp");
        req.getSession().setAttribute("mensaje","se actualizo");
    }
}
