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

    // para modificar la información se necesita: (se ocupan 2 servlets) (el req.getParameter siempre regresa cadenas)
    // 1) obtener la información del usuario


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario")); //agarra el id del gestion usuario.jsp
        //si el id a X ususario necesitamos un metodo para obtener su información (DAO)
        UsuarioDao dao = new UsuarioDao();
        Usuario u = dao.getOne(id_usuario);

        // 2) llevar la indo a un formulario
        HttpSession sesion = req.getSession();
        sesion.setAttribute("usuario", u);
        //aqui sera donde vamos a editar la información a modificar
        resp.sendRedirect("registroUsuario.jsp");
        // 3) update
    }


    /*@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario u = new Usuario();
        u.setNombre(req.getParameter("nombre"));
        u.setCorreo_electronico(req.getParameter("correo_electronico"));

        u.setEstado(true);
        UsuarioDao dao = new UsuarioDao();
        if(dao.insert(u)){
            resp.sendRedirect("usuario.jsp");
        }else{
            resp.sendRedirect("registroUsuario.jsp");
        }
    }
    if(req.getParameter("operacion") != ""){
        u.setId(Integer.parseInt(req.getParameter("operacion")))
        dao.update();
    }else{
        dao.insert(u);
    }
    resp.sendRedirect("index.jsp")*/

    //Esto es para inicio de sesión
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario u = new Usuario();
        u.setNombre(req.getParameter("nombre"));
        u.setCorreo_electronico(req.getParameter("correo"));
        if(req.getParameter("contra1").equals(req.getParameter("contra2"))){
            u.setContrasena(req.getParameter("contra1"));
        }else{
            //Mensaje para visar que las contras no son iguales
            resp.sendRedirect("registroUsuario.jsp");
        }
        u.setEstado(true);

        //Debemos mandar a llamar un DAO que me permita insertar
        UsuarioDao dao = new UsuarioDao();

        //Ver si esta haciendo un insert o un update
        if(req.getParameter("operacion") != "") {
            //es un update
            u.setId_usuario(Integer.parseInt(req.getParameter("operacion")));
            dao.update(u);
        }else{
            //Es un insert
            dao.insert(u);
        }
        resp.sendRedirect("index.jsp");
    }
}
