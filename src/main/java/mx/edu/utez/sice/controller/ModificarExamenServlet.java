package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.dao.OpcionDao;
import mx.edu.utez.sice.dao.PreguntaDao;
import mx.edu.utez.sice.dao.UsuarioDao;
import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Opcion;
import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.Usuario;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet (name = "ModificarExamenServlet",value = "/ModificarExamenServlet")
public class ModificarExamenServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // obtenemos el id del usuario, recabado por parte del link "actualizar" que está dentro de la tabla de
        // la vista indexAdministrador.jsp
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        // el id identifica al usuario y necesitamos un método Para obtener su información (DAO)
        ExamenDao examenDao = new ExamenDao();
        Examen examen = examenDao.getOne(id_examen);
        PreguntaDao preguntaDao = new PreguntaDao();
        ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());
        OpcionDao opcionDao = new OpcionDao();
        ArrayList<Opcion> listaOpciones = opcionDao.getAll(examen.getId_examen());

        // llevamos la información a un formulario que está en la vista actualizarUsuario.jsp para actualizar
        HttpSession sesion = req.getSession();
        sesion.setAttribute("examen", examen);
        sesion.setAttribute("preguntas", listaPreguntas);
        sesion.setAttribute("opciones", listaOpciones);

        // aqui vamos a actualizar los datos del usuario anteriormente seleccionado
        resp.sendRedirect("JSP/Docente/personalizarExamen.jsp");
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
