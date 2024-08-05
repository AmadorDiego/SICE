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
        // la vista indexAdministrador.jsp
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));
        // el id identifica al usuario y necesitamos un método Para obtener su información (DAO)
        UsuarioDao dao = new UsuarioDao();
        Usuario usuario = dao.getOne(id_usuario);
        // llevamos la información a un formulario que está en la vista actualizarUsuario.jsp para actualizar
        HttpSession sesion = req.getSession();
        sesion.setAttribute("usuario", usuario);
        // aqui vamos a actualizar los datos del usuario anteriormente seleccionado
        resp.sendRedirect("JSP/Administrador/actualizarUsuario.jsp");
        // proseguimos con un update
    }

    //Esto es para inicio de sesión
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario u = new Usuario();
        u.setId_usuario(Integer.parseInt(req.getParameter("id_usuario")));
        u.setNombre_usuario(req.getParameter("nombre_usuario"));
        u.setApellido_usuario(req.getParameter("apellido_usuario"));
        u.setCorreo_electronico(req.getParameter("correo_electronico"));
        if(req.getParameter("contrasena1").equals(req.getParameter("contrasena2"))){
            u.setContrasena(req.getParameter("contrasena1"));
        }else{
            //Mensaje para visar que las contras no son iguales
            req.getSession().setAttribute("mensaje", "Las contraseñas no coinciden");
            resp.sendRedirect("JSP/Administrador/registroUsuario.jsp");
        }
        u.setEstado(req.getParameter("estado") != null ? 1 : 0);
        u.setId_tipo_usuario(Integer.parseInt(req.getParameter("id_tipo_usuario")));
        //Debemos mandar a llamar un DAO que me permita insertar
        UsuarioDao dao = new UsuarioDao();
        HttpSession sesion = req.getSession();
        if (dao.updateDocenteAdministrador(u)) {
            sesion.setAttribute("mensaje", "Se actualizarón correctamente los datos del usuario");
            sesion.setAttribute("flag", true);
        } else {
            sesion.setAttribute("mensaje", "Ocurrio un error al actualizar los datos del usuario");
            sesion.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Administrador/indexAdministrador.jsp");
    }
}
